--- Gerenciamento de dependencias objeto ---
    -- Sempre que altera algo (tabela, coluna, ...) os obetos que dependente do objeto ficam com o status invalido
    -- Ao executar a procedure o oracle automaticamente tenta recompilar (para alterar para valid), porém não é uma boa pratica
    -- Sempre que alterar verificar onde afetou e recompilar manualmente
    
    -- Dependencia Direta
        -- Uma procedure depende diretamente do objeto
        -- Faça uma consulta(exemplo a seguir), verifique todas e recompile
    
    -- Dependencia Indireta
        -- Depende indiretamente, ex: chama uma procedure que chama o objeto
        -- Faça uma consulta(exemplo a seguir), verifique todas e recompile
        
    -- Dependencia Local
        -- Objeto referencia um objeto que está no mesmo banco
        
    -- Dependencia Remota
      -- Objeto referencia um objeto que está em outro banco
      
    -- Consultando dependencia indireta
    SELECT * FROM   user_dependencies WHERE  referenced_name = 'EMPLOYEES' AND referenced_type = 'TABLE';
      
    -- Consultando dependencia direta e indireta
    SELECT * FROM  user_dependencies 
        START WITH  referenced_name = 'EMPLOYEES' AND referenced_type = 'TABLE'
        CONNECT BY PRIOR  name = referenced_name AND type = referenced_type;
        
    -- Verifica se tem algo invalido 
    SELECT object_name, object_type, last_ddl_time, timestamp, status
    FROM   user_objects
    WHERE  status = 'INVALID';
    

--- DEPTREE e IDEPTREE ---
    -- Outra forma de gerenciar objetos
    -- Tem que executar o script "@c:\caminho\dbhomeXE\rdbms\admin\utltree.sql"
    -- Tem que rodar o script com o usuario dono do objeto para criar
    -- Quando roda faz a analise das dependencias
    -- Para executar 
        -- DEPTREE_FILL('TABLE', 'HR', 'EMPLOYEES');
        -- SELECT * FROM deptree ORDER by seq#;
        -- DEC ideptree; (identação mostra o nivel de dependencia)
  
    
        
        
        
        
        
        
        
        