CREATE TABLE `cliente`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(11) NOT NULL,
    `direccion` VARCHAR(150) NOT NULL
);
CREATE TABLE `producto`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `tipo_producto_id` BIGINT NOT NULL
);
CREATE TABLE `combo`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL
);
CREATE TABLE `detalle_pedido`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cantidad` BIGINT NOT NULL,
    `pedido_id` BIGINT NOT NULL,
    `producto_id` BIGINT NULL,
    `combo_id` BIGINT NULL
);
CREATE TABLE `factura`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cliente` VARCHAR(100) NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `fecha` DATETIME NOT NULL,
    `pedido_id` BIGINT NOT NULL,
    `cliente_id` BIGINT NOT NULL
);
CREATE TABLE `pedido`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha_recogida` DATETIME NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `cliente_id` BIGINT NOT NULL,
    `metodo_pago_id` BIGINT NOT NULL
);
CREATE TABLE `metodo_pago`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL
);
CREATE TABLE `ingredientes_extra`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cantidad` BIGINT NOT NULL,
    `detalle_pedido_id` BIGINT NOT NULL,
    `ingrediente_id` BIGINT NOT NULL
);
CREATE TABLE `tipo_producto`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL
);
CREATE TABLE `combo_producto`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `producto_id` BIGINT NOT NULL,
    `combo_id` BIGINT NOT NULL
);
CREATE TABLE `presentacion`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL
);
CREATE TABLE `ingrediente`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `stock` BIGINT NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL
);
CREATE TABLE `producto_presentacion`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `producto_id` BIGINT NOT NULL,
    `presentacion_id` BIGINT NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL
);
ALTER TABLE
    `ingredientes_extra` ADD CONSTRAINT `ingredientes_extra_ingrediente_id_foreign` FOREIGN KEY(`ingrediente_id`) REFERENCES `ingrediente`(`id`);
ALTER TABLE
    `producto` ADD CONSTRAINT `producto_tipo_producto_id_foreign` FOREIGN KEY(`tipo_producto_id`) REFERENCES `tipo_producto`(`id`);
ALTER TABLE
    `detalle_pedido` ADD CONSTRAINT `detalle_pedido_combo_id_foreign` FOREIGN KEY(`combo_id`) REFERENCES `combo`(`id`);
ALTER TABLE
    `pedido` ADD CONSTRAINT `pedido_metodo_pago_id_foreign` FOREIGN KEY(`metodo_pago_id`) REFERENCES `metodo_pago`(`id`);
ALTER TABLE
    `factura` ADD CONSTRAINT `factura_cliente_id_foreign` FOREIGN KEY(`cliente_id`) REFERENCES `cliente`(`id`);
ALTER TABLE
    `combo_producto` ADD CONSTRAINT `combo_producto_producto_id_foreign` FOREIGN KEY(`producto_id`) REFERENCES `producto`(`id`);
ALTER TABLE
    `factura` ADD CONSTRAINT `factura_pedido_id_foreign` FOREIGN KEY(`pedido_id`) REFERENCES `pedido`(`id`);
ALTER TABLE
    `detalle_pedido` ADD CONSTRAINT `detalle_pedido_pedido_id_foreign` FOREIGN KEY(`pedido_id`) REFERENCES `pedido`(`id`);
ALTER TABLE
    `producto_presentacion` ADD CONSTRAINT `producto_presentacion_presentacion_id_foreign` FOREIGN KEY(`presentacion_id`) REFERENCES `presentacion`(`id`);
ALTER TABLE
    `producto_presentacion` ADD CONSTRAINT `producto_presentacion_producto_id_foreign` FOREIGN KEY(`producto_id`) REFERENCES `producto`(`id`);
ALTER TABLE
    `detalle_pedido` ADD CONSTRAINT `detalle_pedido_producto_id_foreign` FOREIGN KEY(`producto_id`) REFERENCES `producto`(`id`);
ALTER TABLE
    `ingredientes_extra` ADD CONSTRAINT `ingredientes_extra_detalle_pedido_id_foreign` FOREIGN KEY(`detalle_pedido_id`) REFERENCES `detalle_pedido`(`id`);
ALTER TABLE
    `combo_producto` ADD CONSTRAINT `combo_producto_combo_id_foreign` FOREIGN KEY(`combo_id`) REFERENCES `combo`(`id`);