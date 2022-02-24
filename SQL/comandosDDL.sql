-- Comandos DDL --
    --TABLES, VIEW, SEQUENCE, INDECEM, SYNONYM  
    -- COMMIT automatico
    
    /* --- Pricipais Tipos ---
        VARCHAR2 - alfanumerico (4000bytes)
        CHAR - alfanumerico de tamanho fixo
        DATE -
        NUMBER(p,s) - p quantidade de numeros, s da quantidade do p quantos são decimais
        LONG - Alfa (um pouco ubsoleto, até 2gb)
        CLOB - Alfa (utilizado 4gb - 1 byte * tamanho do bloco(definido pelo dba)    )
        RAW - Dados binarios (2000 bytes, um pouco obsoleto)
        LONG RAW - Dados binarios (até 2 gb, um pouco obsoleto)
        BLOB - Dados binarios(até 4gb, mais utilizado)
        BFILE - armazena um ponteiro que aponta para o dado binario(até 4gb)
        ROWID - armazena o endereço de uma coluna da tabela (é o acesso mais rapido que tem)
        BYNARY_FLOAT - fica armazenado como ponto ponto flutuante (melhor que number)
        BYNARY_DOUBLE - ponto flutuante com precisão de duas casas (melhor que number)
        TIMESTAMP - também para data (armazena mais casas nos segundos)
        INTERVAL YEAR TO MONTH - armazena como um intervalo de anos e meses
        INTERVAL DAY TO SECOND - armazena como um intervalo de dias, horas, minutos e segundos  
    */
    
    SELECT * FROM user_objects order by object_type; --consulta os objetos no banco
    
    SELECT table_name FROM user_tables; --consulta as tabelas
        SELECT object_name FROM user_objects WHERE  object_type = 'TABLE'; --outra forma
    
    -- TABLE
        DROP TABLE projects;
        
        CREATE TABLE projects(
            project_id    NUMBER(6)    NOT NULL,
            project_code  VARCHAR2(10) NOT NULL,
            project_name  VARCHAR2(100) NOT NULL,
            CREATION_DATE DATE DEFAULT sysdate NOT NULL, --default se não inserir valor usa este
            START_DATE    DATE,
            END_DATE      DATE,
            STATUS        VARCHAR2(20) NOT NULL,
            PRIORITY      VARCHAR2(10) NOT NULL,
            BUDGET        NUMBER(11,2) NOT NULL, -- 11 digitos com 9 inteiros e 2 decimais
            DESCRIPTION   VARCHAR2(400) NOT NULL
        );
        
        DESC projects
        
        CREATE TABLE TEAMS(
            project_id    NUMBER(6)  NOT NULL,
            employee_id   NUMBER(6)  NOT NULL
        );
        
        -- Criando tabela com subconsulta(mesmos campos, com mesmos tipos e já insere os valores da consulta)
        CREATE TABLE employees_department60
        AS
            SELECT employee_id, last_name,salary*12 ANNSAL, hire_date
            FROM employees
            WHERE department_id = 60;


    --TRUNCATE
        -- mais rapido que o delete
        -- não tem volta
        TRUNCATE TABLE employees_department60;
        
    
    --DROP TABLE
        --Remove a tabela, colocando na lixeira
        --Pode recuperar com o RECYCLE BIN
        --Se não quer deixar ir para a lixeira utilizar o comando PURGE (não muito utilizado)
        DROP TABLE employees_department60;
        SELECT * FROM user_recyclebin;
        flashback table nome_tabela to before drop; --para restaurar
     
    
    
    
    
    
    
    
    
    
    
    