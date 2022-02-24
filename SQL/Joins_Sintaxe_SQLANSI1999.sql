-- Dados de multiplas tabelas --
    -- Utilizar prefixoas nas colunas e alias nas tabelas
    
    -- Sintaxes SQL ANSI 1999 são comprativeis com todos os bancos compativeis
    
    -- Natural Joins (liga as colunas com mesmo nome e mesmo tipo de dados) *** não é muito comum ***
    SELECT  department_id, department_name, location_id, city
    FROM    departments
    NATURAL JOIN locations;
        
    SELECT e.employee_id, e.last_name, d.location_id, department_id, d.department_name -- *** não é muito utilizado ***
    FROM employees e
    JOIN departments d USING (department_id); -- Passa o nome da coluna que está nas duas
        
    SELECT e.employee_id, e.last_name, e.department_id, d.location_id -- *** é o mais utilizado ***
    FROM employees e JOIN departments d
    ON (e.department_id = d.department_id);
        
    -- Com varias tabelas
    SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
    FROM employees e JOIN jobs j 
        ON (e.job_id = j.job_id)
    JOIN departments d 
        ON (e.department_id = d.department_id)
    JOIN locations   l 
        ON (d.location_id = l.location_id)
    --Pode colocar o where
    ORDER BY e.employee_id;
        
    --SELF JOIN (ela com ela mesmo)
    SELECT empregado.employee_id "Id empregado", empregado.last_name "Sobrenome empregado", gerente.employee_id "Id gerente", gerente.last_name "Sobrenome gerente"
    FROM employees empregado JOIN employees gerente
    ON (empregado.manager_id = gerente.employee_id)
    ORDER BY empregado.employee_id;
        
    --Nonequijoins (quando a condição de ligação entre as tabelas não é uma igualdade)
    SELECT  e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
    FROM  employees e JOIN job_grades j
        ON  NVL(e.salary,0) BETWEEN j.lowest_sal AND j.highest_sal
    ORDER BY e.salary;
        
     -- INNER JOIN (a palavra inner é opcional é a mesma coisa que só join)
    SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
    FROM   employees e INNER JOIN jobs j 
        ON e.job_id = j.job_id
    INNER JOIN departments d 
        ON d.department_id = e.department_id
    INNER JOIN locations   l 
        ON d.location_id = l.location_id
    ORDER BY e.employee_id;
        
    -- OUTER JOINS (quando pode não ter correspondente em outra tabela)
         --LEFT OUTER JOIN (todas que a condição de ligação está nas duas + não tem correspondente na direita)
        SELECT e.first_name, e.last_name, d.department_id, d.department_name
        FROM employees e LEFT OUTER JOIN departments d --tras todos com funcionarios com deparamento e os que não tem departamanto
            ON (e.department_id = d.department_id) 
        ORDER BY d.department_id;
            
        --RIGHT OUTER JOIN (todas que a condição de ligação está nas duas + não tem correspondente na esquerda)
        SELECT d.department_id, d.department_name, e.first_name, e.last_name
        FROM employees e RIGHT OUTER JOIN departments d --todos os departamentos com funcionarios e os departamantos sem empregados
            ON (e.department_id = d.department_id) 
        ORDER BY d.department_id;
            
        -- FULL OUTER JOIN
        SELECT d.department_id, d.department_name, e.first_name, e.last_name
        FROM employees e FULL OUTER JOIN departments d --tras todos, os que não tem tem correspondente na direita e/ou esquerda
            ON (e.department_id = d.department_id) 
        ORDER BY d.department_id;
        
        -- CROSS JOIN (Cartesiano) -> todos as linhas da tabela "a" estarão combinadas com todas da tabela "b"
        SELECT last_name, department_name
        FROM   employees
        CROSS JOIN departments;
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

 
        
        