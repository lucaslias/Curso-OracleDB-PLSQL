--- Comando SQL no PL/SQL ---
    -- Não pode executar direto comandos DDL ou DCL no bloco PL/SQL (somente com sql dinamico)
    
    --- Select ---
        -- Sintaxe: SELECT colunas INTO variaveis FROM tabelas
        -- Deve retornar apenas uma linha, caso contrario gera a exceção "TOO_MANY_ROWS". Se não retornar nada gera a excecao "NO_DATA_FOUND"
        
        SET SERVEROUTPUT ON
        DECLARE
            vFirst_name  employees.first_name%type;
            vLast_name   employees.last_name%type;
            vSalary      employees.salary%type;
            vEmployee_id employees.employee_id%type := 121;
        BEGIN
            SELECT first_name, last_name, salary 
            INTO   vfirst_name, vlast_name, vsalary
            FROM   employees
            WHERE  employee_id = vEmployee_id;
            DBMS_OUTPUT.PUT_LINE('Employee Id: ' || vEmployee_id);
            DBMS_OUTPUT.PUT_LINE('Fist Name: ' || vFirst_name);
            DBMS_OUTPUT.PUT_LINE('Last Name: ' || vLast_name);
            DBMS_OUTPUT.PUT_LINE('Salary: ' || vSalary);
        END;
        
    --- INSERT --- (É a mesma coisa)
    SET SERVEROUTPUT ON
    DECLARE
        vfirst_name  employees.first_name%type;
        vlast_name   employees.last_name%type;
        vsalary      employees.salary%type;
    BEGIN
        INSERT INTO employees  (employee_id, first_name, last_name, email, phone_number, hire_date,  job_id, salary, commission_pct, manager_id, department_id)
            VALUES (employees_seq.nextval, 'Kobe', 'Bryant', 'KBRYANT', '515.123.45568', SYSDATE, 'IT_PROG', 15000, 0.4, 103, 60);
        COMMIT;  
    END;
        
    --- UPDATE --- (mesma coisa)
    SET SERVEROUTPUT ON
    DECLARE
       vEmployee_id    employees.employee_id%type := 150;
       vPercentual     NUMBER(3) := 10;
    BEGIN
       UPDATE employees  SET    salary = salary * (1 + vPercentual / 100) WHERE  employee_id =  vEmployee_id;
       COMMIT;  
    END;
    
    --- DELETE --- (mesma coisa)
    SET SERVEROUTPUT ON
    DECLARE
       vEmployee_id  employees.employee_id%type := 207;
    BEGIN
       DELETE FROM employees WHERE  employee_id =  vEmployee_id;
       COMMIT;  
    END;
    
    --- Controlando transações --- (igual ao do sql)
        -- uma transação é um conjunto de comandos DML (ou DDL, DCL)
        -- DML se inicia com o comando e precisa do COMMIT(insere permante) ou ROLLBACK(desfaz)
            -- Pode criar savepoint (e dar rollback nele)

    
    
    
    
    
    
    
    
    
    
    
    