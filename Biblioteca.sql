CREATE DATABASE Biblioteca;

USE Biblioteca;

CREATE TABLE AUTOR
(
 CODIGO INT PRIMARY KEY NOT NULL,
 NOMBRE VARCHAR(30) NOT NULL
);

CREATE TABLE LIBRO
(
 CODIGO_LIBRO INT PRIMARY KEY NOT NULL,
 TITULO       VARCHAR(50) NOT NULL,
 ISBN         VARCHAR(15) NOT NULL,
 PAGINAS      INT NOT NULL,
 EDITORIAL    VARCHAR(25)
);

CREATE TABLE AUTOR_LIBRO
(
 CODIGO_AUTOR INT NOT NULL,
 CODIGO_LIBRO INT NOT NULL,
 CONSTRAINT PK_AUTOR_LIBRO PRIMARY KEY (CODIGO_AUTOR, CODIGO_LIBRO),
 FOREIGN KEY (CODIGO_AUTOR) REFERENCES AUTOR(CODIGO),
 FOREIGN KEY (CODIGO_LIBRO) REFERENCES LIBRO(CODIGO_LIBRO)
);

CREATE TABLE LOCALIZACION
(
 ID_LOCALIZACION INT PRIMARY KEY NOT NULL,
 RECINTO VARCHAR(25) NOT NULL
);

CREATE TABLE EJEMPLAR
(
 CODIGO_EJEMPLAR INT PRIMARY KEY NOT NULL,
 LOCALIZACION   INT,
 FOREIGN KEY (LOCALIZACION) REFERENCES LOCALIZACION(ID_LOCALIZACION)
);

CREATE TABLE USUARIO
(
 CODIGO_USUARIO INT PRIMARY KEY NOT NULL,
 NOMBRE         VARCHAR(20) NOT NULL,
 APELLIDOS      VARCHAR(40) NOT NULL,
 TELEFONO       VARCHAR(10) NULL,
 DIRECCION      VARCHAR(100) NOT NULL,
 CARRERA        VARCHAR(40) NOT NULL,
 LOCALIZACION   INT NOT NULL,
 FOREIGN KEY (LOCALIZACION) REFERENCES LOCALIZACION(ID_LOCALIZACION)
);

CREATE TABLE USUARIO_EJEMPLAR
(
 CODIGO_USUARIO   INT NOT NULL,
 CODIGO_EJEMPLAR  INT NOT NULL,
 FECHA_PRESTAMO   DATETIME NOT NULL,
 FECHA_DEVOLUCION DATE NOT NULL,
 CONSTRAINT PK_USUARIO_EJEMPLAR PRIMARY KEY (CODIGO_USUARIO, CODIGO_EJEMPLAR),
 FOREIGN KEY (CODIGO_EJEMPLAR) REFERENCES EJEMPLAR(CODIGO_EJEMPLAR),
 FOREIGN KEY (CODIGO_USUARIO) REFERENCES USUARIO(CODIGO_USUARIO)
);

-- Insertar datos iniciales
INSERT INTO LOCALIZACION (ID_LOCALIZACION, RECINTO)
VALUES (1, 'Turrialba'), (2, 'Paraiso'), (3, 'Guapiles');

INSERT INTO EJEMPLAR (CODIGO_EJEMPLAR, LOCALIZACION)
VALUES (1, 1), (2, 2), (3, 3);

INSERT INTO AUTOR (CODIGO, NOMBRE)
VALUES (1, 'Gabriel García Márquez'), (2, 'Isabel Allende');

INSERT INTO LIBRO (CODIGO_LIBRO, TITULO, ISBN, PAGINAS, EDITORIAL)
VALUES (1, 'The Shawshank Redemption', '9781234567897', 142, 'Castle Rock Press');

INSERT INTO USUARIO (CODIGO_USUARIO, NOMBRE, APELLIDOS, TELEFONO, DIRECCION, CARRERA, LOCALIZACION)
VALUES (1, 'Jurguen', 'Zamora', '22812612', 'Limon', 'Informatica Empresarial', 1);

CREATE PROCEDURE Biblioteca.InsertarPrestamo
    @CODIGO_USUARIO INT,
    @CODIGO_EJEMPLAR INT,
    @FECHA_PRESTAMO DATETIME,
    @FECHA_DEVOLUCION DATE
AS
BEGIN
    INSERT INTO USUARIO_EJEMPLAR (CODIGO_USUARIO, CODIGO_EJEMPLAR, FECHA_PRESTAMO, FECHA_DEVOLUCION)
    VALUES (@CODIGO_USUARIO, @CODIGO_EJEMPLAR, @FECHA_PRESTAMO, @FECHA_DEVOLUCION);
END;

CREATE PROCEDURE Biblioteca.ConsultarLibros
    @TITULO VARCHAR(50) = NULL
AS
BEGIN
    IF @TITULO IS NULL
        SELECT CODIGO_LIBRO, TITULO, ISBN, PAGINAS, EDITORIAL FROM LIBRO;
    ELSE
        SELECT CODIGO_LIBRO, TITULO, ISBN, PAGINAS, EDITORIAL FROM LIBRO
        WHERE TITULO LIKE '%' + @TITULO + '%';
END;

CREATE PROCEDURE Biblioteca.ActualizarAutor
    @CODIGO INT,
    @NOMBRE VARCHAR(30)
AS
BEGIN
    UPDATE AUTOR SET NOMBRE = @NOMBRE WHERE CODIGO = @CODIGO;
END;

CREATE PROCEDURE Biblioteca.BorrarEstudiante
    @CODIGO_USUARIO INT
AS
BEGIN
    DELETE FROM USUARIO WHERE CODIGO_USUARIO = @CODIGO_USUARIO;
END;

EXEC biblioteca.InsertarPrestamo 
    @CODIGO_USUARIO = 2, 
    @CODIGO_EJEMPLAR = 5, 
    @FECHA_PRESTAMO = '2024-11-17 10:00:00', 
    @FECHA_DEVOLUCION = '2024-11-20';

EXEC Biblioteca.ConsultarLibros;

EXEC Biblioteca.ActualizarAutor @CODIGO = 1, @NOMBRE = 'Jurguen Salas Herrera';

EXEC Biblioteca.BorrarEstudiante @CODIGO_USUARIO = 7;

SELECT * FROM Biblioteca.USUARIO_EJEMPLAR;
SELECT * FROM Biblioteca.LIBRO;
SELECT * FROM Biblioteca.AUTOR;
SELECT * FROM Biblioteca.USUARIO;
;

