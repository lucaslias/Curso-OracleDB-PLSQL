    --- Cursor Implicito ---
        --Sempre que executa uma consulta o oracle abre faz e fecha
        -- Unica coisa que pode fazer é utilizar os atributos
            -- SQL%ROWCOUNT (numero de linhas afetadas)
            -- SQL%FOUND (retorna true se afetou alguma linha)
            -- SQL%NOTFOUND (retorna true se não afetou nenhuma linha)
            -- SQL%ISOPEN (sempre retorna false)
        SET SERVEROUTPUT ON
        DECLARE
            vdepartment_id  employees.department_id%type := 60;
            vpercentual     NUMBER(3) := 10;
        BEGIN
            UPDATE employees 
            SET salary = salary * (1 + vpercentual / 100)
            WHERE department_id =  vdepartment_id;
            DBMS_OUTPUT.PUT_LINE('Numero de empregados atualizados: ' || SQL%ROWCOUNT);
            -- COMMIT;  
        END;

        ROLLBACK;