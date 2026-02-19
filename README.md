# Laravel Docker laravel-docker

Este proyecto es un esqueleto de Dockerización profesional diseñado específicamente para aplicaciones **Laravel 12**. Proporciona una infraestructura robusta, estandarizada y lista para producción, permitiendo que otros proyectos lo adopten como base para garantizar consistencia en sus despliegues.

## ✨ Características

- **Servidor Web**: Nginx optimizado.
- **Runtime**: PHP 8.5-FPM (configurable).
- **Base de Datos**: PostgreSQL 18.
- **Caché/Colas**: Redis.
- **Procesos**: Worker de colas y ejecutor de tareas (Scheduler) preconfigurados.
- **Frontend**: Multi-stage build para compilar assets (Vite) de forma eficiente.
- **Estándar**: Basado en las mejores prácticas de despliegue para el ecosistema Laravel.

## 📁 Estructura del Proyecto

```text
.
├── compose.yaml            # Configuración base de Docker Compose
├── compose.prod.yaml       # Configuración específica para despliegue estándar
└── docker/
    ├── prod/               # Dockerfiles y configuraciones profesionales
    │   ├── nginx/          # Configuración de servidor web
    │   └── php/            # Configuración de PHP-FPM y Entrypoints
    ├── pgsql/              # Scripts iniciales para base de datos
    └── docs/               # Documentación detallada de operación
```

## 🚀 Inicio Rápido

Para levantar el entorno completo:

```bash
docker compose -f compose.prod.yaml up -d --build
```

Después, inicializa las dependencias y la base de datos:

```bash
docker compose -f compose.prod.yaml exec app composer install --no-dev --optimize-autoloader --no-scripts
docker compose -f compose.prod.yaml exec app php artisan migrate
```

## � Uso como Base (laravel-docker)

Para integrar este esqueleto en un proyecto Laravel existente o nuevo, se recomienda usar Git Remotes para facilitar futuras actualizaciones.

### 1. Instalación Inicial

Desde la raíz de tu proyecto Laravel destino:

```bash
# 1. Agregar este repositorio como un remoto llamado 'laravel-docker'
git remote add laravel-docker https://github.com/platinum-place/laravel-docker.git

# 2. Descargar los archivos del esqueleto
git fetch laravel-docker

# 3. Fusionar el esqueleto en tu rama principal
# Nota: --allow-unrelated-histories es necesario para la primera fusión
git merge laravel-docker/main --allow-unrelated-histories
```

### 2. Sincronización y Actualización

Cuando este esqueleto reciba mejoras (parches de seguridad, nuevas extensiones), puedes traer los cambios a tus proyectos de forma sencilla:

```bash
# 1. Obtener los últimos cambios del esqueleto
git fetch laravel-docker

# 2. Fusionar los cambios
git merge laravel-docker/main
```

> [!TIP]
> Si ocurren conflictos, resuélvelos priorizando tus configuraciones específicas del proyecto pero manteniendo la estructura de carpetas de `/docker`.

## �📖 Documentación Detallada

Para más información sobre la gestión diaria, consulta nuestras guías:

- 🛠️ [Guía de Despliegue](docker/docs/deploy.md)
- ⌨️ [Comandos Útiles](docker/docs/commands.md)
- 🗄️ [Gestión de Base de Datos](docker/docs/database.md)
- 📜 [Visualización de Logs](docker/docs/logs.md)
- 💾 [Respaldo de Archivos (Storage)](docker/docs/storage.md)

---
*Este proyecto sirve como base para estandarizar el entorno Docker en todos nuestros proyectos Laravel.*