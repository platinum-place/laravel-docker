# Guía de Base de Datos

Gestión de respaldos (`.dump`) y restauración para PostgreSQL usando Docker Compose. El servicio de base de datos se llama `pgsql`.

---

## 📤 Exportar Respaldo (Backup)

```bash
sudo docker compose -f compose.prod.yaml exec pgsql pg_dump -U {DB_USERNAME} -d {DB_DATABASE} -Fc -f /tmp/database.dump
sudo docker cp $(sudo docker compose -f compose.prod.yaml ps -q pgsql):/tmp/database.dump ./database.dump
```

---

## 📥 Importar Respaldo (Restaurar)

Este proceso es destructivo para la base de datos actual. Úselo con precaución.

```bash
sudo docker cp ./database.dump $(sudo docker compose -f compose.prod.yaml ps -q pgsql):/tmp/database.dump
sudo docker compose -f compose.prod.yaml exec pgsql dropdb -U {DB_USERNAME} {DB_DATABASE} --if-exists
sudo docker compose -f compose.prod.yaml exec pgsql createdb -U {DB_USERNAME} {DB_DATABASE}
sudo docker compose -f compose.prod.yaml exec pgsql pg_restore -U {DB_USERNAME} -d {DB_DATABASE} -v /tmp/database.dump
```

> [!IMPORTANT]
> Reemplace `{DB_USERNAME}` y `{DB_DATABASE}` con los valores definidos en su archivo `.env`.
