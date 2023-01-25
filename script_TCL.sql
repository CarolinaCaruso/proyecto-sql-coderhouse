USE pizzeria;

SET AUTOCOMMIT = 0;

# Punto (1) TABLA CLIENTES
START TRANSACTION;

DELETE FROM clientes WHERE id_cliente = 2;
DELETE FROM clientes WHERE id_cliente = 3;
DELETE FROM clientes WHERE id_cliente = 45;

# ROLLBACK;
COMMIT;

# Sentencias para re-insertar los 3 registros eliminados
# insert into clientes (id_cliente, nombre, direccion, telefono) values (2, 'Eward Hutcheon', '8 Dapin Trail', '6327596657');
# insert into clientes (id_cliente, nombre, direccion, telefono) values (3, 'Alejandrina Luna', '5 Bashford Circle', '6311760244');
# insert into clientes (id_cliente, nombre, direccion, telefono) values (45, 'Windy Sedman', '125 Mcbre Point', '1262849995');

# Punto (2) TABLA PROVEEDORES
START TRANSACTION;

INSERT INTO proveedores VALUES (NULL, 'Distribuidor Handy', 'Pepiri 123', '1112345632');
INSERT INTO proveedores VALUES (NULL, 'Mayorista Lacteos', 'Los corrales 555', '1148795731');
INSERT INTO proveedores VALUES (NULL, 'Verduleria San Carlos', 'Formosa 40', '1148715789');
INSERT INTO proveedores VALUES (NULL, 'Maria Mayorista', 'Andagala 567', '1148794567');
INSERT INTO proveedores VALUES (NULL, 'Makro', 'Rivadavia 789', '1156324879');

SAVEPOINT primer_lote;

INSERT INTO proveedores VALUES (NULL, 'Mayorista Mundo Harina', 'Caupolican 333', '1178564830');
INSERT INTO proveedores VALUES (NULL, 'Coto', 'Salta 777', '1144432589');
INSERT INTO proveedores VALUES (NULL, 'Molinos Viento Sur', 'Republica Portugal 445', '1148785639');
INSERT INTO proveedores VALUES (NULL, 'Carrefour', 'Paez 1547', '1116782345');

SAVEPOINT primer_lote;

RELEASE SAVEPOINT primer_lote;

