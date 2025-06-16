CREATE PROCEDURE ps_actualizar_precio_productos(IN p_producto_id INT, IN p_nuevo_precio DECIMAL(10,2))
BEGIN
    DECLARE _pro_pre_id INT;     -- producto presentacion id
    DECLARE _rows_loop INT DEFAULT 0;
    DECLARE _counter_loop INT DEFAULT 0;

    DECLARE cur_pro CURSOR FOR
        SELECT presentacion_id FROM producto_presentacion WHERE producto_id = p_producto_id AND presentacion_id <> 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Actualizar
    UPDATE producto_presentacion SET precio = p_nuevo_precio WHERE producto_id = p_producto_id AND presentacion_id = 1;

    -- Validacion del UPDATE
    IF ROW_COUNT() = 0 THEN
        SELECT 'No se encontro el producto' AS Error;
    ELSE
        -- Asignar la cantidad de filas o registros Para el LOOP
        SET _rows_loop = (SELECT COUNT(*) FROM producto_presentacion WHERE producto_id = p_producto_id AND presentacion_id <> 1);

        OPEN cur_pro;

        leer_pro : LOOP
            FETCH cur_pro INTO _pro_pre_id; -- fila 2
            SET _counter_loop = _counter_loop + 1; -- 2

            UPDATE producto_presentacion
            SET precio = p_nuevo_precio + (p_nuevo_precio * 0.11)
            WHERE producto_id = p_producto_id AND presentacion_id = _pro_pre_id;

            -- Validar LOOP
            IF _counter_loop >= _rows_loop THEN -- 2 >= 2 = FALSE
                LEAVE leer_pro;
            END IF;
        END LOOP leer_pro;

        CLOSE cur_pro;

        IF ROW_COUNT() > 0 THEN
            SELECT 'Producto actualizado' AS Message;
        ELSE
            SELECT 'No se actualizo el precio de las otras presentaciones del producto' AS Error;
        END IF;
    END IF;
END;


DESCRIBE pedido;

DELIMITER $$

DROP FUNCTION IF EXISTS fn_calcular_subtotal_pedido $$

CREATE FUNCTION fn_calcular_subtotal_pedido(p_pedido_id INT)
RETURNS DEC(10,2)
NOT DETERMINISTIC
BEGIN

    RETURN 0.00;    

END $$

DELIMITER;

DELIMITER $$
CREATE PROCEDURE ps_add_pizza_con_ingredientes(
    IN p_nombre_pizza VARCHAR(100),
    IN ps_ids_ingredientes TEXT
)

BEGIN 
    DECLARE v_producto_id BIGINT;

    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN 
    SELECT 'Error al insertar usuario' AS mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;
    INSERT INTO producto (nombre, tipo_producto_id) VALUES (p_nombre_pizza, 2);
    SET v_producto_id = LAST_INSERT_ID();    
    COMMIT;
    SELECT 'Usuario insertado correctamente' AS mensaje;
END $$
    WHILE 
DELIMITER ;

CALL ps_add_pizza_con_ingredientes('Pe', '1,2,3');

SELECT * FROM producto

DELIMITER $$

CREATE PROCEDURE ps_actualizar_precio_pizza(
    IN p_pizza_id TEXT,
    IN p_nuevo_precio DECIMAL(10,2)
)

BEGIN
    IF p_nuevo_precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio debe ser mayor a 0';
    END IF;

    UPDATE producto_presentacion
    SET precio = p_nuevo_precio
    WHERE producto_id = p_pizza_id;
END;

CALL ps_actualizar_precio_pizza('1', 5000);

