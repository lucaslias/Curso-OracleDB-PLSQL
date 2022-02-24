-- Gerenciar Procedures e Funcoes ---

    DESC USER_OBJECTS

    -- Visualiza Procedure e Funcoes Criadas
    SELECT object_name, object_type, last_ddl_time, timestamp, status
    FROM   user_objects
    WHERE  object_type IN ('PROCEDURE', 'FUNCTION');

    -- Consultando o Código Fonte de Procedures e Funções  do seu usuário
    SELECT line, text
    FROM   user_source
    WHERE  name = 'PRC_INSERE_EMPREGADO' AND type = 'PROCEDURE'
    ORDER BY line;

    SELECT line, text
    FROM   user_source
    WHERE  name = 'FNC_CONSULTA_SALARIO_EMPREGADO' AND type = 'FUNCTION'
    ORDER BY line;


