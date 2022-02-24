--- Definindo Identificadores ---
    -- Não pode "_", "-", palavras reservadas, a não ser que o nome seja entre aspas duplas(mas não é uma boa pratica)
    -- Dentro do campo DECLARE, pode ou não iniciar o valor
    -- Sintaxe: nomeVariavel tipoVariavel := valor;
        -- Literal String -> 'Ola mundo'
        -- Literal Date -> '28/01/2020' (depende do formado definido no banco)
        -- Literal Numerico -> vValor := 5000;
        --                     vValor2 := 21E9; (elevado a 9)
        --                     vDouble := 2.0d; (do tipo double)
        --                     vDouble := 2.0f; (do tipo float)
        -- Literal Boleando -> vBole := TRUE ou FALSE ou Null;
        
    -- Se colocar o NOT NULL é obrigatorio iniciar
        
    SET SERVEROUTPUT ON
    DECLARE
        vNumero    NUMBER(11,2) := 1200.50;
        vCaracterTamVariavel VARCHAR2(100) := 'Porto Alegre, RS';
        vData2     DATE := '29/04/20';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Numero = ' ||   vNumero);
        DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Variável = ' || vCaracterTamVariavel );
        DBMS_OUTPUT.PUT_LINE('Data2 = ' || vData2 );
    END;
    
    
    
--- Definindo Constantes ---
    -- Valores não podem ser alerados, nem no begin
    --Sintaxe: nomeIdentificador [CONST]  tipoDado [NOT NULL] [:= | DEFAULT expressao];
    -- Se colocar o NOT NULL é obrigatorio iniciar
    
    SET SERVEROUTPUT ON
    DECLARE
        vPi CONSTANT NUMBER(38,15) := 3.141592653589793;
        vCaracterTamVariavel CONSTANT VARCHAR2(100) := 'Porto Alegre, RS';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Pi = ' ||   vPi);
        DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Variável = ' || vCaracterTamVariavel );
    END;
    
--- DATATYPES ----
    -- Se colocar o NOT NULL é obrigatorio iniciar
    -- Escalar ->  um unico valor (caracter, numero, boolean, datas)
        -- NUMBER(p,s) = p é a quantidade de numeros e s a quantidade de casas
        -- Char alfa de tamanho fixo (maximo 32767 bytes)
        -- Varchar2 alfa de tamanho variado (maximo 32767 bytes)
        -- Boolean (true, false, null)
        -- LONG e LONG RAW (armazenam binarios de amanho até 32767)
            -- *** Curiosidade *** vVar LONG RAW := HEXTORAW('43'||'41'||'52'); está função converte em binario ***
        -- ROWID endereço logico de uma linha de tabela (char de tamanho maximo 18)
        -- DATE 
        -- TIMESAMP (date com mais casas nos segundos)
            --vData1 TIMESTAMP := SYSTIMESTAMP;
            --vData1 TIMESTAMP(3) := SYSTIMESTAMP; somente 3 casas após
            --vData1 TIMESTAMP WITH TIME ZONE:= SYSTIMESTAMP; armazena o utc de onde está o banco tambpem
        -- NCHAR e NVARCHAR2 -> suporta qualquer lingua do mundo 
        -- BINARY_INTEGER (inteiros, mais rapido que number)
        -- BINARY_DOUBLE, BINARY_FLOAT(alternativa ao Number), armazena comonoatação é tem uma quantidade de representação após a virgula maior
    
    -- Regra de Nomenclatura
        -- Variaveis com mesmo nome somente em blocos diferentes
        -- Não usar o nome de colunas da tabela
        
    -- Declarando variaveis de acordo com a linha da tabela
        -- %TYPE
        -- EX: vFirstName employees.first_name%TYPE; -> Vai ser do mesmo tipo e tamanho da tabela

    SET SERVEROUTPUT ON
    DECLARE
        vNumero              NUMBER(11,2) := 1200.50;
        vCaracterTamFixo     CHAR(100) := 'Texto de Tamanho Fixo de até 32767 bytes';
        vCaracterTamVariavel VARCHAR2(100) := 'Texto Tamanho variável de até 32767 bytes';
        vBooleano            BOOLEAN := TRUE;
        vData                DATE := sysdate;
        vLong                LONG := 'Texto Tamanho variável de até 32760 bytes';
        vRowid               ROWID;
        vTimestamp           TIMESTAMP := systimestamp;
        vTimestamptz         TIMESTAMP WITH TIME ZONE := systimestamp;
        vCaracterTamFixoUniversal     NCHAR(100) := 'Texto de Tamanho Fixo Universal de até 32767 bytes';
        vCaracterTamVariavelUniversal NVARCHAR2(100) := 'Texto Tamanho variável Universal de até 32767 bytes';
        vNumeroInteiro       BINARY_INTEGER := 1200;
        vNumeroFloat         BINARY_FLOAT := 15000000;
        vNumeroDouble        BINARY_DOUBLE := 15000000;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Numero = ' ||   vNumero);
        DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Fixo = ' || vCaracterTamFixo );
        DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Variável = ' || vCaracterTamVariavel );
        IF  vBooleano = TRUE
        THEN 
            DBMS_OUTPUT.PUT_LINE('Booleano = ' || 'TRUE');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Booleano = ' || 'FALSE OR NULL');
        END IF;
      DBMS_OUTPUT.PUT_LINE('Data = ' || vData);
      DBMS_OUTPUT.PUT_LINE('Long = ' || vLong );
      SELECT rowid INTO vRowid FROM employees WHERE  first_name = 'Steven' AND last_name = 'King';
      DBMS_OUTPUT.PUT_LINE('Rowid = ' || vRowid );
      DBMS_OUTPUT.PUT_LINE('Timestamp = ' || vTimestamp);
      DBMS_OUTPUT.PUT_LINE('Timestamp with time zone= ' || vTimestamptz);
      DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Fixo = ' || vCaracterTamFixoUniversal );
      DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Variável = ' || vCaracterTamVariavelUniversal );
      DBMS_OUTPUT.PUT_LINE('Numero Inteiro = ' || vNumeroInteiro);
      DBMS_OUTPUT.PUT_LINE('Numero Float = ' || vNumeroFloat);
      DBMS_OUTPUT.PUT_LINE('Numero Double = ' || vNumeroDouble);
    END;
    
--- Variavel Bind ---
    -- Declara externo dos blocos   
    SET SERVEROUTPUT ON
        VARIABLE gmedia NUMBER
    DECLARE
        vnumero1  NUMBER(11,2) := 2000;
        vnumero2  NUMBER(11,2) := 5000;
    BEGIN  
        :gmedia := (vnumero1 + vnumero2) / 2;
        DBMS_OUTPUT.PUT_LINE('Media = ' || TO_CHAR(:gmedia));
    EXCEPTION
        WHEN OTHERS 
    THEN 
        DBMS_OUTPUT.PUT_LINE('Erro Oracle: ' || SQLCODE || SQLERRM);
    END;
























    