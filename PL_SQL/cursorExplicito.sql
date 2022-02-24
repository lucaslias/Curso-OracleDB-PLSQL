--- Cursor Explicito ---
    -- Para consultas que retornam mais de um linha, podem ser manipulado pelo programados (controle total)
    -- Comandando uma linha por vez
    -- DECLARE(criar e vincular) -> OPEN (oracle seleciona todas as linha 'result set) -> FETCH (pega a linha corrente) -> LOOP  se for vazio fecha(CLOSE), 
        -- se não for volta pro FETCH
    -- Atributos do cursor: %ISOPEN(retorna true se estiver aberto), %NOTFOUND(retorna true se o ultimo fetch não encontrou linha), 
        -- %FOUND(retorna true se o ultimo fetch encontrou linha), %ROWCOUNT(retorna o numero de linhas)
       
    -- Com LOOP simples 
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        CURSOR  employees_cursor IS SELECT  * FROM  employees;  -- Declaração do Cursor
        employees_record  employees_cursor%rowtype; -- Carregando o cursor
    BEGIN
        /* Inicializa */
        OPEN  employees_cursor;  -- Abrindo o Cursor
  
        LOOP  -- Loop Básico
        FETCH  employees_cursor  
        INTO  employees_record; -- Fetch do Cursor
    
        EXIT WHEN employees_cursor%notfound;
            DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                                 employees_record.first_name || ' ' || 
                                 employees_record.last_name || ' - ' ||
                                 employees_record.department_id || ' - ' ||
                                 employees_record.job_id || ' - ' ||
                                 employees_record.phone_number || ' - ' ||
                                 LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
    
        END LOOP;
        CLOSE employees_cursor; -- Close do Cursor
    END;
    
    -- Com WHILE LOOP
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        CURSOR  employees_cursor  IS SELECT  * FROM    employees; -- Declaração do Cursor
        employees_record  employees_cursor%rowtype; 
    BEGIN
        OPEN  employees_cursor; -- Abrindo o Cursor
  
        FETCH  employees_cursor  
        INTO  employees_record; -- Fetch do Cursor pega primeira linha
  
        WHILE  employees_cursor%found  LOOP
            DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                         employees_record.first_name || ' ' || 
                         employees_record.last_name || ' - ' ||
                         employees_record.department_id || ' - ' ||
                         employees_record.job_id || ' - ' ||
                         employees_record.phone_number || ' - ' ||
                         LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
                         
            FETCH  employees_cursor  -- pega a proxima linha
            INTO  employees_record;
        END LOOP;
    CLOSE employees_cursor; -- Close do Cursor
    END;
    
    -- Com FOR LOOP (***** mais simples *****) -> não precisa do fetch, nem o open, nem o close (está tudo implicito)
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        CURSOR  employees_cursor  IS SELECT  * FROM    employees;
    BEGIN
        FOR employees_record IN  employees_cursor LOOP
            DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                                 employees_record.first_name || ' ' || 
                                 employees_record.last_name || ' - ' ||
                                 employees_record.department_id || ' - ' ||
                                 employees_record.job_id || ' - ' ||
                                 employees_record.phone_number || ' - ' ||
                                 LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
         END LOOP;
    END;
    
    -- CURSOR FOR LOOP (declarando no for loop)
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    BEGIN
        FOR employees_record IN  (SELECT  * FROM    employees) LOOP -- Declara o cursor direto no for
            DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                                 employees_record.first_name || ' ' || 
                                 employees_record.last_name || ' - ' ||
                                 employees_record.department_id || ' - ' ||
                                 employees_record.job_id || ' - ' ||
                                 employees_record.phone_number || ' - ' ||
                                 LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));

        END LOOP;
    END;
    
    -- CURSOR COM PARAMETROS   
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        CURSOR  employees_cursor (pdepartment_id NUMBER, pjob_id VARCHAR2)
            IS SELECT  * FROM employees  WHERE   department_id = pdepartment_id  AND job_id = pjob_id;
    BEGIN
        FOR employees_record IN  employees_cursor (60, 'IT_PROG') LOOP
             DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                                 employees_record.first_name || ' ' || 
                                 employees_record.last_name || ' - ' ||
                                 employees_record.department_id || ' - ' ||
                                 employees_record.job_id || ' - ' ||
                                 employees_record.phone_number || ' - ' ||
                                 LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
    
        END LOOP;
    END;
    
    -- Cursor Explícito com SELECT FOR UPDATE(se alguem tentar fazer update nas linhas lock ficará em espera)
        -- Faz sentido se você quer bloquear as linhas para ninguem mexer enquanto isso 
        -- *** Muito raro *** 
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        CURSOR  employees_cursor (pjob_id VARCHAR2)
            IS SELECT  * FROM employees WHERE job_id = pjob_id
            FOR UPDATE;
    BEGIN
        FOR employees_record IN  employees_cursor ('AD_VP') LOOP
            UPDATE employees SET salary = salary * (1 + 10 / 100) WHERE CURRENT OF employees_cursor;
        END LOOP;
        COMMIT;
    END;

    
    

        
    