--- Estruras de Controle

    --- Operadores ---
        -- Mesmos do SQL
        -- Também mesma regra de precedencia 
        
    --- IF ---
        --Sintaxe:
            /* IF[NOT] expresao
                THEN
                    ...
               [ELSE]
                    ...
                END IF;  */
        SET SERVEROUTPUT ON
            ACCEPT pdepartment_id PROMPT 'Digite o Id do departamento: ' --Para esperar digitar
        DECLARE
            vpercentual     NUMBER(3);
            vDepartment_id  employees.employee_id%type := &pdepartment_id;
        BEGIN
            --Pode fazer so com else e if (sem o ELSIF)
            IF  vDepartment_id  =  80 
            THEN 
                vpercentual := 10; -- Sales
            ELSIF vDepartment_id  =  20 
            THEN 
                vpercentual := 15; -- Marketing
            ELSIF vDepartment_id  =  60 
            THEN 
                vpercentual := 20; -- IT
            ELSE
                vpercentual := 5;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Id do Departamento: ' || vDepartment_id);   
            DBMS_OUTPUT.PUT_LINE('percentual: ' || vpercentual );   
        END;
        
    --- CASE ---
        --Sintaxe:
            /*  CASE
                WHEN criterio/expresao THEN
                    ...
                WHEN criterio/expresao THEN
                    ...
                ELSE
                    ...
                END CASE;  */  
        SET SERVEROUTPUT ON
        ACCEPT pdepartment_id PROMPT 'Digite o Id do departamento: '
        DECLARE
            vpercentual     NUMBER(3);
            vDepartment_id  employees.employee_id%type := &pdepartment_id;
        BEGIN
            CASE --se não coloca aqui a expresao, coloca nos when. Se colocar aqui "vDepartment_id " no when terá apenas os numeros
            WHEN vDepartment_id = 80 THEN 
                vpercentual := 10; -- Sales
            WHEN vDepartment_id = 20 THEN 
                vpercentual := 15; -- Marketing
            WHEN vDepartment_id = 60 THEN 
                vpercentual := 20; -- IT
            ELSE 
                vpercentual := 5;
            END CASE;
            DBMS_OUTPUT.PUT_LINE('Id do Departamento: ' || vDepartment_id);   
            DBMS_OUTPUT.PUT_LINE('percentual: ' || vpercentual );   
        END;
        
        
        
    --- LOOP Basico ---
         --Sintaxe:
            /*  LOOP
                    ...
                EXIT [CONDICAO]
                END LOPP;  */  
    
        SET SERVEROUTPUT ON
        ACCEPT pLimite PROMPT 'Digite o valor do limite: '
        DECLARE
            vNumero  NUMBER(38) := 1;
            vLimite  NUMBER(38) := &pLimite;
        BEGIN
            LOOP 
                DBMS_OUTPUT.PUT_LINE('Número = ' || to_char(vNumero));
            EXIT WHEN vNumero = vLimite;
                vNumero := vNumero + 1;
            END LOOP;
        END;
        
    --- FOR LOOP ---
         --Sintaxe:
            /*  FOR indice IN [reverse] ** NÃO DECLARA O INDICE E EXISTE SOMENTE DENTRO LOOP
                    ...
                END LOPP;  */  
    
        SET SERVEROUTPUT ON
        ACCEPT pLimite PROMPT 'Digite o valor do limite: '
        DECLARE
            vInicio  INTEGER(3) := 1;
            vFim     NUMBER(38) := &pLimite;
        BEGIN
            FOR i IN vinicio..vfim  LOOP
                DBMS_OUTPUT.PUT_LINE('Número = ' || to_char(i) );
            END LOOP;
        END;
    
     --- WHILE LOOP ---
        --Sintaxe:
            /*  WHILE condicao LOOP
                    ...
                END LOOP;  */  
    
        SET SERVEROUTPUT ON
        ACCEPT pLimite PROMPT 'Digite o valor do limite: '
        DECLARE
          vNumero  NUMBER(38) :=  1;
          vLimite  NUMBER(38) := &pLimite;
        BEGIN
            WHILE  vNumero <= vLimite LOOP
                DBMS_OUTPUT.PUT_LINE('Número =  ' || to_char(vNumero));
                vNumero := vNUmero + 1;
                --pode colocar aqui dentro alguma condição extra de parada ( EXIT WHEN vNumero = vLimite;)
            END LOOP;
        END;
        
     -- LOOPs Aninhados ---
        -- Pode colocar um label nos loop
        -- Se sair do loop externo, sai do interno
        SET SERVEROUTPUT ON
        DECLARE
            vTotal   NUMBER(38) :=  1;
        BEGIN
            <<LOOP1>>
            FOR i IN 1..8 LOOP
                DBMS_OUTPUT.PUT_LINE('I =  ' || to_char(i));
                
                <<LOOP2>>
                    FOR j IN 1..8 LOOP
                        DBMS_OUTPUT.PUT_LINE('J =  ' || to_char(j));
                        DBMS_OUTPUT.PUT_LINE('Total =  ' || to_char(vTotal,'99G999G999G999G999G999G999G999D99'));
                        vTotal := vTotal * 2;
                        EXIT LOOP1 WHEN vtotal > 1000000000000000; --sai do loop1 e consequentemente do loop2
                    END LOOP;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('Total Final =  ' || to_char(vTotal,'99G999G999G999G999G999G999G999D99'));
        END;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        
        
        
        
        
        
        