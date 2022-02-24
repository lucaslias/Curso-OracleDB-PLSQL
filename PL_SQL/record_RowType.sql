--- Variavel tipo RECORD ---
    -- é uma estrutura de campos em memoria, "grupo de itens/colunas"
        --ex: endereço(rua, numero, bairro, ...)
    -- Deve ser manipulado como uma unidade
    -- Sintaxe:
        /* DECLARE
            TYPE nome_record_type IS RECORD
                (campo1, campo2, ...);
            nome_record nome_record_type;
        */
                
        SET SERVEROUTPUT ON
        SET VERIFY OFF --não imprime o bloco na saida
        ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
        DECLARE
            TYPE  employee_record_type IS RECORD 
                  (employee_id   employees.employee_id%type,
                   first_name    employees.first_name%type,
                   last_name     employees.last_name%type,
                   email         employees.email%type,
                   phone_number  employees.phone_number%type);
                   
            employee_record  employee_record_type; --employee_record tem agora todos os campo
        
        BEGIN
            SELECT  employee_id, first_name, last_name, email, phone_number
            INTO    employee_record
            FROM    employees
            WHERE   employee_id = &pemployee_id;
            
            DBMS_OUTPUT.PUT_LINE(employee_record.employee_id || ' - ' || 
                             employee_record.first_name || ' - ' || 
                             employee_record.last_name || ' - ' || 
                             employee_record.phone_number);
        END;
        
        
--- atributo %ROWTYPE ---
    -- Forma mais facil de definir a varivael record
    
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
    DECLARE
        employee_record   employees%rowtype; --herda tudo da tabela (nomes e tipos)
        vEmployee_id      employees.employee_id%type := &pemployee_id;
    BEGIN
        SELECT  * 
        INTO    employee_record
        FROM    employees
        WHERE   employee_id = vEmployee_id;
        
        DBMS_OUTPUT.PUT_LINE(employee_record.employee_id || ' - ' || 
                     employee_record.first_name || ' - ' || 
                     employee_record.last_name || ' - ' || 
                     employee_record.phone_number || ' - ' ||
                     employee_record.job_id);
    END;
    
    
    
    
    
    
    
    
    
    

    
