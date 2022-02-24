--- Sinonimos ---
    -- É um objeto do oracle que server para dar nome a outro objeto
    -- Usado para: referenciar uma tabela que é propriedade de outro objeto, criar um nome reduzido, criar outro nome logico para um objeto
    -- Sintaxe sinonimo privado: (normalmente dev cria apenas privado, o dba tem que dar permissao para criar publico)
        /* 
        CREATE SYNONYM nome_sinonimo
        FOR tabela
        */
        
    -- Sintaxe sinonimo publico: (
        /* 
        CREATE PUBLIC SYNONYM nome_sinonimo
        FOR tabela
        */
        
    -- Criando Sinonimo Privado
    CREATE SYNONYM departamentos
        FOR departments;
        
    -- Criando Sinonimo Publico
    CREATE PUBLIC SYNONYM departamentosPU
        FOR departments;
        
    select * from departments;
    select * from departamentos; --agora pode usar os dois porque eles são sinonimos
    select * from departamentosPU; --agora pode usar os dois porque eles são sinonimos
    
    -- Remover sinonimos
    DROP SYNONYM departamentos;