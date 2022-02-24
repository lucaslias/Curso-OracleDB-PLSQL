--- Package ---
    -- É um pacote composto de uma area de especificação e um corpo que são armazenados separados do banco
    -- A package especification é a interface que declara o que está disponivel para uso publico, o corpo implementa a especificação
        -- Se for privado só pode ser usado dentro do package
    -- Pode ter dentro varias procedures,funções, variaveis, cursores, excecao, constante
    -- Beneficios: Organização e desempenho  
            
    -- Vantagens
        -- Oraganização
        -- pode criar variaveis globais
        -- Ganho de performance, pois deixa em memoria
        -- Gerenciamento de procedures é mais facil
        -- Gerenciamento de segurança é melhor
    
    --- Criando o Package(se declara é porque é publica---
    Create or replace PACKAGE PCK_EMPREGADOS
    IS
        gMinSalary     employees.salary%TYPE; -- Tipo uma variavel global
        
        PROCEDURE PRC_INSERE_EMPREGADO (pfirst_name    IN VARCHAR2,
            plast_name     IN VARCHAR2,
            pemail         IN VARCHAR2,
            pphone_number  IN VARCHAR2,
            phire_date     IN DATE DEFAULT SYSDATE,
            pjob_id        IN VARCHAR2,
            pSALARY        IN NUMBER,
            pCOMMICION_PCT IN NUMBER,
            pMANAGER_ID    IN NUMBER,
            pDEPARTMENT_ID IN NUMBER);

        PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO
            (pemployee_id   IN NUMBER,
            ppercentual    IN NUMBER);

        FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO
            (pemployee_id   IN NUMBER)
            RETURN NUMBER;

    END PCK_EMPREGADOS;
    
    --- Criando o Packeage Body ---
    create or replace PACKAGE BODY PCK_EMPREGADOS -- coloca o mesmo nome
    IS
        -- Se colocar uma variavel aqui ela vai ser privada
        -- Coloca todos os corpos das procedures(publica ou privadas)
    END PCK_EMPREGADOS;
    
    --- Referenciando Componentes de uma package ---
        --Somente os pulicos podem ser referenciados em construções externas a ela
        BEGIN
            --nome_pacote.nome_procedure(parametros)
            PCK_EMPREGADOS.PRC_INSERE_EMPREGADO('Bob', 'Dylan','BDYLAN','515.258.4861',SYSDATE,'IT_PROG',20000,NULL,103,60);
            COMMIT;
        END;
        
    -- Procedimento de uma unica execucao 
        -- Bom para inicialização de variavies
        create or replace PACKAGE BODY PCK_EMPREGADOS
        IS
            -- comandos das procedures, funcoes, ..
        BEGIN -- o que está entre o begin e o end é o será executado apenas uma vez, antes de refereniar  pela primeira vez o oracle faz automaticamente
            SELECT MIN(salary)
            INTO   PCK_EMPREGADOS.gMinSalary
            FROM   employees;
        END PCK_EMPREGADOS;
        
    -- Recompilar Package
        --PCK_empregados é o nome
        ALTER PACKAGE PCK_EMPREGADOS COMPILE SPECIFICATION;
        ALTER PACKAGE PCK_EMPREGADOS COMPILE BODY;
        
    -- Remover Package
        DROP PACKAGE BODY PCK_EMPREGADOS; -- remove so o body
        DROP PACKAGE PCK_EMPREGADOS; -- remove o body e o specification

        
    
    
        

