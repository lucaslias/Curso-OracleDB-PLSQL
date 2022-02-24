-- Principais Funcoes de Grupo -- (é possivel alinhar funcoes)
    -- AVG, COUNT, MAX, MIN, SUM, STDDEV(desvio padrão), VARIANCE(variancia)
    -- Sintaxe:
        /*
            SELECT funcao(coluna) from tabela [WHERE][ORDER BY]
        */
    SELECT AVG(salary), SUM(salary) FROM  employees; --numericos (ignora as linhas nulas no avg, ajustar com o NVL para zero pq ai irá participar da conta)
    SELECT MIN(hire_date), MAX(hire_date) FROM employees; -- também aceita caractere e datas
    
    SELECT COUNT(*) FROM employees; --conta todas as linhas
    SELECT COUNT(commission_pct) FROM employees; --so conta as colunas diferente de null
    SELECT COUNT(DISTINCT department_id) FROM employees; --não conta linhas repetidas
    
--- Utilizando GROUP BY ---
    -- Sequencia Logica: WHERE -> GROUP BY -> HAVING -> ORDER BY
    -- Sintaxe:
        /*
            SELECT coluna,funcao(coluna) from tabela [WHERE] [GROUB BY] [ORDER BY]
        */
    SELECT department_id, job_id, SUM(salary) --regra só pode exibir colunas sem funcoes de agrupamento se estiver no group by
    FROM employees
    GROUP BY department_id, job_id --agrupa por departameno e depois por job 
    ORDER BY department_id, job_id;

    --HAVING (para usar funções de grupo na clausula where)
        --SELECT department_id, MAX(salary) FROM   employees WHERE MAX(salary)>10000; GROUP BY department_id; *** DA ERRO ***
    SELECT department_id, MAX(salary) FROM   employees GROUP BY department_id HAVING MAX(salary)>10000;
    
    SELECT job_id, SUM(salary) TOTAL
    FROM   employees
    WHERE  job_id <> 'SA_REP'
    GROUP BY job_id
    HAVING   SUM(salary) > 10000
    ORDER BY SUM(salary);
        








