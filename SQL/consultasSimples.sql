-- Descibe nome_tabela -> para exibir a estrutura da tabela
Describe employees (DESC faz a mesma coisa)

-- select * from nome_tabela,
    --select coluna, coluna * from nome_tabela 
select * from employees

select first_name,(salary + 100)*1.15 as "salarioAjustado" from employees --alias(pode ser com ou sem as)

SELECT first_name || ' ' || last_name as "Funcionario" FROM employees --concatenar campos
    --string de caractere aspas simples
    --alias aspas duplas
    --se existir aspas no campo usar o [] como operados alteranativo
        select department_name || q'[ Department1's Manager ID: ]' || manager_id "Departamento" from departments;
        
SELECT DISTINCT department_id from departments; --exibir uma vez apenas

SELECT * FROM employees WHERE department_id = 90 --Clausula WHERE 
SELECT * FROM employees WHERE last_name = 'King' --entre aspas simples
    
--Operadores Disponiveis  =, >, >=, <=, <>, BETWEEN ... AND ... , IN(), LIKE, IS NULL, AND, OR, NOT
SELECT last_name, salary FROM employees WHERE salary >= 10000;

SELECT last_name, salary FROM employees WHERE salary BETWEEN 10000 AND 15000;

SELECT employee_id, last_name, salary, manager_id, job_id FROM employees WHERE job_id IN ('IT_PROG', 'FI_ACCOUNT', 'SA_REP') ;

SELECT first_name, last_name, job_id FROM employees WHERE first_name LIKE 'Sa%';
    SELECT first_name, last_name FROM employees WHERE last_name LIKE '_a%'; --substitui o _ por um caractere

SELECT last_name, manager_id FROM employees WHERE manager_id IS NULL ;
    
SELECT employee_id, last_name, job_id, salary FROM employees WHERE salary >= 5000 OR  job_id =  'IT_PROG';

SELECT employee_id, last_name, job_id, salary FROM employees WHERE salary >= 5000 AND job_id =  'IT_PROG' ;


-- Regras de Precedencia 
    --Aritmeticos -> concatecação -> comparacao -> is null -> between -> equal -> not -> and -> or
    --Ajusta a procedencia com paranteses

-- ORDER BY(pode usar o alias ou a referencia da posicao da coluna, pode colocar mais de uma)
    --Desc
    SELECT last_name, job_id, department_id, hire_date FROM employees ORDER BY hire_date DESC
    --ASC
    SELECT last_name, job_id, department_id, hire_date FROM employees ORDER BY hire_date ASC; --NAO PRECISA COLOCAR
    
-- Variaveis de substituição(sql abre uma caixa para aguardar o usuario digitar)
    SELECT employee_id, last_name, salary, department_id FROM employees WHERE employee_id = &employee_id;
    --Com 2 "&" irá pedir só a primeira vez
    SELECT employee_id, last_name, salary, department_id FROM employees WHERE employee_id = &&employee_id;
    -- colocar aspas simples para caractere
    SELECT last_name, department_id, job_id, salary*12 FROM employees WHERE last_name = '&name' ;
    
-- DEFINE (para definir valor a uma variavel e UNDEFINE para remover (mas DEFINE não é muito usado
DEFINE employee_id = 101
SELECT employee_id, last_name, salary, department_id FROM employees WHERE employee_id = &employee_id ;
UNDEFINE employee_id --

    
    
    

