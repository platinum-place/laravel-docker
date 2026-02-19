# Guía de Respaldo de Storage

Esta guía explica cómo crear, transferir y restaurar respaldos de la carpeta `storage/app`.

---

## 📤 Exportar Respaldo (Backup)

```bash
sudo docker compose -f compose.prod.yaml exec app tar -czvf /tmp/storage_backup.tar.gz -C /var/www/html/storage app
sudo docker cp $(sudo docker compose -f compose.prod.yaml ps -q app):/tmp/storage_backup.tar.gz ./storage_backup.tar.gz
```

---

## 📥 Importar Respaldo (Restaurar)

### ⚠️ ¡ADVERTENCIA CRÍTICA!
Asegúrate de usar `-x` (extract) y no `-c` (create) al restaurar.
- **MAL:** `tar -czvf ...` (Esto **SOBREESCRIBE** tu backup con un archivo vacío)
- **BIEN:** `tar -xzvf ...` (Esto **DESCOMPRIME** el backup en tu proyecto)

```bash
sudo docker cp storage_backup.tar.gz $(sudo docker compose -f compose.prod.yaml ps -q app):/tmp/storage_backup.tar.gz
sudo docker compose -f compose.prod.yaml exec app tar -xzvf /tmp/storage_backup.tar.gz -C /var/www/html/storage/
```

---

## 🔑 Corregir Permisos (IMPORTANTE)
Al restaurar archivos, a veces vienen con usuarios/permisos que Laravel no puede leer. Si obtienes errores 404 o "Permission Denied", ejecuta:

```bash
sudo docker compose -f compose.prod.yaml exec -u root app chown -R www-data:www-data storage/app
sudo docker compose -f compose.prod.yaml exec -u root app chmod -R 775 storage/app
```

---

## 📝 Notas y Errores Comunes

- **Error: Permission Denied**: Casi siempre se soluciona ejecutando el bloque de "Corregir Permisos".
- **Archivo vacío**: Si el backup pesa pocos bytes (ej. 197 bytes), es probable que hayas usado `tar -c` por error y sobrescrito el original.
- **Fecha en el nombre**: `storage_backup_$(date +%Y%m%d).tar.gz`
