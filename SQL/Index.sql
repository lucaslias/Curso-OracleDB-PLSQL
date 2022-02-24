--- Indice ---
    -- Sem o indice o oracle tem que verificar toda a tabela
    -- Serve para melhorar performance da consulta
    -- São criados automaticamente quando usado constraints de primary key ou Unique
    -- Podem ser criados manualmente
    -- Sintaxe  
        /*
            CREATE [UNIQUE][BITMAP]INDEX
            nome_indice
            ON nome_tabela(nome_coluna[nome_coluna]... );     
        */
        
    -- Remover Indice
    DROP INDEX emp_name_ix;
    DROP INDEX employees_last_name_idx;
    DROP INDEX employees_name_idx;
    
    SELECT * FROM  employees WHERE last_name = 'Himuro'; --0,003/0,002 segundos
    
    -- Criar indice
    CREATE INDEX employees_last_name_idx
        ON employees(last_name);
        
    SELECT * FROM  employees WHERE last_name = 'Himuro'; --0,002/0,001 segundos
    
    -- Indice mais de uma coluna
    CREATE INDEX employees_name_idx
        ON employees(last_name, first_name);
    
    -- Alterar/reconstruir Indice
    ALTER INDEX employees_name_idx REBUILD;
    
    -- Consular indice
    SELECT ix.index_name,ic.column_position,ic.column_name, ix.index_type,ix.uniqueness, ix.status
    FROM  user_indexes ix JOIN user_ind_columns ic 
    ON (ix.index_name = ic.index_name) AND (ix.table_name = ic.table_name)
    WHERE ix.table_name = 'EMPLOYEES'
    ORDER BY ix.index_name, ic.column_position; 
    
    
    

    
