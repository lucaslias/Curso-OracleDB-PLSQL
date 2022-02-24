--- Funcoes ---
    -- Rotina que retorna valor
    -- Se retorna obrigatoriamente um valor -> Fun��o
    -- Se retorna nenhum ou mais de um -> Procedure
    
    CREATE OR REPLACE FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO
        (pemployee_id   IN NUMBER)
        RETURN NUMBER
    IS 
        vSalary  employees.salary%TYPE;
    BEGIN
        SELECT salary INTO   vsalary FROM   employees WHERE employee_id = pemployee_id;
        RETURN (vsalary);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Empregado inexistente');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || ' - ' || SQLERRM);
        END;

    -- Executando a Fun��o pelo Bloco PL/SQL
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
    DECLARE
        vEmployee_id  employees.employee_id%TYPE := &pemployee_id;
        vSalary       employees.salary%TYPE;
    BEGIN
        vsalary := FNC_CONSULTA_SALARIO_EMPREGADO(vEmployee_id);
        DBMS_OUTPUT.PUT_LINE('Salario: ' || vsalary);
    END;
    
    
    -- Utilizar fun��es em comandos SQL
        -- Tem que ser Single-Row, n�o tem comando DML, somente parametros tipo ins, n�o pode retornar boolean, record ou table
        SELECT employee_id, first_name, last_name, job_id, FNC_CONSULTA_TITULO_CARGO(job_id) "JOB TITLE"
        FROM   employees;

    -- Executando a Fun��o pelo comando SELECT
        SELECT FNC_CONSULTA_TITULO_CARGO('IT_PROG')
        FROM   dual;

    -- Executando a Fun��o pelo comando SELECT
        SELECT FNC_CONSULTA_SALARIO_EMPREGADO(130)
        FROM   dual;
        
-- Recompilar Fun��es
    ALTER FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO COMPILE;

-- Remover Fun��es
    DROP FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO;
        
        

    