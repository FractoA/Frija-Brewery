# FRIJA BREWERY - DEVELOPMENT DATABASE

## Descripción
Base de datos del sistema web de la distribuidora de cerveza importada FRIJA BREWERY.

El proyecto utiliza MariaDB y contiene 15 tablas relacionadas mediante claves primarias y foráneas.


## Archivos

| Archivo      | Descripción                                   |
| `schema.sql` | Creación de la base de datos y sus 15 tablas. |
| `seed.sql`   | Inserción de datos de prueba.                 |

## Instalación

### 1. Descargar los archivos

Descargar `schema.sql` y `seed.sql` de este directorio.

### 2. Crear la estructura

Ejecutar en la terminal:

```bash
mariadb -u root -p < schema.sql
```

### 3. Insertar los datos de prueba

Ejecutar:

```bash
mariadb -u root -p imported_beer_distributor_dev < seed.sql
```

### 4. Verificar la instalación

Ingresar a MariaDB:

```sql
USE imported_beer_distributor_dev;

SHOW TABLES;
```

La base de datos debe contener 15 tablas.

## Motor de almacenamiento

Todas las tablas utilizan InnoDB.

## Importante

Los datos incluidos en `seed.sql` son exclusivamente para pruebas y desarrollo.

**Proyecto:** FRIJA BREWERY  
**Motor:** MariaDB  
**Base de datos:** imported_beer_distributor_dev
