--- Procedure ---
    -- Bloco anonimo com nome que pode ser utilizadas em varios ambientes
    -- CREATE OR REPLACE(oracle salva o codigo)
    -- Paramentros de entrada(in) ,parametro de saida(out), entrada e saida (in/out) 
    
    --- Entrada ---
    CREATE OR REPLACE PROCEDURE PRC_INSERE_EMPREGADO(
        pfirst_name    IN VARCHAR2,
        plast_name     IN VARCHAR2, --se não colocar nada o default é in
        pemail         IN VARCHAR2,
        pphone_number  IN VARCHAR2,
        phire_date     IN DATE DEFAULT SYSDATE, -- se o usuario passar nulo assume o valor sysdate
        pjob_id        IN VARCHAR2,
        pSALARY        IN NUMBER,
        pCOMMICION_PCT IN NUMBER,
        pMANAGER_ID    IN NUMBER,
        pDEPARTMENT_ID IN NUMBER)
    IS -- Pode usar IS ou AS
    -- Aqui poderia declarar variaveis
    BEGIN
        INSERT INTO employees (employee_id,first_name,last_name,email,phone_number, hire_date,job_id,salary,commission_pct,manager_id,department_id )
            VALUES ( employees_seq.nextval, pfirst_name, plast_name,pemail, pphone_number, phire_date,pjob_id,psalary,pcommicion_pct,pmanager_id, pdepartment_id );
    EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro Oracle ' || SQLCODE || SQLERRM);
    END;

    -- Executando a Procedure pelo Bloco PL/SQL
    BEGIN PRC_INSERE_EMPREGADO('David', 'Bowie','DBOWIE','515.127.4861',SYSDATE,'IT_PROG',15000,NULL,103,60);
    COMMIT;
    END;

    -- Executando a Procedure com o comando EXECUTE do SQL*PLUS
    EXEC PRC_INSERE_EMPREGADO('Greg', 'Lake','GLAKE','515.127.4961',SYSDATE,'IT_PROG',15000,NULL,103,60)
    COMMIT;
    
    
    
    --- Entrada e Saida
        -- Os parametros são definidos por copia, mas pode usar o comando NOCOPY para fazer por referencia (o cogico é igual so colocar "NOCOPY" depois do out
        CREATE OR REPLACE PROCEDURE PRC_CONSULTA_EMPREGADO (pemployee_id   IN NUMBER,
            pfirst_name    OUT VARCHAR2,
            plast_name     OUT VARCHAR2,
            pemail         OUT VARCHAR2,
            pphone_number  OUT VARCHAR2,
            phire_date     OUT DATE,
            pjob_id        OUT VARCHAR2,
            pSALARY        OUT NUMBER,
            pCOMMISSION_PCT OUT NUMBER,
            pMANAGER_ID    OUT NUMBER,
            pDEPARTMENT_ID OUT NUMBER)
        IS 
            -- Nenhuma variável declarada
        BEGIN
            SELECT first_name,last_name,email, phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id
                INTO pfirst_name,plast_name, pemail,pphone_number, phire_date,pjob_id,psalary,pcommission_pct,pmanager_id,pdepartment_id
                FROM employees WHERE employee_id = pemployee_id;
      
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20001, 'Empregado Não existe: ' || pemployee_id);
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
            END;
            
        --Consulta para a procedure    
        SET SERVEROUTPUT ON
        SET VERIFY OFF
        DECLARE 
            employees_record  employees%ROWTYPE;
        BEGIN
            PRC_CONSULTA_EMPREGADO(100, employees_record.first_name, employees_record.last_name, employees_record.email,
                employees_record.phone_number, employees_record.hire_date, employees_record.job_id, employees_record.salary, 
                employees_record.commission_pct, employees_record.manager_id, employees_record.department_id);
            DBMS_OUTPUT.PUT_LINE(employees_record.first_name || ' ' || 
                         employees_record.last_name || ' - ' ||
                         employees_record.department_id || ' - ' ||
                         employees_record.job_id || ' - ' ||
                         employees_record.phone_number || ' - ' ||
                         LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
        END;
        
--- Metodos de Passar Parametros para a procedure
    -- Nomeado (chama a procedure colocando nome_parametro => valor,nome_parametro => valor,, ...) 
    -- Posicional (passa na ordem que foi declarado na procedure)
        
    -- Posicional (é igual ao anterior)
    PRC_CONSULTA_EMPREGADO(100, employees_record.first_name, employees_record.last_name, employees_record.email,
                employees_record.phone_number, employees_record.hire_date, employees_record.job_id, employees_record.salary, 
                employees_record.commission_pct, employees_record.manager_id, employees_record.department_id);
    
    -- Nomeado
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        VEMPLOYEE_ID NUMBER := 100;
        VFIRST_NAME VARCHAR2(200);
        VLAST_NAME VARCHAR2(200);
        VEMAIL VARCHAR2(200);
        VPHONE_NUMBER VARCHAR2(200);
        VHIRE_DATE DATE;
        VJOB_ID VARCHAR2(200);
        VSALARY NUMBER;
        VCOMMISSION_PCT NUMBER;
        VMANAGER_ID NUMBER;
        VDEPARTMENT_ID NUMBER;
    BEGIN
        PRC_CONSULTA_EMPREGADO(PEMPLOYEE_ID => VEMPLOYEE_ID, PFIRST_NAME => VFIRST_NAME,PLAST_NAME => VLAST_NAME,PEMAIL => VEMAIL, PPHONE_NUMBER => VPHONE_NUMBER,
            PHIRE_DATE => VHIRE_DATE,PJOB_ID => VJOB_ID, PSALARY => VSALARY,PCOMMISSION_PCT => VCOMMISSION_PCT,PMANAGER_ID => VMANAGER_ID,PDEPARTMENT_ID => VDEPARTMENT_ID
    );

        DBMS_OUTPUT.PUT_LINE('PFIRST_NAME = ' || VFIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('PLAST_NAME = ' || VLAST_NAME);
        DBMS_OUTPUT.PUT_LINE('PEMAIL = ' || VEMAIL);
        DBMS_OUTPUT.PUT_LINE('PPHONE_NUMBER = ' || VPHONE_NUMBER);
        DBMS_OUTPUT.PUT_LINE('PHIRE_DATE = ' || VHIRE_DATE);
        DBMS_OUTPUT.PUT_LINE('PJOB_ID = ' || VJOB_ID);
        DBMS_OUTPUT.PUT_LINE('PSALARY = ' || VSALARY);
        DBMS_OUTPUT.PUT_LINE('PCOMMISSION_PCT = ' || VCOMMISSION_PCT);
        DBMS_OUTPUT.PUT_LINE('PMANAGER_ID = ' || VMANAGER_ID);
        DBMS_OUTPUT.PUT_LINE('PDEPARTMENT_ID = ' || VDEPARTMENT_ID);
    END;
    
    
    -- Recompilar
        ALTER PROCEDURE PRC_INSERE_EMPREGADO COMPILE;
    
    -- Remover Procedure
        DROP PROCEDURE PRC_CONSULTA_EMPREGADO;
        
    

    
    


