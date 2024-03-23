CREATE SCHEMA IF NOT EXISTS `Alke_Wallet` DEFAULT CHARACTER SET utf8mb4;
USE Alke_Wallet;

CREATE TABLE IF NOT EXISTS usuario(
user_id INT primary key auto_increment,
nombre VARCHAR(50) NOT NULL,
correo_electronico VARCHAR(100) NOT NULL UNIQUE,
contrasegna VARCHAR(8) NOT NULL,
saldo DECIMAL(10,2) NOT NULL,
fecha_creacion TIMESTAMP
);

CREATE TABLE  IF NOT EXISTS  moneda(
currency_id INT primary key auto_increment,
currency_name VARCHAR(50) NOT NULL UNIQUE,
currency_symbol CHAR(3),
creationDate timestamp
);

CREATE TABLE  IF NOT EXISTS  transaccion(
transaction_id INT primary key auto_increment,
sender_user_id INT,
receiver_user_id INT,
moneda_id INT,
importe DECIMAL(10,2) NOT NULL,
CONSTRAINT sender_user FOREIGN KEY(sender_user_id) REFERENCES usuario(user_id) ON DELETE SET NULL,
CONSTRAINT receiver_user FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id) ON DELETE SET NULL,
CONSTRAINT moneda FOREIGN KEY (moneda_id) REFERENCES moneda(currency_id) ON DELETE SET NULL,
transaction_date TIMESTAMP
);



INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Rublo', '₽', CURRENT_TIMESTAMP);
INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Won', '₩', CURRENT_TIMESTAMP);
INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Yen japonés', '¥', CURRENT_TIMESTAMP);
INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Euro', '€', CURRENT_TIMESTAMP);
INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Dólar canadiense', 'C$', CURRENT_TIMESTAMP);
INSERT INTO moneda (currency_name, currency_symbol, creationDate) 
VALUES ('Dólar estadounidense', 'US$', CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('Cliente01','cliente1@hotmail.com','12345678', 50.000, CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('Cliente02','Cliente02@hotmail.com','12345678', 200.000, CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('Cliente03','Cliente03@hotmail.com','12345678', 100.000, CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('Cliente04','Cliente04@hotmail.com','12345678', 150.000, CURRENT_TIMESTAMP);

INSERT INTO usuario (nombre, correo_electronico,contrasegna,saldo,fecha_creacion) 
VALUES ('Cliente05','Cliente05@hotmail.com','12345678', 250.000, CURRENT_TIMESTAMP);


INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (1,2,3,10.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (1,4,1,20.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (2,4,2,30.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date) 
VALUES (4,1,2,40.000,CURRENT_TIMESTAMP);

INSERT INTO transaccion(sender_user_id, receiver_user_id, moneda_id, importe, transaction_date)
VALUES (5,2,5,50.000,CURRENT_TIMESTAMP);


-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
SELECT nombre, currency_name FROM transaccion 
INNER JOIN moneda ON transaccion.moneda_id = moneda.currency_id
INNER JOIN usuario ON  transaccion.sender_user_id =  usuario.user_id
WHERE sender_user_id = 1;

SELECT nombre,currency_name FROM usuario
INNER JOIN transaccion ON transaccion.sender_user_id = usuario.user_id
INNER JOIN moneda ON moneda.currency_id =  transaccion.moneda_id 
WHERE user_id = 1;

SELECT nombre, currency_name FROM moneda
INNER JOIN transaccion ON transaccion.moneda_id = moneda.currency_id
INNER JOIN usuario ON  transaccion.sender_user_id =  usuario.user_id
WHERE user_id = 1;


-- Consulta para obtener todas las transacciones registradas
SELECT transaction_id, sender.nombre AS sender_user, receiver.nombre AS receiver_user,currency_symbol, importe, transaction_date
FROM transaccion
INNER JOIN usuario AS sender ON sender.user_id = transaccion.sender_user_id
INNER JOIN usuario AS receiver ON receiver.user_id = transaccion.receiver_user_id
INNER JOIN moneda ON currency_id = moneda.currency_id
ORDER BY transaction_id ASC;

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
SELECT transaction_id, sender.nombre AS sender_user, receiver.nombre AS receiver_user,currency_symbol, importe, transaction_date
FROM transaccion
INNER JOIN usuario AS sender ON sender.user_id = transaccion.sender_user_id
INNER JOIN usuario AS receiver ON receiver.user_id = transaccion.receiver_user_id
INNER JOIN moneda ON currency_id = moneda.currency_id
WHERE sender_user_id = 1
ORDER BY transaction_id ASC;

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico
UPDATE usuario SET correo_electronico = 'cliente01@hotmail.com'
WHERE user_id = 1;

--Sentencia de eliminar una transacción
DELETE FROM transaccion
WHERE transaction_id = 2;

Github https://github.com/cga1github/Entrega-modulo-3.git