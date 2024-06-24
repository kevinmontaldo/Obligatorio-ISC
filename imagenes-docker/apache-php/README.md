# Imagen Docker para Aplicación Web

Este repositorio contiene los archivos necesarios para construir una imagen Docker para una aplicación web que se conecta a una base de datos MySQL. A continuación, se describen los archivos y su propósito.

## Archivos

### Dockerfile
Archivo: `Dockerfile`

El Dockerfile define cómo se construye la imagen Docker. Incluye la instalación de Apache y PHP, así como la configuración necesaria para conectar la aplicación a una base de datos MySQL.

### dump.sql
Archivo: `dump.sql`

Este archivo contiene el script SQL para inicializar la base de datos MySQL con las tablas y datos necesarios para la aplicación.

## Construcción de la Imagen

Para construir la imagen Docker, asegúrate de tener Docker instalado y ejecuta el siguiente comando en el directorio donde se encuentra el Dockerfile:

```sh
docker build -t web .
