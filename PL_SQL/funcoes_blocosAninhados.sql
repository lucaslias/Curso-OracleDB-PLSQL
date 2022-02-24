--- Diretrizes de um Bloco PL/SQL ---
    -- Identificadores ou literais separados por um ou mais espa�o 
    -- Palavras chaves n�o pode dividir em linhas
    -- Comentario com "--"
    
-- Fun��es no bloco PL/SQL 
    -- Funcoes numericas, caractere, conversao, data, foncoes genericas (as mesmas do sql)
        -- EX: TO_NUMEBER, TO_DATE, ...
    -- *** N�o pode usar em comando PL-SQL -> DECODE, funcoes de grupo(AVG, MIN, MAX, COUNT, SUM, STDDEV, VARIANCE)
    
    SET SERVEROUTPUT ON
    DECLARE
        vNumero1  NUMBER(13,2);  -- Declara��o de vari�vel para o Primeiro n�mero
        vNumero2  NUMBER(13,2);  -- Declara��o de vari�vel para o Segundo n�mero
        vMedia    NUMBER(13,2);  -- Declara��o de vari�vel para a M�dia
    BEGIN	 
        vNumero1  :=  5000.8888;
        vNumero2  :=  3000.4444;
        vMedia    :=  ROUND((vNumero1 + vNumero2) / 2, 2);
        DBMS_OUTPUT.PUT_LINE('vnumero1 = ' || vnumero1);  -- Impress�o do Primeiro N�mero
        DBMS_OUTPUT.PUT_LINE('vnumero2 = ' || vnumero2);  -- Impress�o do Segundo N�mero
        DBMS_OUTPUT.PUT_LINE('Media = ' || TO_CHAR(vMedia,'99G999G999D99'));     -- Impress�o da M�dia calculada 
    END;

-- Blocos Aninhados
    -- A variavel � disponivel no bloco que foi declarado e nos blocos filhos. Bloco filho n�o tem acesso as variaveis do bloco pai. Bloco "irm�o" tamb�m n�o tem acesso
    
    SET SERVEROUTPUT ON
    DECLARE
        vbloco1 VARCHAR2(20) := 'Bloco 1';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || vbloco1);
        -- *** Outro Bloco ***
        DECLARE
            vbloco2 VARCHAR2(20) := 'Bloco 2';
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || vbloco1);
            DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 2: ' || vbloco2);
        END;
        DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || vbloco1);
    END;
    
--- Identificando Blocos atrav�s de Labels ---
    -- Maneira de identificar os blocos 
    
    SET SERVEROUTPUT ON
    <<BLOCO1>>
    DECLARE
        vbloco1 VARCHAR2(20) := 'Bloco 1';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || bloco1.vbloco1);
        <<BLOCO2>>
        DECLARE
            vbloco2 VARCHAR2(20) := 'Bloco 2';
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || bloco1.vbloco1);
            DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 2: ' || bloco2.vbloco2);
        END;
        DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || bloco1.vbloco1);
    END;
    
    




