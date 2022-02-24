-- Operadores Set --
    -- Trabalham com conjuntos
    -- UNION/UNION ALL, INTERSECT, MINUS
    -- Precisa do mesmo numero de coluna e mesmo tipo 
    -- Order by somente no resultado final
    -- Todos eliminam linhas duplicadas, menos o UNION ALL
    -- Resolve de cima para baixo
    
    -- UNION(todos os resultados select a e mais os do b, sem os duplicados)
    SELECT employee_id, job_id, hire_date, salary
    FROM   employees
    WHERE  department_id IN (60, 90, 100)
        UNION
    SELECT employee_id, job_id, hire_date, salary
    FROM   employees
    WHERE  job_id = 'IT_PROG'
    ORDER BY employee_id;
    
    --UNION ALL(todos os resultados select a e mais os do b, com os duplicados)
    SELECT employee_id, job_id, hire_date, salary
    FROM   employees
    WHERE  job_id = 'IT_PROG'
        UNION ALL
    SELECT employee_id, job_id, hire_date, salary
    FROM   employees
    WHERE  department_id = 60
    ORDER BY employee_id;
    
    -- INTERSECT (faz a inserseção, somente as linhas em comum)
    SELECT employee_id, job_id
    FROM   employees
    WHERE  job_id = 'IT_PROG'
        INTERSECT
    SELECT employee_id, job_id
    FROM   employees
    WHERE  department_id IN (60, 90, 100)
    ORDER BY employee_id;
    
    -- MINUS(os dados do primeiro select que não está no segundo)
    SELECT employee_id, job_id
    FROM   employees
    WHERE  department_id IN (60, 90, 100)
        MINUS
    SELECT employee_id, job_id
    FROM   employees
    WHERE  job_id = 'IT_PROG'
    ORDER BY employee_id;
    