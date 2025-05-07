CREATE DATABASE GestionAcademica;
USE GestionAcademica;

-- Tabla Departamento
CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Tabla Estudiante
CREATE TABLE Estudiante (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

-- Tabla Profesor
CREATE TABLE Profesor (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

-- Tabla Curso
CREATE TABLE Curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    creditos INT,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

-- Tabla Clase
CREATE TABLE Clase (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT,
    id_profesor INT,
    horario VARCHAR(100),
    aula VARCHAR(50),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);


-- Tabla Inscripcion
CREATE TABLE Inscripcion (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_clase INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase)
);

-- Tabla Calificacion
CREATE TABLE Calificacion (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT,
    nota DECIMAL(5,2),
    FOREIGN KEY (id_inscripcion) REFERENCES Inscripcion(id_inscripcion)
);

INSERT INTO Departamento (nombre) VALUES ('Ciencias'), ('Ingeniería');

INSERT INTO Estudiante (nombre, apellido, correo, id_departamento)
VALUES 
('Ana', 'Ramirez', 'ana.ramirez@email.com', 1),
('Carlos', 'Lopez', 'carlos.lopez@email.com', 2);

INSERT INTO Profesor (nombre, apellido, correo, id_departamento)
VALUES 
('Mario', 'Vega', 'mario.vega@email.com', 1),
('Laura', 'Gomez', 'laura.gomez@email.com', 2);

INSERT INTO Curso (nombre, creditos, id_departamento)
VALUES 
('Matemáticas', 4, 1),
('Programación', 5, 2);

INSERT INTO Clase (id_curso, id_profesor, horario, aula)
VALUES 
(1, 1, 'Lunes 8:00-10:00', 'A101'),
(2, 2, 'Martes 10:00-12:00', 'B202');

INSERT INTO Inscripcion (id_estudiante, id_clase, fecha_inscripcion)
VALUES 
(1, 1, '2024-02-01'),
(2, 2, '2024-02-02');

INSERT INTO Calificacion (id_inscripcion, nota)
VALUES 
(1, 90.5),
(2, 78.0);

SELECT nombre, apellido
FROM Estudiante
ORDER BY apellido;

SELECT * 
FROM Curso
WHERE creditos > 3;

SELECT E.nombre AS estudiante, C.nombre AS curso
FROM Estudiante E
INNER JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
INNER JOIN Clase CL ON I.id_clase = CL.id_clase
INNER JOIN Curso C ON CL.id_curso = C.id_curso;

SELECT E.nombre AS estudiante, C.nombre AS curso
FROM Estudiante E
LEFT JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
LEFT JOIN Clase CL ON I.id_clase = CL.id_clase
LEFT JOIN Curso C ON CL.id_curso = C.id_curso;

SELECT C.nombre AS curso, E.nombre AS estudiante
FROM Curso C
RIGHT JOIN Clase CL ON C.id_curso = CL.id_curso
RIGHT JOIN Inscripcion I ON CL.id_clase = I.id_clase
RIGHT JOIN Estudiante E ON I.id_estudiante = E.id_estudiante;

SELECT D.nombre AS departamento, COUNT(E.id_estudiante) AS total_estudiantes
FROM Departamento D
LEFT JOIN Estudiante E ON D.id_departamento = E.id_departamento
GROUP BY D.nombre;

SELECT E.nombre, AVG(CA.nota) AS promedio
FROM Estudiante E
JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
JOIN Calificacion CA ON I.id_inscripcion = CA.id_inscripcion
GROUP BY E.nombre;

SELECT CL.id_clase, MAX(CA.nota) AS nota_max, MIN(CA.nota) AS nota_min
FROM Clase CL
JOIN Inscripcion I ON CL.id_clase = I.id_clase
JOIN Calificacion CA ON I.id_inscripcion = CA.id_inscripcion
GROUP BY CL.id_clase;


SELECT E.nombre, AVG(CA.nota) AS promedio
FROM Estudiante E
JOIN Inscripcion I ON E.id_estudiante = I.id_estudiante
JOIN Calificacion CA ON I.id_inscripcion = CA.id_inscripcion
GROUP BY E.nombre
ORDER BY promedio DESC
LIMIT 5;

UPDATE Estudiante
SET correo = 'nuevo.correo@email.com'
WHERE id_estudiante = 1;

DELETE FROM Inscripcion
WHERE id_inscripcion = 1;

-- 10. Cambiar correo de un estudiante
UPDATE Estudiante 
SET correo = 'nuevo.correo@email.com' 
WHERE id_estudiante = 1;

-- 11. Eliminar una inscripción
DELETE FROM Inscripcion 
WHERE id_inscripcion = 1;