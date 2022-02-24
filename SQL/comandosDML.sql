-- Comando DML(Insert, Delete, Update)--
    -- *** Para efetivar precisa do commit ***

    -- Insert
        INSERT INTO departments(department_id, department_name, manager_id, location_id) VALUES (280, 'Project Management', 103, 1400);
        INSERT INTO departments VALUES (290, 'Data Science', NULL, NULL); --Pode não colocar as colunas, só passar na ordem
        
        --Pode usar funções para inserir   
        INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
            VALUES (208, 'Vito', 'Corleone', 'VCORL',  '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 20000,NULL, 103, 60);
            
        --Variaveis de substiuição(pede para o usuario digitar os valores)
        INSERT INTO departments (department_id, department_name, location_id) VALUES (&department_id, '&department_name',&location);
        
        -- Inserir linhas a partir de subConsulta
        INSERT INTO sales_reps(id, name, salary, commission_pct)
            SELECT employee_id, last_name, salary, commission_pct FROM employees WHERE job_id = 'SA_REP';
            
    -- Update
        UPDATE employees SET salary = salary * 1.2;
        ROLLBACK;

        UPDATE employees SET salary = salary * 1.2 WHERE last_name = 'King';
        COMMIT;
        
        -- Atualizando com subConsulta
        UPDATE employees SET job_id = (SELECT job_id FROM employees WHERE employee_id = 141), salary = (SELECT salary FROM employees WHERE employee_id = 141)WHERE employee_id = 140;
        COMMIT;
    
    -- Delete
        DELETE FROM employees WHERE employee_id = 208;
        COMMIT;
    
-- Transações de banco de dados (somente o usuario pode ver, outras sessoes não podem utilizar)--
    -- Começa quando utiliza um comando dml
    -- Termina com o commit ou Rollback OU com comando DDL
    -- Se o comando falha já faz um rollback
    -- É possivel criar "savepoint"
    
    --SAVEPOINT
    INSERT INTO employees (employee_id, first_name, last_name, email,  phone_number, hire_date, job_id, salary,commission_pct, manager_id, department_id)
    VALUES (207, 'Rock', 'Balboa', 'DROCK',  '525.342.237', SYSDATE, 'IT_PROG', 7000, NULL, 103, 60);

    SAVEPOINT A;

    INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id, department_id)
    VALUES (208, 'Vito', 'Corleone', 'VCORL', '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 20000,NULL, 103, 60);
               
    ROLlBACK TO SAVEPOINT  A;
    COMMIT; -- Não inseriu o primeiro mas inseriu o segundo

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
