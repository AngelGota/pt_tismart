-- Prueba para SP_HOSPITAL_REGISTRAR
-- Registrar hospitales, con gerente, condición, sede y distrito:
BEGIN
    -- Asociacion de parametros posicionales
    SP_HOSPITAL_REGISTRAR(5,4,'Hospital prueba',99,'300,60',5,4,1);
    
END;
-- ------------
-- ------------

SELECT * FROM HOSPITAL;

SELECT COUNT(*) FROM HOSPITAL;

-- Prueba para SP_HOSPITAL_ACTUALIZAR
-- Actualizar registros del hospital como gerente, condición, sede y distrito.
DECLARE
v_mensaje VARCHAR2(100);
BEGIN
    -- Asociacion de parametros especifica
    SP_HOSPITAL_ACTUALIZAR(
    p_idHospital => 3, 
    p_idDistrito => '',
    p_idSede => 2,
    p_idGerente => 3, 
    p_idCondicion => 2,
    p_mensaje => v_mensaje);
    
    DBMS_OUTPUT.PUT_LINE('ESTADO: '||v_mensaje);
    
END;
-- ------------
-- ------------


-- Prueba para SP_HOSPITAL_ELIMINAR
-- Eliminar hospitales, por IdHospital.
DECLARE
v_mensaje VARCHAR2(100);
BEGIN
    SP_HOSPITAL_ELIMINAR(p_idHospital => 5, p_mensaje => v_mensaje);
    
    DBMS_OUTPUT.PUT_LINE('ESTADO: '||v_mensaje);
END;


-- Prueba para SP_HOSPITAL_LISTAR
-- Lista de datos dinaminos
DECLARE
    -- Declaración del cursor para el resultado
    c_resultado SYS_REFCURSOR;

    -- Variables para los parámetros de entrada
    v_nombre_hospital VARCHAR2(100) := '';
    v_nombre_gerente VARCHAR2(100) := 'Benjamin';
    v_desc_condicion VARCHAR2(100) := '';
    v_desc_distrito VARCHAR2(100) := '';
    v_desc_sede VARCHAR2(100) := '';
    v_fecha_registro DATE := TO_DATE('', 'YYYY-MM-DD');

    -- Variables para leer los resultados del cursor
    v_id_hospital NUMBER;
    v_nombre_hospital_resultado VARCHAR2(100);
    v_antiguedad NUMBER;
    v_area NUMBER;
    v_desc_gerente VARCHAR2(100);
    v_desc_condicion_resultado VARCHAR2(100);
    v_desc_sede_resultado VARCHAR2(100);
    v_desc_distrito_resultado VARCHAR2(100);
BEGIN
    -- Llamar al procedimiento y pasar los parámetros
    SP_HOSPITAL_LISTAR(
        p_nombre => v_nombre_hospital,
        p_nombre_gerente => v_nombre_gerente,
        p_desc_condicion => v_desc_condicion,
        p_desc_distrito => v_desc_distrito,
        p_desc_sede => v_desc_sede,
        p_fecha_registro => v_fecha_registro,
        p_resultado => c_resultado
    );

    -- Mostrar los resultados del cursor
    DBMS_OUTPUT.PUT_LINE('------- RESULTADOS DEL CURSOR -------');
    LOOP
        FETCH c_resultado INTO v_id_hospital, v_nombre_hospital_resultado, v_antiguedad, v_area, v_desc_gerente, v_desc_condicion_resultado, v_desc_sede_resultado, v_desc_distrito_resultado;
        EXIT WHEN c_resultado%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_hospital || ', Nombre: ' || v_nombre_hospital_resultado || ', Antigüedad: ' || v_antiguedad || ', Área: ' || v_area || ', Gerente: ' || v_desc_gerente || ', Condición: ' || v_desc_condicion_resultado || ', Sede: ' || v_desc_sede_resultado || ', Distrito: ' || v_desc_distrito_resultado);
    END LOOP;

    -- Cerrar el cursor
    CLOSE c_resultado;
END;



set SERVEROUTPUT on;

