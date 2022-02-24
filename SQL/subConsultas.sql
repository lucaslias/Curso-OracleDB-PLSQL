 -- Sub Consultas --
    -- Utilizamos quando precisamos do retorno de uma consulta para "filtar" a outra
    -- Sintaxe : SELECT ... FROM ... WHERE expressa operados (SELECT ... FROM ... ) 
    
    -- Single-Row (devem retornar apenas um linha e utilizar operadores apenas de comparação =, >, <, <>, <=, >=)
    SELECT first_name, last_name, job_id, salary
    FROM   employees
    WHERE  salary > (SELECT AVG(NVL(salary,0))
                    FROM employees);  
                    
    SELECT e1.department_id, MAX(e1.salary)
    FROM   employees e1
    GROUP BY e1.department_id
    HAVING MAX(salary) <  (SELECT AVG(e2.salary)
                        FROM   employees e2);
                        
    -- Multiple-Row(pode retornar mais de uma linha e devemos utilizar os operadores in, any, all)
    SELECT employee_id, first_name, last_name
    FROM   employees
    WHERE  salary IN --pode usar o not in também
                (SELECT    AVG(NVL(salary,0))
                 FROM      employees
                 GROUP BY  department_id);
                 
        --Usando Exists e not exisists (performance é melhor que o in)
        SELECT d.department_id, d.department_name
        FROM   departments d
        WHERE  EXISTS (SELECT e.department_id
                    FROM   employees e
                    WHERE d.department_id = e.department_id);
                    
        SELECT d.department_id, d.department_name
        FROM   departments d
        WHERE  NOT EXISTS (SELECT e.department_id
                   FROM employees e
                   WHERE d.department_id = e.department_id);
						
                 
    SELECT employee_id, last_name, job_id, salary
    FROM   employees
    WHERE  salary < ANY --qualquer(salario menor que qualquer valor do resultado)
                   (SELECT salary
                    FROM   employees
                    WHERE  job_id = 'IT_PROG');
    
    
    SELECT employee_id, last_name, job_id, salary
    FROM   employees
    WHERE  salary < ALL --todos(menor que todos os resultados)
                (SELECT salary
                FROM   employees
                WHERE  job_id = 'IT_PROG');
    
    -- SubConsultas Correalacionadas           
    SELECT e1.employee_id, e1.first_name, e1.last_name, e1.department_id, e1.salary
    FROM   employees e1
    WHERE  e1.salary >= (SELECT    TRUNC(AVG(NVL(salary,0)),0)
                        FROM  employees e2
                        WHERE  e1.department_id = e2.department_id);
                        
    -- Subconsultas Multiple-Collumn (se retorna mais de uma coluna a expressão tem que ter mais de uma)
    SELECT e1.employee_id, e1.first_name, e1.job_id, e1.salary
    FROM   employees e1
    WHERE (e1.job_id, e1.salary) IN (SELECT   e2.job_id, MAX(e2.salary)
                                    FROM     employees e2
                                    GROUP by e2.job_id);
                                    
    -- Subconsultas naclausula from
    SELECT empregados.employee_id, empregados.first_name, empregados.last_name, empregados.job_id, 
       empregados.salary, ROUND(max_salary_job.max_salary,2) MAX_SALARY, empregados.salary - ROUND(max_salary_job.max_salary,2) DIFERENÇA
    FROM   employees empregados
    LEFT JOIN (SELECT  e2.job_id, MAX(e2.salary) max_salary --É como se tivesse uma tabela em memoria
             FROM     employees e2
             GROUP by e2.job_id) max_salary_job
    ON empregados.job_id = max_salary_job.job_id;
								
    
    
    
    
    SELECT empregados.employee_id, empregados.first_name, empregados.last_name, empregados.job_id, 
        empregados.salary, ROUND(max_salary_job.max_salary,2) MAX_SALARY, empregados.salary - ROUND(max_salary_job.max_salary,2) DIFERENÇA
    FROM  employees empregados
  LEFT JOIN (SELECT  e2.job_id, MAX(e2.salary) max_salary
             FROM     employees e2
             GROUP by e2.job_id) max_salary_job
       ON empregados.job_id = max_salary_job.job_id;
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 