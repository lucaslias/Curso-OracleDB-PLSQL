-- CONSTRAINTS --
    -- Pode dar um nome ou o oracle da
    
    -- NOT NULL
    CREATE TABLE teste1(
        project_id    NUMBER(6)    NOT NULL,
        project_code  VARCHAR2(10) NOT NULL,
        project_name  VARCHAR2(100)NOT NULL,
        department_id NUMBER(4)    NOT NULL
    );
    
    
    -- PRIMARY KEY
    
        --Nivel de coluna
        CREATE TABLE testePK(
            project_id    NUMBER(6)    NOT NULL
            CONSTRAINT projects_project_id_pk PRIMARY KEY,
            project_code  VARCHAR2(10) NOT NULL,
            project_name  VARCHAR2(100)NOT NULL,
            department_id NUMBER(4)    NOT NULL,
            CREATION_DATE DATE DEFAULT sysdate NOT NULL,
            START_DATE    DATE
        );
        
        -- Nivel de tabela
        CREATE TABLE testepk2(
            project_id    NUMBER(6)    NOT NULL, 
            project_code  VARCHAR2(10) NOT NULL,
            project_name  VARCHAR2(100)NOT NULL,
            department_id NUMBER(4)    NOT NULL,
            CREATION_DATE DATE DEFAULT sysdate NOT NULL,
            START_DATE    DATE,
            CONSTRAINT projects_project_id_pk PRIMARY KEY(project_id)
        );
    
    
    -- UNIQUE
        --Nivel de coluna
        CREATE TABLE testeUNQ(
            project_id    NUMBER(6)    NOT NULL
            CONSTRAINT projects_project_id_pk PRIMARY KEY,
            project_code  VARCHAR2(10) NOT NULL
            CONSTRAINT projects_project_code_uk UNIQUE,
            project_name  VARCHAR2(100)NOT NULL,
            department_id NUMBER(4)    NOT NULL
        );
    
        CREATE TABLE testeUNQ2(
            project_id    NUMBER(6)    NOT NULL, 
            project_code  VARCHAR2(10) NOT NULL,
            project_name  VARCHAR2(100)NOT NULL,
            department_id NUMBER(4)    NOT NULL,
            CREATION_DATE DATE DEFAULT sysdate NOT NULL,
            START_DATE    DATE,
            CONSTRAINT projects_project_id_pk PRIMARY KEY(project_id),
            CONSTRAINT projects_project_code_uk UNIQUE (project_code)
        );
    
    
    -- FOREIGN KEY
        --Nivel de coluna
        CREATE TABLE testeFK(
            project_id    NUMBER(6)    NOT NULL
            CONSTRAINT projects_project_id_pk PRIMARY KEY,
            project_code  VARCHAR2(10) NOT NULL
            CONSTRAINT projects_project_code_uk UNIQUE,
            project_name  VARCHAR2(100)NOT NULL,
            department_id NUMBER(4)    NOT NULL
            CONSTRAINT projects_department_id_fk REFERENCES departments,
            START_DATE    DATE,
            END_DATE      DATE
        );
        
        --Nivel de tabela
        CREATE TABLE testeFK2(
            project_id    NUMBER(6)    NOT NULL, 
            project_code  VARCHAR2(10) NOT NULL,
            project_name  VARCHAR2(100)NOT NULL,
            department_id NUMBER(4)    NOT NULL,
            CREATION_DATE DATE DEFAULT sysdate NOT NULL,
            CONSTRAINT projects_project_id_pk PRIMARY KEY(project_id),
            CONSTRAINT projects_project_code_uk UNIQUE (project_code),
            CONSTRAINT projects_department_id_fk FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        );
        
        -- Após o reference pode colocar
            -- Default No Action (é o defaulta não deixa deletar)
            -- ON DELETE CASCADE (se tentar deletar, deleta das duas tabelas)
            -- ON DELETE SET NULL (se deletar da tabela irá marcar os campos como null)

    
    -- CHECK
        --Nivel de coluna
            CREATE TABLE testeCheck (
                project_id    NUMBER(6)    NOT NULL
                    CONSTRAINT projects_project_id_pk PRIMARY KEY,
                project_code  VARCHAR2(10) NOT NULL
                    CONSTRAINT projects_project_code_uk UNIQUE,
                project_name  VARCHAR2(100)NOT NULL,
                department_id NUMBER(4)    NOT NULL
                    CONSTRAINT projects_department_id_fk REFERENCES departments,
                CREATION_DATE DATE DEFAULT sysdate NOT NULL,
                BUDGET  NUMBER(11,2) NOT NULL 
                    CONSTRAINT projects_budget_ck CHECK (budget > 0),
                DESCRIPTION   VARCHAR2(400)NOT NULL
            );
            
            --Nivel de tabela
            CREATE TABLE projects(
                project_id    NUMBER(6)    NOT NULL, 
                project_code  VARCHAR2(10) NOT NULL,
                project_name  VARCHAR2(100)NOT NULL,
                department_id NUMBER(4)    NOT NULL,
                CREATION_DATE DATE DEFAULT sysdate NOT NULL,
                BUDGET  NUMBER(11,2) NOT NULL ,
                CONSTRAINT projects_project_id_pk PRIMARY KEY(project_id),
                CONSTRAINT projects_project_code_uk UNIQUE (project_code),
                CONSTRAINT projects_department_id_fk FOREIGN KEY (department_id) REFERENCES departments(department_id) ,
                CONSTRAINT projects_budget_ck CHECK (budget > 0)
            );
            
    -- Consultas no dicionario de dados P (PRIMARY) ,U (UNIQUE) , R(FOREIGN KEY) ,C (CHECK)
    DESC user_constraints
    DESC user_cons_columns

    SELECT co.constraint_name, co.constraint_type, co.search_condition, co.r_constraint_name,co.delete_rule,cc.column_name, cc.position, co.status
    FROM   user_constraints co JOIN user_cons_columns cc 
    ON (co.constraint_name = cc.constraint_name) AND  (co.table_name = cc.table_name)
    WHERE  co.table_name = 'PROJECTS'
    ORDER BY co.constraint_name, cc.position;
    
    -- Remover Constraint
    ALTER TABLE projects DROP CONSTRAINT projects_department_id_fk; --se já tem referencias precisada do cascade
    
    -- Adicionar Constraints
    ALTER TABLE projects ADD CONSTRAINT projects_department_id_fk FOREIGN KEY (department_id) REFERENCES departments(department_id);
    
    -- Desabilitar Constraints
    ALTER TABLE projects DISABLE CONSTRAINT projects_project_id_pk CASCADE;--se já tem referencias precisada do cascade
    ALTER TABLE projects ENABLE CONSTRAINT projects_project_id_pk;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    