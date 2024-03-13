-- Prueba técnica Nª1 - Angelo Smith Gomez Tapia
-- Creacion de tablas 
CREATE TABLE Gerente (
    idGerente NUMBER PRIMARY KEY,
    descGerente VARCHAR2(30),
    fechaRegistro DATE
);

CREATE TABLE Condicion (
    idCondicion NUMBER PRIMARY KEY,
    descCondicion VARCHAR2(30),
    fechaRegistro DATE
);

CREATE TABLE Provincia (
    idProvincia NUMBER PRIMARY KEY,
    descProvincia VARCHAR2(30),
    fechaRegistro DATE
);

CREATE TABLE Distrito (
    idDistrito NUMBER PRIMARY KEY,
    idProvincia NUMBER,
    descDistrito VARCHAR2(30),
    fechaRegistro DATE,
    CONSTRAINT fk_provincia FOREIGN KEY (idProvincia) REFERENCES Provincia(idProvincia)
);

CREATE TABLE Sede (
    idGerente NUMBER PRIMARY KEY,
    descSede VARCHAR2(30),
    fechaRegistro DATE
);

CREATE TABLE Hospital (
    idHospital NUMBER PRIMARY KEY,
    idDistrito NUMBER,
    nombre VARCHAR2(30),
    antiguedad NUMBER,
    area DECIMAL(5,2),
    idSede NUMBER,
    idGerente NUMBER,
    idCondicion NUMBER,
    fechaRegistro DATE,
    CONSTRAINT fk_distrito FOREIGN KEY (idDistrito) REFERENCES Distrito(idDistrito),
    CONSTRAINT fk_sede FOREIGN KEY (idSede) REFERENCES Sede(idGerente),
    CONSTRAINT fk_gerente FOREIGN KEY (idGerente) REFERENCES Gerente(idGerente),
    CONSTRAINT fk_condicion FOREIGN KEY (idCondicion) REFERENCES Condicion(idCondicion)
);

-- Insercion de datos
INSERT INTO Gerente VALUES (1, 'Angelo', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Gerente VALUES (2, 'Alfredo', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Gerente VALUES (3, 'Rosalia', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Gerente VALUES (4, 'Benjamin', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Gerente VALUES (5, 'Julio', TO_DATE('2024-03-12', 'YYYY-MM-DD'));

INSERT INTO Condicion VALUES (1, 'Operativo', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Condicion VALUES (2, 'No operativo', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Condicion VALUES (3, 'En mantenimiento', TO_DATE('2024-03-12', 'YYYY-MM-DD'));

INSERT INTO Provincia VALUES (1, 'Lima', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Provincia VALUES (2, 'Chiclayo', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Provincia VALUES (3, 'Trujillo', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Provincia VALUES (4, 'Ica', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Provincia VALUES (5, 'Cuzco', TO_DATE('2024-03-12', 'YYYY-MM-DD'));

INSERT INTO Distrito VALUES (1, 1, 'Miraflores', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Distrito VALUES (2, 2, 'Santa Victoria', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Distrito VALUES (3, 3, 'Victor Larco Herrera', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Distrito VALUES (4, 4, 'Ica', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Distrito VALUES (5, 5, 'Cuzco', TO_DATE('2024-03-12', 'YYYY-MM-DD'));

INSERT INTO Sede VALUES (1, 'SDS LIMA', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Sede VALUES (2, 'SDS CHICLAYO', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Sede VALUES (3, 'SDS TRUJILLO', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Sede VALUES (4, 'SDS ICA', TO_DATE('2024-03-12', 'YYYY-MM-DD'));
INSERT INTO Sede VALUES (5, 'SDS CUZCO', TO_DATE('2024-03-12', 'YYYY-MM-DD'));

select * from Gerente;
select * from Hospital;
select * from Condicion;
select * from Provincia;
select * from Distrito;
select * from Sede;

commit;




