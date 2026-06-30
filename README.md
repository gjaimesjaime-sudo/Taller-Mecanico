# Taller-Mecanico# Sistema de Gestión para Taller Mecánico

## Descripción

Este proyecto consiste en el diseño e implementación de una base de datos para un **Sistema de Gestión de Taller Mecánico**, desarrollada en PostgreSQL.

El sistema permite administrar la información de los clientes, sus vehículos, los mecánicos encargados de las reparaciones, las órdenes de servicio y los repuestos utilizados en cada mantenimiento.

La base de datos está normalizada hasta la **Tercera Forma Normal (3FN)** para evitar redundancia de información y garantizar la integridad de los datos.

---

# Objetivos

- Diseñar una base de datos relacional para un taller mecánico.
- Implementar las tablas utilizando PostgreSQL.
- Aplicar restricciones de integridad mediante llaves primarias, foráneas y validaciones.
- Mantener relaciones correctas entre las entidades.
- Insertar datos de prueba realistas para verificar el funcionamiento del sistema.

---

# Tecnologías Utilizadas

- PostgreSQL
- pgAdmin 4
- SQL

---

# Estructura de la Base de Datos

La base de datos está conformada por las siguientes tablas:

## 1. Clientes

Almacena la información de los clientes registrados en el taller.

### Campos

| Campo | Tipo | Descripción |
|--------|------|-------------|
| id_cliente | SERIAL | Identificador único del cliente. |
| nombre | VARCHAR(100) | Nombre completo del cliente. |
| telefono | VARCHAR(20) | Número telefónico único. |
| correo | VARCHAR(100) | Correo electrónico único. |

---

## 2. Vehículos

Registra los vehículos pertenecientes a cada cliente.

### Campos

| Campo | Tipo | Descripción |
|--------|------|-------------|
| id_vehiculo | SERIAL | Identificador del vehículo. |
| placa | VARCHAR(10) | Número de placa único. |
| marca | VARCHAR(50) | Marca del vehículo. |
| modelo | VARCHAR(50) | Modelo del vehículo. |
| anio | INT | Año de fabricación. |
| id_cliente | INT | Cliente propietario del vehículo. |

### Relaciones

- Un cliente puede poseer varios vehículos.
- Cada vehículo pertenece únicamente a un cliente.

---

## 3. Mecánicos

Contiene la información del personal técnico del taller.

### Campos

| Campo | Tipo | Descripción |
|--------|------|-------------|
| id_mecanico | SERIAL | Identificador del mecánico. |
| nombre | VARCHAR(100) | Nombre del mecánico. |
| especialidad | VARCHAR(50) | Área de especialización. |
| telefono | VARCHAR(20) | Número telefónico. |

---

## 4. Órdenes de Servicio

Registra cada mantenimiento o reparación realizada.

### Campos

| Campo | Tipo | Descripción |
|--------|------|-------------|
| id_orden | SERIAL | Identificador de la orden. |
| fecha_ingreso | DATE | Fecha de ingreso del vehículo. |
| descripcion | TEXT | Descripción del servicio realizado. |
| estado | VARCHAR(20) | Estado de la orden. |
| costo_total | DECIMAL(10,2) | Costo total del servicio. |
| id_vehiculo | INT | Vehículo atendido. |
| id_mecanico | INT | Mecánico responsable. |

### Estados permitidos

- Pendiente
- En Proceso
- Finalizado

---

## 5. Repuestos

Almacena los repuestos disponibles para los servicios.

### Campos

| Campo | Tipo | Descripción |
|--------|------|-------------|
| id_repuesto | SERIAL | Identificador del repuesto. |
| nombre | VARCHAR(100) | Nombre del repuesto. |
| precio | DECIMAL(10,2) | Precio unitario. |
| stock | INT | Cantidad disponible. |

---

## 6. Detalle_Orden_Repuesto

Tabla intermedia que relaciona las órdenes de servicio con los repuestos utilizados.

### Campos

| Campo | Tipo | Descripción |
|--------|------|-------------|
| id_detalle | SERIAL | Identificador del detalle. |
| id_orden | INT | Orden de servicio. |
| id_repuesto | INT | Repuesto utilizado. |
| cantidad | INT | Cantidad utilizada. |

---

# Relaciones

El modelo relacional está compuesto por las siguientes relaciones:

Clientes (1) -------- (N) Vehículos

Vehículos (1) -------- (N) Órdenes de Servicio

Mecánicos (1) -------- (N) Órdenes de Servicio

Órdenes de Servicio (N) -------- (N) Repuestos

La relación muchos a muchos entre órdenes y repuestos se implementa mediante la tabla **detalle_orden_repuesto**.

---

# Restricciones Implementadas

## Llaves Primarias (PRIMARY KEY)

- clientes.id_cliente
- vehiculos.id_vehiculo
- mecanicos.id_mecanico
- ordenes_servicio.id_orden
- repuestos.id_repuesto
- detalle_orden_repuesto.id_detalle

---

## Llaves Foráneas (FOREIGN KEY)

Vehículos → Clientes

Órdenes de Servicio → Vehículos

Órdenes de Servicio → Mecánicos

Detalle Orden Repuesto → Órdenes de Servicio

Detalle Orden Repuesto → Repuestos

---

## Restricciones de Integridad

Se implementaron las siguientes restricciones:

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK

Las validaciones incluyen:

- Año del vehículo mayor o igual a 1900.
- Precio del repuesto mayor que cero.
- Stock mayor o igual a cero.
- Cantidad utilizada mayor que cero.
- Costo total mayor o igual a cero.
- Estado únicamente puede ser:
  - Pendiente
  - En Proceso
  - Finalizado

---

# Datos de Prueba

Se insertaron registros de ejemplo para comprobar el funcionamiento de la base de datos.

Cantidad de registros:

| Tabla | Registros |
|--------|----------:|
| Clientes | 10 |
| Vehículos | 10 |
| Mecánicos | 10 |
| Órdenes de Servicio | 10 |
| Repuestos | 10 |
| Detalle Orden Repuesto | 10 |

Total de registros insertados: **60**

---

# Integridad Referencial

La base de datos mantiene la integridad referencial mediante el uso de llaves foráneas.

Además, se configuró:

- ON UPDATE CASCADE
- ON DELETE CASCADE

para asegurar que las modificaciones o eliminaciones en las tablas principales se reflejen correctamente en las tablas relacionadas.

---

# Ejecución del Proyecto

1. Crear una base de datos en PostgreSQL.
2. Ejecutar el script de creación de tablas (`CREATE TABLE`).
3. Ejecutar el script de inserción de datos (`INSERT INTO`).
4. Verificar la creación de las tablas y los registros mediante consultas SQL.

---

# Autor

**Giovanni Paolo Jaimes Jaime**

Proyecto académico de Base de Datos.
