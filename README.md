# 📚 Sistema de Gestión de Librería Virtual

Un sistema web dinámico y modular para la gestión, exploración y administración de catálogos en una librería o biblioteca virtual. Desarrollado con arquitectura **LAMP/WAMP** (Linux/Windows, Apache, MySQL, PHP), este proyecto facilita la interacción fluida entre los usuarios y el catálogo de libros mediante un panel interactivo.

---

## 📋 Tabla de Contenidos

- [Características Principales](#-características-principales)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Requisitos del Sistema](#-requisitos-del-sistema)
- [Instalación y Configuración Paso a Paso](#-instalación-y-configuración-paso-a-paso)
  - [1. Clonar el Repositorio](#1-clonar-el-repositorio)
  - [2. Configuración de la Base de Datos](#2-configuración-de-la-base-de-datos)
  - [3. Configurar Parámetros de Conexión](#3-configurar-parámetros-de-conexión)
  - [4. Despliegue Local](#4-despliegue-local)
- [Tecnologías Utilizadas](#-tecnologías-utilizadas)
- [Buenas Prácticas e Instrucciones para Desarrolladores](#-buenas-prácticas-e-instrucciones-para-desarrolladores)
- [Autor](#-autor)

---

## 🚀 Características Principales

* 📖 **Catálogo Interactivo:** Exploración de colecciones de libros, títulos, autores y categorías.
* 🛡️ **Procesamiento de Datos Seguro:** Lógica de backend orientada a la consulta y administración eficiente de registros.
* 🗄️ **Base de Datos Relacional:** Estructura normalizada en MySQL para garantizar integridad referencial de los datos.
* 🎨 **Interfaz Responsiva:** Diseño fluido adaptado a navegadores web y dispositivos móviles.
* 🔍 **Búsqueda y Filtros:** Búsqueda rápida de libros en tiempo real mediante filtrado estático/dinámico.

---

## 📁 Estructura del Proyecto

```text
libreria-virtual/
├── css/                  # Hojas de estilo personalizadas (CSS3)
├── js/                   # Scripts de interactividad (JavaScript ES6)
├── img/                  # Portadas, recursos gráficos e ilustraciones
├── fontawesome/          # Iconografía e interfaz gráfica
├── config/               # Archivos de configuración y conexión a BD
│   └── conexion.php      # Script PHP de conexión MySQL
├── base_de_datos.sql     # Script SQL para importar tablas y datos iniciales
├── index.php             # Vista y punto de entrada principal
├── README.md             # Documentación del proyecto
└── ...                   # Módulos y vistas secundarias en PHP
```

---

## 💻 Requisitos del Sistema

Antes de comenzar la instalación, asegúrate de contar con las siguientes herramientas en tu entorno local:

| Componente | Requisito Mínimo | Recomendado |
| :--- | :--- | :--- |
| **Entorno de Servidor** | WampServer 3.x / XAMPP 8.x | WampServer 3.3.0+ |
| **Servidor Web** | Apache 2.4 | Apache 2.4.x |
| **Lenguaje Backend** | PHP 7.4 | PHP 8.1 o superior |
| **Base de Datos** | MySQL 5.7 / MariaDB 10.4 | MySQL 8.0 / MariaDB 10.6 |
| **Gestor BD** | phpMyAdmin 5.0 | phpMyAdmin 5.2+ |
| **Navegador Web** | Cualquier navegador moderno | Google Chrome / Firefox / Edge |

---

## ⚙️ Instalación y Configuración Paso a Paso

Sigue detenidamente las siguientes instrucciones para ejecutar la plataforma en tu equipo local:

### 1. Clonar el Repositorio
Abre tu terminal (PowerShell, Git Bash o CMD) y navega hacia el directorio de proyectos web de WampServer (por defecto en `C:\wamp64\www\`):

```bash
cd C:\wamp64\www\
git clone https://github.com/JuanAnd-coder/libreria-virtual.git
cd libreria-virtual
```

### 2. Configuración de la Base de Datos
1. Inicia **WampServer** y confirma que todos los servicios estén activos (icono verde).
2. Abre tu navegador web y entra a **phpMyAdmin**:  
   `http://localhost/phpmyadmin/`
3. Crea una nueva base de datos llamada `libreria_db` con cotejamiento `utf8mb4_unicode_ci`.
4. Selecciona la base de datos `libreria_db` creada y dirígete a la pestaña **Importar**.
5. Selecciona el archivo `base_de_datos.sql` ubicado en la raíz de la carpeta del proyecto.
6. Haz clic en **Continuar** para ejecutar las sentencias SQL y crear las tablas requeridas.

### 3. Configurar Parámetros de Conexión
Asegúrate de que las variables de credenciales dentro del archivo de conexión (ej. `config/conexion.php`) coincidan con los parámetros de tu servidor local:

```php
<?php
$host = "localhost";
$user = "root";
$password = ""; // Contraseña predeterminada de WampServer suele ser vacía
$database = "libreria_db";
$port = 3306;

$conexion = new mysqli($host, $user, $password, $database, $port);

if ($conexion->connect_error) {
    die("Error de conexión a la base de datos: " . $conexion->connect_error);
}
?>
```

### 4. Despliegue Local
Abre tu navegador e ingresa a la siguiente ruta para visualizar e interactuar con el sitio web:
```text
http://localhost/libreria-virtual/
```

---

## 🛠️ Tecnologías Utilizadas

* **HTML5:** Estructura semántica de las vistas y componentes.
* **CSS3:** Hojas de estilo personalizadas para diseño adaptable.
* **JavaScript (Vanilla):** Dinamismo y manipulación del DOM.
* **PHP:** Lógica del lado del servidor y procesamiento de datos.
* **MySQL:** Motor relacional para la persistencia de datos.
* **FontAwesome:** Librería vectorial de iconos.

---

## 📌 Buenas Prácticas e Instrucciones para Desarrolladores

* **Control de Cambios:** Crea una rama (`branch`) secundaria antes de añadir nuevas características al sistema:
  ```bash
  git checkout -b feature/nueva-caracteristica
  ```
* **Variables Sensibles:** Asegúrate de no incluir contraseñas reales ni claves API en commits públicos.
* **Archivos Temporales:** Recuerda descartar o eliminar copias de seguridad de editores que finalicen en `~` o `.bak` antes de hacer un push al repositorio.

---

## 👤 Autor

Desarrollado por **Juan Andrés**  
* **GitHub:** [@JuanAnd-coder](https://github.com/JuanAnd-coder)

---
*¡Gracias por revisar este repositorio! 📚✨*
