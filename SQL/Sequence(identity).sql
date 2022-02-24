-- Sequence --
    -- Utilizado para gerar numeros sequenciais
    -- Muito utilizado para numeros das chaves primarias
    -- Não está ligado a tabela(recomendado criar uma pra cada)
        -- NEXTVAL: proximo valor da sequence
        -- CURRVAL: valor corrente da sequence
        -- Na sessão precisa ser realizado uma referencia a NEXTVAL antes de referenciar CURRVAL
    -- Tentar evitar buracos 
    -- Se usar cache e o banco cair quando voltar irá pegar novos numeros para o cache deixando espaços dos numeros anteriores em cache
        
    -- Sintaxe: 
        /*
            CREATE SEQUENCE nome_sequence
            [START WITH n] -> onde começa
            [{MAX VALUE n | NOMAXVLAUE] -> até onde pode ir ou se não tem valor maximo
            [{MIN VALUE n | NOMINVLAUE] -> até onde pode ir ou se não tem valor minimo (para decremento negativo)
            [{CYCLE | NOCYCLE}] -> quando atingir o maximo volta pro inicio ou da erro
            [{CACHE n | NOCACHE}] -> coloca os numeros em cache, quando pedir usa o numero que já está em cache
            
        */
    
    -- Remover Sequence
    DROP SEQUENCE employees_seq;
    
    -- Criando a sequence (neste caso está comecando do 207 pq já tinha regsitro na tabela)
    CREATE SEQUENCE employees_seq
        START WITH 207
        INCREMENT BY 1
        NOMAXVALUE 
        NOCACHE
        NOCYCLE;
    
    -- Alterar Sequence (unico que não pode alterar é o start with, para alterar precisa ser o dono ou ter permissão)
    ALTER SEQUENCE employees_seq
        CACHE 20;
    
    -- Consultar sequences criadas
    SELECT  * FROM user_sequences;
    
    -- Exemplo pegar numeros
    SELECT employees_seq.NEXTVAL FROM   dual;
    SELECT employees_seq.CURRVAL FROM   dual;
    
    -- Utilizando a Sequence
    INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES (employees_seq.nextval, 'Paul', 'Simon', 'PSIMO', '525.342.237', TO_DATE('12/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 15000, NULL, 103, 60);
    COMMIT;
    -- Se dar rollback o numero da sequence não volta

    
    
    
    
    
    
    
    
    