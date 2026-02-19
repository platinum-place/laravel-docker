# Guía de Despliegue

Esta guía describe cómo levantar el entorno del sistema.

---

## 1. Construir y Levantar

```bash
sudo docker compose -f compose.prod.yaml build --no-cache
sudo docker compose -f compose.prod.yaml up -d
```

## 2. Instalar Dependencias

```bash
sudo docker compose -f compose.prod.yaml exec app composer install --no-dev --optimize-autoloader
```

## 3. Inicializar Base de Datos

```bash
sudo docker compose -f compose.prod.yaml exec app php artisan migrate --force
```
