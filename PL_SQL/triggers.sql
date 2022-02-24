--- Trigger ---
    -- Gatilhos disparados automaticamente a partir de eventos
    -- Está associado a tabelas ou views
    -- Possibilita implementar regras mais complexas, salvar informações de auditoria das tabelas
    -- Não pode em trigger os comando commit, rollback ou savepoint(com excecao do comando PRAGMA_AUTONOMUS_TRANSACTION que permite)[
    -- DML Triggers: dispara com INSERT, UPDATE, DELETE
    -- Elementos da Trigger:
        -- Tempo: BEFORE(antes), AFTER(depois), INSTEAD OF(ao inves de)
        -- Evento INSERT, UPDATE, DELETE
        -- Tipo: STATEMENT(nivel de comando), FOR EACH ROW(nivel de linha)
        -- Corpo: blocl pl/sql
        
    ------- A nivel de comando -------       
    CREATE OR REPLACE TRIGGER B_I_EMPLOYEES_S_TRG -- B de before, I de insert, S de statement
    BEFORE INSERT
    ON employees
    BEGIN
        IF  (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR  TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) NOT BETWEEN 8 AND 18) 
        THEN
            RAISE_APPLICATION_ERROR( -20001,'O cadastramento de Empregados só é permitido em dias de semana dentro do horário comercial');
        END IF;
    END;
    
    -- Testando
    BEGIN
        PCK_EMPREGADOS.PRC_INSERE_EMPREGADO('George', 'Harrison','GHARRISON','515.258.5690',SYSDATE,'IT_PROG',25000,NULL,103,60);
        COMMIT;
    END;
    
        --Combinando Varios eventos --
        CREATE OR REPLACE TRIGGER B_IUD_VALIDA_HORARIOS_TRG
        BEFORE INSERT OR UPDATE OR DELETE
        ON employees
        BEGIN
            IF  (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) NOT BETWEEN 8 AND 18) 
            THEN
                CASE
                WHEN INSERTING 
                THEN 
                    RAISE_APPLICATION_ERROR( -20001,'O cadastramento de Empregados só é permitido em dias de semana, dentro do horário comercial');
                WHEN DELETING
                THEN 
                    RAISE_APPLICATION_ERROR( -20002,'A deleção de Empregados só é permitido em dias de semana, dentro do horário comercial');
                ELSE
                    RAISE_APPLICATION_ERROR( -20003,'A atualização de Empregados só é permitido em dias de semana, dentro do horário comercial');
                END CASE;
            END IF;
        END;

   ------- A nivel de linha ------- 
        -- disparado antes ou depois da linha
        -- pode referenciar :old  &  :new 
        
        -- tabela para log
        CREATE TABLE employees_log
            (employees_log_id NUMBER (11) NOT NULL,
            dt_log    DATE DEFAULT SYSDATE NOT NULL ,
            usuario   VARCHAR2(30),
            evento    CHAR(1) NOT NULL,
            employee_id  NUMBER(6) NOT NULL,
            salary_old  NUMBER(8,2),
            salary_new  NUMBER(8,2));
        
        CREATE OR REPLACE TRIGGER A_IUD_EMPLOYESS_R_TRG
        AFTER INSERT OR UPDATE OF SALARY OR DELETE 
        ON EMPLOYEES
        FOR EACH ROW
        WHEN(new.job_id <> 'AD_PRES') --só ira fazer o trigger(gerar logs) quando o cargo for diferente de presidente
        DECLARE
            vevento       employees_log.evento%TYPE;
            vemployee_id  employees_log.employee_id%TYPE;
        BEGIN
            CASE
                WHEN INSERTING THEN
                    vevento      := 'I';
                    vemployee_id := :new.employee_id;
                WHEN UPDATING THEN
                    vevento      := 'U';
                    vemployee_id := :new.employee_id; --aqui tanto faz usar new ou old
                ELSE
                    vevento      := 'D';
                    vemployee_id := :old.employee_id;
            END CASE;
            INSERT INTO employees_log(employees_log_id, dt_log, usuario,  evento,employee_id, salary_old, salary_new)
                VALUES (employees_log_seq.nextval,SYSDATE, USER,vevento,vemployee_id, :old.salary,:new.salary);
                
        END A_IUD_EMPLOYESS_R_TRG;
        
        -- Testando (não é para um update, é update para varias linhas)
        UPDATE employees SET salary = salary * 1.5;
        
   ------- Regras de Mutating Tables ------- 
        -- Mutating Tables  = tabelas que sofrem alteração durante a execucao da trigger
        -- regra 1: não altere dados de colunas PK, FK ou UNIQUE 
        -- regra 2: não leia informações de tabelas que estão sendo modificadas(Mutating Tables)
        
        -- Regra 1 --
        CREATE OR REPLACE TRIGGER A_I_EMPLOYEES_R_TRG
        BEFORE INSERT 
        ON employees
        FOR EACH ROW
        BEGIN
            -- Não pode fazer o update porque o campo é unique
            --UPDATE employees SET email = UPPER(SUBSTR(:new.first_name,1,1) || :new.last_name) WHERE employee_id = :new.employee_id;
            :new.email := UPPER(SUBSTR(:new.first_name,1,1) || (:new.last_name));
        END;
        -- Testando a correção da Violação da Regra 1 
        SET VERIFY OFF
        BEGIN
            PRC_INSERE_EMPREGADO('Eric', 'Clapton','ECLAPTON','515.188.4861',SYSDATE,'IT_PROG',15000,NULL,103,60);
            COMMIT;
        END;
        
        -- Regra 2 --
            --(Exemplo do que não pode)
            CREATE OR REPLACE TRIGGER B_U_VALIDATE_SALARY_EMPLOYEES_R_TRG
            BEFORE UPDATE OF salary
            ON  employees
            FOR EACH ROW
            DECLARE
                vMaxSalary  employees.salary%TYPE;
            BEGIN
                SELECT MAX(salary) INTO   vMaxSalary FROM   employees;
    
                IF  :new.salary > vMaxSalary * 1.2 THEN  
                    RAISE_APPLICATION_ERROR(-20001, 'Salario não pode ser superior ao maior salario + 20%');
                END IF;
            END;
            
            --(Ajustando)
                -- Para ajustar o ideal é criar um package com dois trigger
                    -- um a nivel de tabela para pegar o maior valor e salva na varaivel
                    -- e outro para a validação ( que pega a clausula da variavel declarada)
                    -- Assim contorna o problema
            
    -- Desabilitar Trigger
    alter trigger B_IUD_VALIDA_HORARIO_EMPLOYEES_S_TRG disable;
    
    -- Habilitando Trigger
    alter trigger B_IUD_VALIDA_HORARIO_EMPLOYEES_S_TRG enable;
    
    -- Desabilitar/habilitar todos os trigger de uma tabela de uma unica vez
    alter TABLE B_IUD_VALIDA_HORARIO_EMPLOYEES_S_TRG enable all triggers;
    
    -- Consultar Trigger pelo dicionario
    SELECT * FROM user_triggers WHERE  table_name = 'EMPLOYEES';
    
    -- Remover uma Trigger
    DROP TRIGGER B_IUD_VALIDA_HORARIO_EMPLOYEES_S_TRG;
        
    
    
    