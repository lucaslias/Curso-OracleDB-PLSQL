--- Diretrizes de um Bloco PL/SQL ---
    -- Identificadores ou literais separados por um ou mais espaço 
    -- Palavras chaves não pode dividir em linhas
    -- Comentario com "--"
    
-- Funções no bloco PL/SQL 
    -- Funcoes numericas, caractere, conversao, data, foncoes genericas (as mesmas do sql)
        -- EX: TO_NUMEBER, TO_DATE, ...
    -- *** Não pode usar em comando PL-SQL -> DECODE, funcoes de grupo(AVG, MIN, MAX, COUNT, SUM, STDDEV, VARIANCE)
    
    SET SERVEROUTPUT ON
    DECLARE
        vNumero1  NUMBER(13,2);  -- Declaração de variável para o Primeiro número
        vNumero2  NUMBER(13,2);  -- Declaração de variável para o Segundo número
        vMedia    NUMBER(13,2);  -- Declaração de variável para a Média
    BEGIN	 
        vNumero1  :=  5000.8888;
        vNumero2  :=  3000.4444;
        vMedia    :=  ROUND((vNumero1 + vNumero2) / 2, 2);
        DBMS_OUTPUT.PUT_LINE('vnumero1 = ' || vnumero1);  -- Impressão do Primeiro Número
        DBMS_OUTPUT.PUT_LINE('vnumero2 = ' || vnumero2);  -- Impressão do Segundo Número
        DBMS_OUTPUT.PUT_LINE('Media = ' || TO_CHAR(vMedia,'99G999G999D99'));     -- Impressão da Média calculada 
    END;

-- Blocos Aninhados
    -- A variavel é disponivel no bloco que foi declarado e nos blocos filhos. Bloco filho não tem acesso as variaveis do bloco pai. Bloco "irmão" também não tem acesso
    
    SET SERVEROUTPUT ON
    DECLARE
        vbloco1 VARCHAR2(20) := 'Bloco 1';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 1: ' || vbloco1);
        -- *** Outro Bloco ***
        DECLARE
            vbloco2 VARCHAR2(20) := 'Bloco 2';
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 1: ' || vbloco1);
            DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 2: ' || vbloco2);
        END;
        DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 1: ' || vbloco1);
    END;
    
--- Identificando Blocos através de Labels ---
    -- Maneira de identificar os blocos 
    
    SET SERVEROUTPUT ON
    <<BLOCO1>>
    DECLARE
        vbloco1 VARCHAR2(20) := 'Bloco 1';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 1: ' || bloco1.vbloco1);
        <<BLOCO2>>
        DECLARE
            vbloco2 VARCHAR2(20) := 'Bloco 2';
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 1: ' || bloco1.vbloco1);
            DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 2: ' || bloco2.vbloco2);
        END;
        DBMS_OUTPUT.PUT_LINE('Referenciando variável do Bloco 1: ' || bloco1.vbloco1);
    END;
    
    




