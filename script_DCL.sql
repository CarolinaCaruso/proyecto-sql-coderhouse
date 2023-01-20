# Crea un usuario llamado "usuario1" en el host local y le asigna la contraseña "Contrasenia1"
CREATE USER usuario1@localhost IDENTIFIED BY 'Contrasenia1';

# Al usuario1 se le otorgan permismos de lectura en todas las tablas
GRANT SELECT ON pizzeria.* TO usuario1@localhost;

# Crea un usuario llamado "usuario2" en el host local y le asigna la contraseña "Contrasenia2"
CREATE USER usuario2@localhost IDENTIFIED BY 'Contrasenia2';

# Al usuario1 se le otorgan permismos de lectura, insercion y actualizacion en todas las tablas
GRANT SELECT, INSERT, UPDATE ON pizzeria.* TO usuario2@localhost;

