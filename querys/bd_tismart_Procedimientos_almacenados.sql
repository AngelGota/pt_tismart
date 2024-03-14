-- PROCEDURE 2A:
-- SP_HOSPITAL_REGISTRAR
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_REGISTRAR (
    p_idHospital IN NUMBER,
    p_idDistrito IN NUMBER,
    p_nombre IN VARCHAR2,
    p_antiguedad IN NUMBER,
    p_area IN NUMBER,
    p_idSede IN NUMBER,
    p_idGerente IN NUMBER,
    p_idCondicion IN NUMBER
) IS

v_idHospital number;
slt_ln varchar(1):=chr(10);

BEGIN
    -- Verificacion del ID
    SELECT COUNT(*)
    INTO v_idHospital
    FROM Hospital
    WHERE idHospital = p_idHospital;
    -- Condicion y manejo de errores
    IF v_idHospital = 0 THEN
        -- El ID del hospital no existe, se puede insertar el nuevo registro
        IF p_idHospital >= 0 THEN
            INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion, fechaRegistro)
            VALUES (p_idHospital, p_idDistrito,p_nombre, p_antiguedad, p_area,p_idSede,p_idGerente, p_idCondicion, SYSDATE);
            DBMS_OUTPUT.PUT_LINE('Nuevo registro de hospital registrado correctamente');
        ELSE
            DBMS_OUTPUT.PUT_LINE('El ID del hospital no puede ser negativo.');
        END IF;
    ELSE
        -- Manejo de error si no cumple el if:
        DBMS_OUTPUT.PUT_LINE('El ID del hospital ya existe');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar en la tabla hospital');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Detalle del error: '||SQLERRM);
END;

-- -----------------
-- -----------------

-- PROCEDURE 2B:
-- SP_HOSPITAL_ACTUALIZAR
-- Actualizar registros del hospital como gerente, condición, sede y distrito.

CREATE OR REPLACE PROCEDURE SP_HOSPITAL_ACTUALIZAR (
   p_idHospital IN NUMBER,
   p_idGerente IN NUMBER,
   p_idCondicion IN NUMBER,
   p_idSede IN NUMBER,
   p_idDistrito IN NUMBER,
   p_mensaje OUT VARCHAR2
)
IS
  l_count NUMBER;
  slt_ln varchar(1):=chr(10);
BEGIN
  -- Verifica si el ID del hospital existe y si los datos son válidos
  SELECT COUNT(*)
  INTO l_count
  FROM Hospital
  WHERE idHospital = p_idHospital;

  IF l_count = 0 THEN
    p_mensaje := 'El ID del hospital no existe.';
  ELSE
    IF p_idGerente IS NULL OR p_idCondicion IS NULL OR p_idSede IS NULL OR p_idDistrito IS NULL THEN
      p_mensaje := 'Los datos del hospital no pueden ser nulos.';
    ELSE
      -- Actualiza el registro del hospital
      UPDATE Hospital
      SET idGerente = p_idGerente,
       idCondicion = p_idCondicion,
       idSede = p_idSede,
       idDistrito = p_idDistrito
      WHERE idHospital = p_idHospital;

      COMMIT; -- Confirmar los cambios en la base de datos.

      p_mensaje := 'Registros del hospital actualizados correctamente.';
    END IF;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK; -- Deshacer los cambios si ocurre algún error.
    p_mensaje := 'Error al actualizar el registro en la tabla hospital';
    DBMS_OUTPUT.PUT_LINE('Codigo de error: '||SQLCODE);
    DBMS_OUTPUT.PUT_LINE('Detalle del error: '||SQLERRM);
END;


-- -----------------
-- -----------------

-- PROCEDURE 2C:
-- SP_HOSPITAL_ELIMINAR 
-- Eliminar hospitales, por IdHospital.
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_ELIMINAR (
   p_idHospital IN NUMBER,
   p_mensaje OUT VARCHAR2
)
IS
  l_count NUMBER;
  slt_ln varchar(1):=chr(10);
BEGIN
  -- Verifica si el ID del hospital existe
  SELECT COUNT(*)
  INTO l_count
  FROM Hospital
  WHERE idHospital = p_idHospital;

  IF l_count = 0 THEN
    p_mensaje := 'El ID del hospital no existe.';
  ELSE
    -- Elimina el hospital con el IdHospital proporcionado.
    DELETE FROM Hospital
    WHERE idHospital = p_idHospital;

    COMMIT; -- Confirmar los cambios en la base de datos.

    p_mensaje := 'Hospital eliminado correctamente.';
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK; -- Deshacer los cambios si ocurre algún error.
    p_mensaje := 'Error al eliminar hospital';
    DBMS_OUTPUT.PUT_LINE('Codigo de error: '||SQLCODE);
    DBMS_OUTPUT.PUT_LINE('Detalle del error: '||SQLERRM);
END;



-- -----------------
-- -----------------

-- PROCEDURE 2D:
-- SP_HOSPITAL_LISTAR 
-- Realizar una lista dinámica.
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_LISTAR
IS
slt_ln varchar(1):=chr(10);
    CURSOR c_hospitales IS
        SELECT h.idHospital, h.nombre, h.antiguedad, h.area, g.descGerente, c.descCondicion, s.descSede, d.descDistrito
        FROM Hospital h
        INNER JOIN Gerente g ON h.idGerente = g.idGerente
        INNER JOIN Condicion c ON h.idCondicion = c.idCondicion
        INNER JOIN Sede s ON h.idSede = s.idGerente
        INNER JOIN Distrito d ON h.idDistrito = d.idDistrito;
BEGIN
    -- Imprime la lista de hospitales.
    DBMS_OUTPUT.PUT_LINE('------- LISTA DE HOSPITALES -------');
    FOR hospital IN c_hospitales LOOP
        DBMS_OUTPUT.PUT_LINE('- '|| hospital.nombre || ': Antigüedad - ' || hospital.antiguedad ||
        ' años. Área: ' || hospital.area ||'m2.'||slt_ln||'Gerente: ' || hospital.descGerente || '. Condición: ' || hospital.descCondicion || '. Sede: ' || hospital.descSede || '- Distrito: ' || hospital.descDistrito||slt_ln);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('ESTADO: SOLICITUD ACEPTADA');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al listar hospitales');
        DBMS_OUTPUT.PUT_LINE('Codigo de error: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Detalle del error: '||SQLERRM);
END;

commit;




