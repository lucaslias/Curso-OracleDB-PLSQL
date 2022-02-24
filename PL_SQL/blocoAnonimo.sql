--- Blocos Anonimo ---
    -- Usado mais para aprender
    -- Sintaxe: (entre [] é opcional)
        /*
            [DECLARE]
                variaveis e constantes
                cursores, exececoes
            BEGIN
                comandos SQL
                comando PL/SQL
            [EXCEPTION]
                tratamento de excecao
            END;
        */
        
    --DBMS_OUTPUT.PUT_LINE = package da oracle para exibir    
    --usa SET SERVEROUTPUT ON por causa do DBMS_OUTPUT
    SET SERVEROUTPUT ON 
    DECLARE
        vNumero1 Number(11,2) := 500;
        vNumero2 Number(11,2) := 400;
        vMedia Number(11,2);
    BEGIN
        vMedia := (vNumero1 + vNumero2)/2;
        DBMS_OUTPUT.PUT_LINE('Media = ' || vMedia); 
    END;