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
BEGIN
    SP_HOSPITAL_LISTAR;
END;







