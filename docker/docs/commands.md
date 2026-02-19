# Comandos

Guía para ejecutar comandos dentro de los contenedores usando Docker Compose.

---

## Ejecución de Comandos

Los comandos deben ejecutarse utilizando el archivo base de configuración.

### Instalar dependencias
```bash
sudo docker compose -f compose.prod.yaml exec app composer install --no-dev --optimize-autoloader --no-scripts
```

### Artisan
```bash
sudo docker compose -f compose.prod.yaml exec app php artisan migrate --force
sudo docker compose -f compose.prod.yaml exec app php artisan optimize
sudo docker compose -f compose.prod.yaml exec app php artisan db:seed --force
```

### Shell Interactivo
```bash
sudo docker compose -f compose.prod.yaml exec app bash
```

---

## Servicios Disponibles

| Archivo YAML | Servicio Principal | Otros Servicios |
|---|---|---|
| `compose.prod.yaml` | `app` | `nginx`, `pgsql`, `redis`, `queue`, `scheduler` |
