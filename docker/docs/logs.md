# Gestión de Logs

Guía para visualizar y gestionar logs de los servicios.

---

## Logs de Contenedores (Docker)

```bash
# Todos los servicios
sudo docker compose -f compose.prod.yaml logs -f

# Servicios específicos
sudo docker compose -f compose.prod.yaml logs app -f
sudo docker compose -f compose.prod.yaml logs nginx -f
```

## Logs de Aplicación (Laravel)

```bash
sudo docker compose -f compose.prod.yaml exec app tail -f -n 100 storage/logs/laravel.log
```

---

## 🔍 Comandos Útiles

| Objetivo | Comando |
|---|---|
| Estado de servicios | `sudo docker compose -f compose.prod.yaml ps` |
| Ver últimas 50 líneas | `sudo docker compose -f compose.prod.yaml logs --tail=50 -f` |
