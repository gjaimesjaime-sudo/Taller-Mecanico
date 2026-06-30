-- TABLA CLIENTES
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) UNIQUE,
    correo VARCHAR(100) UNIQUE
);

-- TABLA VEHICULOS
CREATE TABLE vehiculos (
    id_vehiculo SERIAL PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL CHECK (anio >= 1900),
    id_cliente INT NOT NULL,

    CONSTRAINT fk_vehiculo_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES clientes(id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- TABLA MECANICOS
CREATE TABLE mecanicos (
    id_mecanico SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) UNIQUE
);

-- TABLA ORDENES DE SERVICIO
CREATE TABLE ordenes_servicio (
    id_orden SERIAL PRIMARY KEY,
    fecha_ingreso DATE NOT NULL,
    descripcion TEXT NOT NULL,
    estado VARCHAR(20) NOT NULL,
    costo_total DECIMAL(10,2) DEFAULT 0 CHECK (costo_total >= 0),
    id_vehiculo INT NOT NULL,
    id_mecanico INT NOT NULL,

    CONSTRAINT chk_estado
    CHECK (estado IN ('Pendiente','En Proceso','Finalizado')),

    CONSTRAINT fk_orden_vehiculo
    FOREIGN KEY (id_vehiculo)
    REFERENCES vehiculos(id_vehiculo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_orden_mecanico
    FOREIGN KEY (id_mecanico)
    REFERENCES mecanicos(id_mecanico)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- TABLA REPUESTOS
CREATE TABLE repuestos (
    id_repuesto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

-- TABLA DETALLE ORDEN REPUESTO
CREATE TABLE detalle_orden_repuesto (
    id_detalle SERIAL PRIMARY KEY,
    id_orden INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),

    CONSTRAINT fk_detalle_orden
    FOREIGN KEY (id_orden)
    REFERENCES ordenes_servicio(id_orden)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_detalle_repuesto
    FOREIGN KEY (id_repuesto)
    REFERENCES repuestos(id_repuesto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
. 
-- CLIENTES

INSERT INTO clientes (nombre, telefono, correo) VALUES
('Juan Pérez', '70010001', 'juan@gmail.com'),
('María López', '70010002', 'maria@gmail.com'),
('Carlos Hernández', '70010003', 'carlos@gmail.com'),
('Ana Martínez', '70010004', 'ana@gmail.com'),
('Luis Ramírez', '70010005', 'luis@gmail.com'),
('Sofía Castro', '70010006', 'sofia@gmail.com'),
('Pedro Flores', '70010007', 'pedro@gmail.com'),
('Daniela Rivas', '70010008', 'daniela@gmail.com'),
('José Gómez', '70010009', 'jose@gmail.com'),
('Valeria Cruz', '70010010', 'valeria@gmail.com');

-- MECÁNICOS

INSERT INTO mecanicos (nombre, especialidad, telefono) VALUES
('Miguel Torres', 'Motor', '71000001'),
('Ricardo Díaz', 'Suspensión', '71000002'),
('Fernando Ruiz', 'Frenos', '71000003'),
('Jorge Castro', 'Electricidad', '71000004'),
('Mario López', 'Transmisión', '71000005'),
('Kevin Ramos', 'Motor', '71000006'),
('Oscar Flores', 'Pintura', '71000007'),
('Roberto Pérez', 'Alineación', '71000008'),
('Héctor Martínez', 'Diagnóstico', '71000009'),
('Andrés Gómez', 'Mecánica General', '71000010');

-- REPUESTOS

INSERT INTO repuestos (nombre, precio, stock) VALUES
('Filtro de aceite', 8.50, 50),
('Pastillas de freno', 25.00, 30),
('Batería', 95.00, 20),
('Amortiguador', 75.00, 15),
('Bujía', 5.00, 100),
('Llanta', 80.00, 40),
('Correa de distribución', 45.00, 25),
('Aceite 5W30', 12.00, 60),
('Faro delantero', 55.00, 10),
('Alternador', 180.00, 8);

-- VEHÍCULOS

INSERT INTO vehiculos (placa, marca, modelo, anio, id_cliente) VALUES
('P123456', 'Toyota', 'Corolla', 2018, 1),
('P234567', 'Honda', 'Civic', 2020, 2),
('P345678', 'Nissan', 'Sentra', 2019, 3),
('P456789', 'Hyundai', 'Accent', 2017, 4),
('P567890', 'Kia', 'Rio', 2021, 5),
('P678901', 'Mazda', '3', 2016, 6),
('P789012', 'Ford', 'Focus', 2015, 7),
('P890123', 'Chevrolet', 'Spark', 2022, 8),
('P901234', 'Volkswagen', 'Jetta', 2018, 9),
('P012345', 'Suzuki', 'Swift', 2020, 10);

-- ÓRDENES DE SERVICIO

INSERT INTO ordenes_servicio
(fecha_ingreso, descripcion, estado, costo_total, id_vehiculo, id_mecanico)
VALUES
('2026-01-10', 'Cambio de aceite', 'Finalizado', 35.00, 1, 1),
('2026-01-11', 'Cambio de pastillas de freno', 'Finalizado', 80.00, 2, 3),
('2026-01-12', 'Cambio de batería', 'Pendiente', 120.00, 3, 4),
('2026-01-13', 'Alineación y balanceo', 'Finalizado', 45.00, 4, 8),
('2026-01-14', 'Reparación de suspensión', 'En Proceso', 250.00, 5, 2),
('2026-01-15', 'Diagnóstico general', 'Finalizado', 40.00, 6, 9),
('2026-01-16', 'Cambio de bujías', 'Pendiente', 60.00, 7, 1),
('2026-01-17', 'Reparación del sistema eléctrico', 'En Proceso', 150.00, 8, 4),
('2026-01-18', 'Cambio de llantas', 'Finalizado', 300.00, 9, 10),
('2026-01-19', 'Mantenimiento preventivo', 'Pendiente', 90.00, 10, 5);

-- DETALLE ORDEN - REPUESTO

INSERT INTO detalle_orden_repuesto
(id_orden, id_repuesto, cantidad)
VALUES
(1,1,1),
(1,8,4),
(2,2,1),
(3,3,1),
(4,6,2),
(5,4,2),
(6,9,1),
(7,5,4),
(8,10,1),
(9,6,4);