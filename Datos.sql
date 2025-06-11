INSERT INTO tipo_producto (nombre) VALUES
('Bebida'),
('Pizza');

INSERT INTO producto (nombre, tipo_producto_id) VALUES
('Hamburguesa', 2),
('Pizza', 2),
('Gaseosa', 1),
('Helado', 3),
('Jugo Natural', 1);

INSERT INTO presentacion (nombre) VALUES
('Pequeña'),
('Mediana'),
('Grande');

INSERT INTO producto_presentacion (producto_id, presentacion_id, precio) VALUES
(1, 2, 12.50),
(2, 3, 20.00),
(3, 1, 3.00),
(4, 1, 5.50),
(5, 2, 6.00);

INSERT INTO combo (id, nombre, precio) VALUES
(1, 'Combo 2: Pizza + Jugo', 24.00);

INSERT INTO producto_combo (producto_id, combo_id) VALUES
(1, 1), 
(3, 1), 
(2, 2),
(5, 2); 
INSERT INTO cliente (nombre, telefono, direccion) VALUES
('Danilo Muskus', '3001234567', 'Calle 10 #12-34'),
('Nicolas Muskus', '3119876543', 'Carrera 15 #45-67');

INSERT INTO metodo_pago (nombre) VALUES
('Efectivo'),
('Tarjeta'),
('Nequi');

INSERT INTO pedido (fecha_recogida, total, cliente_id, metodo_pago_id) VALUES
('2024-06-10 12:30:00', 17.00, 1, 1),
('2024-06-11 15:00:00', 24.00, 2, 2);

INSERT INTO detalle_pedido (cantidad, pedido_id, producto_id) VALUES
(1, 1, 1), 
(1, 1, 3),
(1, 2, 2), 
(1, 2, 5); 

INSERT INTO ingrediente (nombre, stock, precio) VALUES
('Queso', 100, 0.50),
('Tomate', 80, 0.30),
('Pan', 50, 0.60),
('Carne', 60, 1.50),
('Pepperoni', 40, 1.00);

INSERT INTO ingrediente_extra (cantidad, detalle_pedido_id, ingrediente_id) VALUES
(1, 1, 1), 
(2, 3, 5); 

INSERT INTO factura (cliente, total, fecha, pedido_id, cliente_id) VALUES
('Danilo Muskus', 17.00, '2024-06-10 13:00:00', 1, 1),
('Nicolas Muskus', 24.00, '2024-06-11 15:30:00', 2, 2);