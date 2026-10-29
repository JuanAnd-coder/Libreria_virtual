# app.py  Flask- Versión modificada con control de acceso por rol

from flask import Flask, render_template, request, redirect, flash, session
import mysql.connector
from datetime import date, timedelta
import re
from functools import wraps


app = Flask(__name__)
app.secret_key = 'secreto123'

# Conexión a la base de datos en WAMP
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',
    database='LibraryData'
)
cursor = conn.cursor(dictionary=True)

#-------------------------------------------------------------------------------------
#Decorador
def permitido_para(*roles_permitidos):
    def decorador(f):
        @wraps(f)
        def wrapper(*args, **kwargs):
            if 'rol' not in session or session['rol'] not in roles_permitidos:
                flash("No tienes permiso para acceder a esta página.")
                return redirect('/')
            return f(*args, **kwargs)
        return wrapper
    return decorador

#--------------------------------------------------------------------------------

# Ruta para mostrar los libros
@app.route('/', methods=['GET', 'POST'])
def index():
    if 'rol' not in session:
        return redirect('/login')
    
    # Liberar reservas expiradas
    limite = date.today() - timedelta(days=2)
    cursor.execute("""
        SELECT ReservaID, LibroID FROM Reservas
        WHERE FechaReserva <= %s AND Estado = 'Activa'
    """, (limite,))
    vencidas = cursor.fetchall()

    for r in vencidas:
        cursor.execute("UPDATE Reservas SET Estado = 'Expirada' WHERE ReservaID = %s", (r['ReservaID'],))
        cursor.execute("UPDATE Libros SET Estado = 'Disponible' WHERE LibroID = %s", (r['LibroID'],))

    if vencidas:
        conn.commit()
        flash(f"{len(vencidas)} reserva(s) expiradas automáticamente.")

    # Buscador
    query = request.form.get('busqueda', '').strip() if request.method == 'POST' else ''

    if query:
        cursor.execute("""
            SELECT L.LibroID, L.Titulo, L.Categoria, L.Estado, A.Nombre AS Autor
            FROM Libros L
            JOIN Autores A ON L.AutorID = A.AutorID
            WHERE L.Titulo LIKE %s OR L.Categoria LIKE %s OR A.Nombre LIKE %s
        """, (f"%{query}%", f"%{query}%", f"%{query}%"))
    else:
        cursor.execute("""
            SELECT L.LibroID, L.Titulo, L.Categoria, L.Estado, A.Nombre AS Autor
            FROM Libros L
            JOIN Autores A ON L.AutorID = A.AutorID
        """)

    libros = cursor.fetchall()
    return render_template('index.html', libros=libros, busqueda=query)


#-------------------------------------------------------------------------------

# Ruta para agregar un nuevo libro (solo Administrador)
@app.route('/agregar', methods=['GET', 'POST'])
@permitido_para('Administrador')
def agregar_libro():

    if request.method == 'POST':
        titulo = request.form['titulo'].strip()
        categoria = request.form['categoria'].strip()
        isbn = request.form['isbn'].strip()
        estado = request.form['estado']

        nuevo_autor = request.form['nuevo_autor'].strip()
        nacionalidad_autor = request.form['nacionalidad_autor'].strip()
        autor_id = request.form.get('autor_id')

        if len(titulo) < 3:
            flash("El título debe tener al menos 3 caracteres.")
            return redirect('/agregar')

        if not re.match(r"^[A-Za-zÁÉÍÓÚÑáéíóúñ\s]+$", categoria):
            flash("La categoría solo debe contener letras.")
            return redirect('/agregar')

        if not re.match(r"^\d{10,13}$", isbn):
            flash("El ISBN debe contener solo números y tener entre 10 y 13 dígitos.")
            return redirect('/agregar')

        if nuevo_autor:
            if not re.match(r"^[A-Za-zÁÉÍÓÚÑáéíóúñ\s]+$", nuevo_autor):
                flash("El nombre del autor solo debe contener letras.")
                return redirect('/agregar')
            if not re.match(r"^[A-Za-zÁÉÍÓÚÑáéíóúñ\s]+$", nacionalidad_autor):
                flash("La nacionalidad solo debe contener letras.")
                return redirect('/agregar')
            cursor.execute("INSERT INTO Autores (Nombre, Nacionalidad) VALUES (%s, %s)", (nuevo_autor, nacionalidad_autor))
            conn.commit()
            autor_id = cursor.lastrowid

        sql = """
            INSERT INTO Libros (Titulo, AutorID, Categoria, ISBN, Estado)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(sql, (titulo, autor_id, categoria, isbn, estado))
        conn.commit()
        flash("Libro agregado correctamente.")
        return redirect('/')

    cursor.execute("SELECT AutorID, Nombre FROM Autores")
    autores = cursor.fetchall()
    return render_template('agregar.html', autores=autores)

#-------------------------------------------------------------------------------------------

# Ruta para registrar un nuevo usuario (solo Administrador)
@app.route('/usuario', methods=['GET', 'POST'])
@permitido_para('Administrador','Bibliotecario', 'Usuario')
def usuario():

    if request.method == 'POST':
        nombre = request.form['nombre'].strip()
        correo = request.form['correo'].strip()
        identificacion = request.form['identificacion'].strip()
        rol = request.form['rol']

        if len(nombre) < 3 or not re.match(r"^[A-Za-zÁÉÍÓÚÑáéíóúñ\s]+$", nombre):
            flash("El nombre debe tener al menos 3 letras y no debe contener números.")
            return redirect('/usuario')

        if not re.match(r"^[\w\.-]+@[\w\.-]+\.\w{2,4}$", correo):
            flash("El correo no tiene un formato válido.")
            return redirect('/usuario')

        if not re.match(r"^\d{6,12}$", identificacion):
            flash("La identificación debe tener solo números (6 a 12 dígitos).")
            return redirect('/usuario')

        if rol not in ['Usuario', 'Bibliotecario', 'Administrador']:
            flash("El rol seleccionado no es válido.")
            return redirect('/usuario')

        sql = """
            INSERT INTO Usuarios (Nombre, Correo, Identificacion, Rol)
            VALUES (%s, %s, %s, %s)
        """
        cursor.execute(sql, (nombre, correo, identificacion, rol))
        conn.commit()
        flash("Usuario registrado correctamente.")
        return redirect('/')

    return render_template('usuario.html')

#----------------------------------------------------------------------------------

# Ruta para reservar un libro (solo Usuario)
@app.route('/reservar/<int:libro_id>', methods=['GET', 'POST'])
@permitido_para('Usuario')
def reservar(libro_id):

    if request.method == 'POST':
        usuario_id = request.form['usuario_id']

        if not usuario_id.isdigit():
            flash("Debe seleccionar un usuario válido.")
            return redirect(f'/reservar/{libro_id}')

        cursor.execute("""
            SELECT * FROM Reservas
            WHERE UsuarioID = %s AND LibroID = %s AND Estado = 'Activa'
        """, (usuario_id, libro_id))
        reserva_existente = cursor.fetchone()

        if reserva_existente:
            flash("Este usuario ya tiene una reserva activa para este libro.")
            return redirect(f'/reservar/{libro_id}')

        cursor.execute("""
            INSERT INTO Reservas (UsuarioID, LibroID, FechaReserva, Estado)
            VALUES (%s, %s, %s, 'Activa')
        """, (usuario_id, libro_id, date.today()))

        cursor.execute("UPDATE Libros SET Estado = 'Reservado' WHERE LibroID = %s", (libro_id,))
        conn.commit()
        flash("Reserva registrada correctamente.")
        return redirect('/')

    cursor.execute("SELECT UsuarioID, Nombre FROM Usuarios")
    usuarios = cursor.fetchall()
    cursor.execute("SELECT Titulo FROM Libros WHERE LibroID = %s", (libro_id,))
    libro = cursor.fetchone()
    return render_template('reservar.html', usuarios=usuarios, libro=libro, libro_id=libro_id)

#---------------------------------------------------------------------------------------------

# Ruta para prestar un libro (solo Usuario)
@app.route('/prestar/<int:libro_id>', methods=['GET', 'POST'])
@permitido_para('Usuario')
def prestar(libro_id):
    if request.method == 'POST':
        usuario_id = request.form['usuario_id']

        if not usuario_id.isdigit():
            flash("Debe seleccionar un usuario válido.")
            return redirect(f'/prestar/{libro_id}')

        # Verificar préstamo duplicado
        cursor.execute("""
            SELECT * FROM Prestamos
            WHERE UsuarioID = %s AND LibroID = %s AND FechaDevolucion IS NULL
        """, (usuario_id, libro_id))
        prestamo_activo = cursor.fetchone()

        if prestamo_activo:
            flash("Este usuario ya tiene este libro en préstamo.")
            return redirect(f'/prestar/{libro_id}')

        fecha_inicio = date.today()
        fecha_vencimiento = fecha_inicio + timedelta(days=15)

        cursor.execute("""
            INSERT INTO Prestamos (UsuarioID, LibroID, FechaInicio, FechaVencimiento)
            VALUES (%s, %s, %s, %s)
        """, (usuario_id, libro_id, fecha_inicio, fecha_vencimiento))

        cursor.execute("UPDATE Libros SET Estado = 'Prestado' WHERE LibroID = %s", (libro_id,))
        conn.commit()
        flash("Préstamo registrado correctamente.")
        return redirect('/')

    
    cursor.execute("SELECT UsuarioID, Nombre FROM Usuarios")
    usuarios = cursor.fetchall()
    cursor.execute("SELECT Titulo FROM Libros WHERE LibroID = %s", (libro_id,))
    libro = cursor.fetchone()
    fecha_vencimiento = date.today() + timedelta(days=15)

    return render_template(
        'prestar.html',
        usuarios=usuarios,
        libro=libro,
        libro_id=libro_id,
        fecha_vencimiento=fecha_vencimiento
    )
#--------------------------------------------------------------------------------------

# Ruta para devolver un libro (solo Usuario)
@app.route('/devolver/<int:libro_id>', methods=['POST', 'GET'])
def devolver(libro_id):
    if request.method == 'POST':
        fecha_devolucion = date.today()

        # Obtener datos del préstamo
        cursor.execute("""
            SELECT PrestamoID, FechaVencimiento
            FROM Prestamos
            WHERE LibroID = %s AND FechaDevolucion IS NULL
        """, (libro_id,))
        prestamo = cursor.fetchone()

        if prestamo:
            fecha_vencimiento = prestamo['FechaVencimiento']
            dias_retraso = (fecha_devolucion - fecha_vencimiento).days
            multa = dias_retraso * 1000 if dias_retraso > 0 else 0  # $1000 por día

            cursor.execute("""
                UPDATE Prestamos
                SET FechaDevolucion = %s, Multa = %s
                WHERE PrestamoID = %s
            """, (fecha_devolucion, multa, prestamo['PrestamoID']))

            cursor.execute("UPDATE Libros SET Estado = 'Disponible' WHERE LibroID = %s", (libro_id,))
            conn.commit()

            if multa > 0:
                flash(f"Libro devuelto con retraso. Multa: ${multa:.2f}")
            else:
                flash("Libro devuelto correctamente.")
        else:
            flash("No se encontró préstamo activo.")
        return redirect('/')

    cursor.execute("SELECT Titulo FROM Libros WHERE LibroID = %s", (libro_id,))
    libro = cursor.fetchone()
    return render_template('devolver.html', libro=libro, libro_id=libro_id)

#--------------------------------------------------------------------------------------------

#Inicio de sesion
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        usuario = request.form['usuario'].lower()
        contraseña = request.form['contraseña']

        # Cuentas predefinidas
        cuentas = {
            'administrador': {'password': 'admin1234', 'rol': 'Administrador'},
            'bibliotecario': {'password': 'biblio1234', 'rol': 'Bibliotecario'},
            'usuario': {'password': 'usuario1234', 'rol': 'Usuario'}
        }

        if usuario in cuentas and cuentas[usuario]['password'] == contraseña:
            session['usuario_nombre'] = usuario.capitalize()
            session['rol'] = cuentas[usuario]['rol']
            flash(f"Bienvenido, {usuario.capitalize()} ({cuentas[usuario]['rol']})")

            # Redirección según rol
            if cuentas[usuario]['rol'] == 'Administrador':
                return redirect('/')
            elif cuentas[usuario]['rol'] == 'Bibliotecario':
                return redirect('/')
            elif cuentas[usuario]['rol'] == 'Usuario':
                return redirect('/')
        else:
            flash("Usuario o contraseña incorrectos.")
            return redirect('/login')

    return render_template('login.html')

#----------------------------------------------------------------------------------------

#Ruta para editar un Libro(Solo Administrativo)
@app.route('/editar_libro/<int:libro_id>', methods=['GET', 'POST'])
@permitido_para('Administrador')
def editar_libro(libro_id):


    # Obtener datos del libro actual
    cursor.execute("""
        SELECT * FROM Libros WHERE LibroID = %s
    """, (libro_id,))
    libro = cursor.fetchone()

    if not libro:
        flash("Libro no encontrado.")
        return redirect('/')

    # Obtener autores disponibles
    cursor.execute("SELECT * FROM Autores")
    autores = cursor.fetchall()

    if request.method == 'POST':
        titulo = request.form['titulo'].strip()
        categoria = request.form['categoria'].strip()
        isbn = request.form['isbn'].strip()
        autor_id = request.form['autor_id']

        # Validaciones
        if len(titulo) < 3:
            flash("El título debe tener al menos 3 letras.")
            return redirect(f'/editar_libro/{libro_id}')

        if not re.match(r"^[A-Za-zÁÉÍÓÚÑáéíóúñ\s]+$", categoria):
            flash("La categoría debe contener solo letras.")
            return redirect(f'/editar_libro/{libro_id}')

        if not re.match(r"^\d{10,13}$", isbn):
            flash("El ISBN debe tener entre 10 y 13 dígitos numéricos.")
            return redirect(f'/editar_libro/{libro_id}')

        cursor.execute("""
            UPDATE Libros
            SET Titulo = %s, Categoria = %s, ISBN = %s, AutorID = %s
            WHERE LibroID = %s
        """, (titulo, categoria, isbn, autor_id, libro_id))
        conn.commit()
        flash("Libro actualizado correctamente.")
        return redirect('/')

    return render_template('editar_libro.html', libro=libro, autores=autores)

#---------------------------------------------------------------------------------------------

#Ruta para editar un usuario(Solo Administrativo)
@app.route('/editar_usuario/<int:usuario_id>', methods=['GET', 'POST'])
@permitido_para('Administrador')
def editar_usuario(usuario_id):

    cursor.execute("SELECT * FROM Usuarios WHERE UsuarioID = %s", (usuario_id,))
    usuario = cursor.fetchone()

    if not usuario:
        flash("Usuario no encontrado.")
        return redirect('/imprimir_usuarios')

    if request.method == 'POST':
        nombre = request.form['nombre'].strip()
        correo = request.form['correo'].strip()
        identificacion = request.form['identificacion'].strip()
        rol = request.form['rol']

        cursor.execute("""
            UPDATE Usuarios
            SET Nombre = %s, Correo = %s, Identificacion = %s, Rol = %s
            WHERE UsuarioID = %s
        """, (nombre, correo, identificacion, rol, usuario_id))
        conn.commit()
        flash("Usuario actualizado correctamente.")
        return redirect('/imprimir_usuarios')

    return render_template('editar_usuario.html', usuario=usuario)

#----------------------------------------------------------------------------

#Ruta para eliminar un libro(solo Adminstrador)
@app.route('/eliminar_libro/<int:libro_id>')
@permitido_para('Administrador')
def eliminar_libro(libro_id):

    cursor.execute("DELETE FROM Libros WHERE LibroID = %s", (libro_id,))
    conn.commit()
    flash("Libro eliminado correctamente.")
    return redirect('/')

#-----------------------------------------------------------------------------

#Ruta para eliminar un usuario(solo Adminstrador)
@app.route('/eliminar_usuario/<int:usuario_id>')
@permitido_para('Administrador')
def eliminar_usuario(usuario_id):

    cursor.execute("DELETE FROM Usuarios WHERE UsuarioID = %s", (usuario_id,))
    conn.commit()
    flash("Usuario eliminado correctamente.")
    return redirect('/imprimir_usuarios')


#------------------------------------------------------------------------------

#Ruta para mostrar reportes (Solo Administrador)
@app.route('/reportes')
@permitido_para('Administrador')
def reportes():

    cursor.execute("""
        SELECT Libros.Titulo, COUNT(*) AS VecesPrestado
        FROM Prestamos
        JOIN Libros ON Prestamos.LibroID = Libros.LibroID
        GROUP BY Libros.LibroID
        ORDER BY VecesPrestado DESC
        LIMIT 5
    """)
    libros_mas_prestados = cursor.fetchall()

    cursor.execute("""
        SELECT Usuarios.Nombre, COUNT(*) AS Total
        FROM Prestamos
        JOIN Usuarios ON Prestamos.UsuarioID = Usuarios.UsuarioID
        GROUP BY Usuarios.UsuarioID
        ORDER BY Total DESC
        LIMIT 5
    """)
    usuarios_mas_activos = cursor.fetchall()

    # Usuarios con más multas
    cursor.execute("""
        SELECT U.Nombre, SUM(P.Multa) AS TotalMultas
        FROM Prestamos P
        JOIN Usuarios U ON P.UsuarioID = U.UsuarioID
        GROUP BY U.UsuarioID
        HAVING SUM(P.Multa) > 0
        ORDER BY TotalMultas DESC
    """)
    multados = cursor.fetchall()


    return render_template('reportes.html', libros=libros_mas_prestados, usuarios=usuarios_mas_activos)

#--------------------------------------------------------------------------------------------

#Ruta para que el bibliotecario y los administrativos  consulte los prestamos
@app.route('/prestamos')
@permitido_para('Administrador','Bibliotecario')
def prestamos():

    cursor.execute("""
        SELECT P.PrestamoID, U.Nombre AS Usuario, L.Titulo AS Libro,
               P.FechaInicio, P.FechaVencimiento, P.FechaDevolucion
        FROM Prestamos P
        JOIN Usuarios U ON P.UsuarioID = U.UsuarioID
        JOIN Libros L ON P.LibroID = L.LibroID
        ORDER BY P.FechaInicio DESC
    """)
    prestamos = cursor.fetchall()
    return render_template('prestamos.html', prestamos=prestamos)

#--------------------------------------------------------------------------------------------

#Ruta para que el bibliotecario y el administrativo vea estadisticas
@app.route('/estadisticas')
@permitido_para('Administrador', 'Bibliotecario')
def estadisticas():

    cursor.execute("SELECT COUNT(*) AS TotalLibros FROM Libros")
    total_libros = cursor.fetchone()['TotalLibros']

    cursor.execute("SELECT COUNT(*) AS Prestados FROM Libros WHERE Estado = 'Prestado'")
    prestados = cursor.fetchone()['Prestados']

    cursor.execute("SELECT COUNT(*) AS Reservados FROM Libros WHERE Estado = 'Reservado'")
    reservados = cursor.fetchone()['Reservados']

    cursor.execute("SELECT COUNT(*) AS Disponibles FROM Libros WHERE Estado = 'Disponible'")
    disponibles = cursor.fetchone()['Disponibles']

    return render_template('estadisticas.html', total=total_libros, prestados=prestados, reservados=reservados, disponibles=disponibles)

#--------------------------------------------------------------------------------------------

#Ruta para imprimir los usuarios registrados
@app.route('/imprimir_usuarios')
@permitido_para('Administrador')
def ver_usuarios():

    cursor.execute("SELECT * FROM Usuarios")
    usuarios = cursor.fetchall()
    return render_template('imprimir_usuarios.html', usuarios=usuarios)

#--------------------------------------------------------------------------------------------



#---------------------------------------------------------------------------------------

# Ruta para cerrar sesión
@app.route('/logout')
def logout():
    session.clear()
    flash("Sesión cerrada.")
    return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True)
