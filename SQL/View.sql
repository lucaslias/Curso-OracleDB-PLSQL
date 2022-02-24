-- Views ---
    -- � um select armazenado no dicionario do oracle
    -- Vanatgens: restringir acesso aos dados, tornar simples consultas complexas
    -- Vis�es simples: uma unica tabela, sem fun��es, sem group by
    -- Vis�es complexa: varias unica tabela, com fun��es com group by (a divis�o � mais teorica, a cria��o � a mesma coisa)
    
    --Criar ou alterar
        CREATE OR REPLACE VIEW vemployeesdept60
        AS 
            SELECT employee_id, first_name, last_name, department_id, salary, commission_pct
            FROM employees
            WHERE department_id = 60;
        
    -- Consultar
        SELECT * FROM vemployeesdept60;
        
    -- N�o pode fazer delete,update ou insert utilizando view se ela for do tipo complexa
    
    -- Se tentar inserir usa o where como cluasula de vlaida��o para permitir ou n�o
    CREATE OR REPLACE VIEW vemployeesdept100
    AS 
        SELECT employee_id, first_name, last_name, department_id, salary
        FROM employees
        WHERE department_id = 100
        WITH CHECK OPTION CONSTRAINT vemployeesdept100_ck;
     
    -- Permite apenas consula   
    CREATE OR REPLACE VIEW vemployeesdept20
    AS 
        SELECT employee_id, first_name, last_name, department_id, salary
        FROM employees
        WHERE department_id = 20
        WITH READ ONLY;
        
    --Remover a View
    DROP VIEW vemployeesdept20;
