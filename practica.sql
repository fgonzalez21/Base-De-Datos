-- Crear la base de datos
CREATE DATABASE registoEscolar;
USE registroEscolar;

-- Tabla: Departamento
CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL
);

-- Tabla: Direcciones
CREATE TABLE Direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(100),
    ciudad VARCHAR(50),
    estado VARCHAR(50),
    codigo_postal VARCHAR(10)
);
-- Tabla: Estudiantes
CREATE TABLE Estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento DATE,
    id_direccion INT,
    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabla: Profesores
CREATE TABLE Profesores (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabla: Curso
CREATE TABLE Curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100),
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabla: Matriculas
CREATE TABLE Matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha_matricula DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



