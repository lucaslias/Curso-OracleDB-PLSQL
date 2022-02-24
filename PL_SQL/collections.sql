--- Collections ---
    -- Estrutura para gerencamento de multiplas linhas (Array)

    --- ASSOCIATIVE ARRAY ---
        -- Array unidimensional
        -- indexado por valores numericos ou caractere 
        -- é um vetor não sendo armazenado no banco de dados
        -- SINTAXE:
            /*
                DECLARE
                TYPE nome_array
                IS TABLE OF nome_tabela.nome_coluna%type
                INDEX BY BINARY_INTEGER
                
                nome_variavel_table nome_array
            */
            
        SET SERVEROUTPUT ON
        SET VERIFY OFF
        DECLARE
            TYPE Numero_Table_Type IS TABLE OF NUMBER(2) 
            INDEX BY BINARY_INTEGER;
            Numero_table  Numero_Table_Type;
        BEGIN
            FOR i IN 1..10  LOOP
                Numero_Table(i) := i;
            END LOOP;

            FOR i IN 1..10 LOOP
                DBMS_OUTPUT.PUT_LINE('Associative Array: Indice = ' || TO_CHAR(i) || ', Valor = ' || TO_CHAR(Numero_Table(I)));
            END LOOP;
        END;
        
        

    --- ASSOCIATIVE ARRAY de Record ---
        -- É quando cada ocorrencia do array terá o tipo record (é tipo uma instancia do objeto)
        -- Para colocar o valor é nome_variavel_array(indice).nome_campo := valor;
        SET SERVEROUTPUT ON
        SET VERIFY OFF
        DECLARE
            TYPE employees_table_type IS TABLE OF employees%rowtype
            INDEX BY BINARY_INTEGER;  -- Para Associative Array é obrigatorio
            employees_table  employees_table_type;
        BEGIN
            SELECT * BULK COLLECT INTO employees_table FROM employees; --bulk collect é para carregar todas as variaveis do array
            
            FOR i IN employees_table.first..employees_table.last LOOP   --first é para o primeiro elemento até o ultimo
                DBMS_OUTPUT.PUT_LINE(employees_table(i).employee_id || ' - ' || 
                                     employees_table(i).first_name || ' - ' || 
                                     employees_table(i).last_name || ' - ' ||
                                     employees_table(i).phone_number || ' - ' ||
                                     employees_table(i).job_id || ' - ' ||
                                     TO_CHAR(employees_table(i).salary,'99G999G999D99'));   
            END LOOP;
        END;
        
    --- Nested Table ---
        -- Uma alternativa ao Associaive array(não escreve o INDEX BY)
        -- Pode ser armazenado em tabela e acessar por comando SQL (porém não deve ser feito por causa das regras de forma normal)
        -- Indice tem que ser positivo e inicializado
        
        SET SERVEROUTPUT ON
        SET VERIFY OFF
        DECLARE
            TYPE Numero_Table_Type IS TABLE OF INTEGER(2);
            Numero_table numero_table_type := numero_table_type();
        BEGIN
            FOR i IN 1..10 LOOP
                Numero_Table.extend; --Para alocar a ocorrencia
                Numero_Table(i) := i;
            END LOOP;
    
            FOR I IN 1..10 LOOP
                DBMS_OUTPUT.PUT_LINE('Nested Table: Indice = ' || TO_CHAR(i) || ', Valor = ' || TO_CHAR(Numero_Table(i)));
            END LOOP;
        END;
        
     --- Nested Table de Record  ---
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        TYPE employees_table_type IS TABLE OF employees%rowtype;
        employees_table  employees_table_type := employees_table_type();
    BEGIN
        SELECT * BULK COLLECT INTO employees_table FROM employees;
        
        FOR i IN employees_table.first..employees_table.last  LOOP
            DBMS_OUTPUT.PUT_LINE(employees_table(i).employee_id || ' - ' || 
                                 employees_table(i).first_name || ' - ' || 
                                 employees_table(i).last_name || ' - ' ||
                                 employees_table(i).phone_number || ' - ' ||
                                 employees_table(i).job_id || ' - ' ||
                                 TO_CHAR(employees_table(i).salary,'99G999G999D99'));   
        END LOOP;
    END;
    
    --- VARRAY ---
        -- Semelhante ao NESTED TABLE
        -- Precisa ser inicializado, somente indices positivos e tem que definir o tamanho
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        TYPE Numero_Table_Type IS VARRAY (10) OF INTEGER(2);
        Numero_table numero_table_type := numero_table_type();
    BEGIN
        FOR i IN 1..10 LOOP
            Numero_Table.extend;
            Numero_Table(i) := i;
            DBMS_OUTPUT.PUT_LINE('Varray: Indice = ' || TO_CHAR(i) || ', Valor = ' || TO_CHAR(Numero_Table(i)));
        END LOOP;
    END;
    
    --- VARRAY com RECORDS ---
    SET SERVEROUTPUT ON
    SET VERIFY OFF
    DECLARE
        TYPE employees_table_type IS VARRAY (200) OF employees%rowtype;
        employees_table  employees_table_type := employees_table_type();
    BEGIN
        SELECT * BULK COLLECT INTO employees_table  FROM employees;
        
        FOR i IN employees_table.first..employees_table.last  LOOP
            DBMS_OUTPUT.PUT_LINE(employees_table(i).employee_id || ' - ' || 
                                 employees_table(i).first_name || ' - ' || 
                                 employees_table(i).last_name || ' - ' ||
                                 employees_table(i).phone_number || ' - ' ||
                                 employees_table(i).job_id || ' - ' ||
                                 TO_CHAR(employees_table(i).salary,'99G999G999D99'));   
        END LOOP;
    END;
    
    -- Metodos para controlar collections
        -- nome_collection.nome_metodos
        -- principais metodos: EXISTS(retorna true se existe), COUNT(numero de elementos), FIRST, LAST,
        --   LIMIT(retorna o maior possivel, somente para varray), PRIOR(n) (retorna o numero do indice anterior a n) 
        --   NEXT(n) (retorna o numero posterior a n), EXTEND(aloca ocorrencia para array, nested e varray)
        --   TRIM (remove o elemento do final, somente para nested), TRIM(n) (remove n elementos do final, somente para nested)
        --   DELETE (remove todos, somente para associative ou nested),  DELETE(n) (remove o elemento n, somente para associative ou nested), 
        --   DELETE(m,n) (remove os elementos na faixa de m à n, somente para associative ou nested), 

    
    
    
    
    
    
    
    
    
            