--- Tratamento de erro ---
    -- Pre-definidas: TOO_MANY_ROW, NO_DATA_FOUND, COLLECTTION_IS_NULL, CURSOR_ALREADY_OPEN, DUP_VAL_ON_INDEX(tetnativa de inserir valor duplicado em
        --indice unico), INVALID_CURSOR, INVALID_NUMBER(falha em converter string em numero), LOGIN_DENIED, NOT_LOGGER_ON(chamada ao banco sem estar conectado,
        -- TIMEOUT_ON_RESOURCE, VALUE_ERROR, ZERO_DIVIDE
    -- Definidas pelo desenvolvedor
    -- Que interceptam erros Oracle 
    -- RAISE_APPLICATION_ERROS para abortar o programa com a mensagem de erro definida
    
    --- Pre-Definidas ---
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    ACCEPT  pEmployee_id PROMPT 'Digite o Id do Empregado: '
    DECLARE
        vFirst_name   employees.first_name%TYPE;
        vLast_name    employees.last_name%TYPE;
        vEmployee_id  employees.employee_id%TYPE := &pEmployee_id;
    BEGIN
        SELECT first_name, last_name INTO   vfirst_name, vlast_name FROM employees WHERE  employee_id = vEmployee_id;
        DBMS_OUTPUT.PUT_LINE('Empregado: ' || vfirst_name || ' ' || vlast_name);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Empregado não encontrado, id = ' || 
            TO_CHAR(vEmployee_id));
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle - ' || SQLCODE || SQLERRM); --SQLCODE pega o codigo e SQLERRM para pegar o erro
    END;
    
    -- Definidas pelo desenvolvedor
        -- Usado para desviar o fluxo de exevução do programa para a seção de erros
        -- Interceptar um erro Oracle
        -- ´É tipo um GO TO, recurso porém não tanto recomendado
        SET SERVEROUTPUT ON
        SET VERIFY OFF
        ACCEPT  pEmployee_id PROMPT 'Digite o Id do Empregado: '
        DECLARE
            vFirst_name    employees.first_name%Type;
            vLast_name     employees.last_name%Type;
            vJob_id        employees.job_id%type;
            vEmployee_id   employees.employee_id%TYPE := &pEmployee_id;
            ePresident     EXCEPTION; --declarando a excecao
        BEGIN
            SELECT first_name, last_name, job_id INTO vFirst_name, vLast_name, vJob_id FROM   employees HERE  employee_id = vEmployee_id;

            IF   vJob_id = 'AD_PRES' 
            THEN
                RAISE ePresident;  -- É tipo um GO TO
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND 
            THEN
                RAISE_APPLICATION_ERROR(-20001, 'Empregado não encontrado, id = ' ||  TO_CHAR(vEmployee_id));
            WHEN ePresident 
            THEN
                UPDATE employees SET    salary = salary * 1.5 WHERE  employee_id = vEmployee_id;
                COMMIT;
            WHEN OTHERS 
            THEN
                RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
        END;
        
    --- PRAGMA EXCEPTION INIT ---
        -- Declara uma variavel exception e vincula um erro oracle sem nome a ela 
        DECLARE
            vemployee_id    employees.employee_id%TYPE := 300;
            vfirst_name     employees.first_name%TYPE := 'Robert';
            vlast_name      employees.last_name%TYPE := 'Ford';
            vjob_id         employees.job_id%TYPE := 'XX_YYYY';
            vphone_number   employees.phone_number%TYPE := '650.511.9844';
            vemail          employees.email%TYPE := 'RFORD';
            efk_inexistente EXCEPTION; -- declarando a variavel
            PRAGMA EXCEPTION_INIT(efk_inexistente, -2291); -- vinculando ela a excecao(-2291 é erro de inserir uma FK sem PK)
        BEGIN
            INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date,job_id)
                VALUES (vemployee_id, vfirst_name, vlast_name, vphone_number, vemail, sysdate, vjob_id);
        EXCEPTION
            WHEN  efk_inexistente 
            THEN
                RAISE_APPLICATION_ERROR(-20003, 'Job inexistente!');
            WHEN OTHERS 
            THEN
                RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
            END;

        -- Forçando o Erro para descobrir qual o código de Erro a ser usado no codigo
        INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date, job_id)
        VALUES (employees_seq.nextval, 'Joseph', 'Smith', '3333333', 'JSMITH', sysdate, 'ZZZZ_XX');
        
        
        
        
        
        