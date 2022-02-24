-- Alterando a Estrutura da tabela --
    -- ALTER TABLE (add nova coluna, modificar coluna, definir valor default, remover coluna, renomar coluna, alterar o estado)
    
    -- Adicionar Coluna
    ALTER TABLE projects ADD (department_id NUMBER(3)); 
    
    -- Remover Coluna
    ALTER TABLE projects DROP COLUMN department_id; 
    
    -- Modificar coluna 
    ALTER TABLE projects MODIFY (project_code VARCHAR2(6));
    
    -- Renomear Coluna
    ALTER TABLE projects RENAME COLUMN project_name TO name;

    -- Não irá permitir comando ddl ou dml     
    ALTER TABLE employees READ ONLY;
    
    -- Irá permitir comando ddl ou dml   
    ALTER TABLE employees READ WRITE;

    
    
    
