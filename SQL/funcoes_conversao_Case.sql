----- Funcoes de Caractere ------
    -- Lower, upper, initcap(apenas a primeira letra para maiusculo)
    -- concat(arg1, arg2) -> junta os dois 
       -- substr(argumento, ondeComeca, ondeTermina) -> seleciona caracteres
       -- lenght(arg) -> tamanho da string
       -- instr(arg, string) -> procura pela string dentro do argumento
       -- LPAD e RPAD (arg, qntCaracteres, caractereQuepreenche) -> alinha a esquerda ou direita
       -- TRIM(arg),RTRIM, LTRIM -> remove os espaços(direita e/ou esquerda)
       -- REPLACE(arg, oQueVaiSubst, peloOque) -> Substitui caractere
    
SELECT employee_id, last_name, department_id FROM employees WHERE UPPER(last_name) = 'KING'; 

SELECT CONCAT(' Curso: ','Introdução ORACLE 19c'), SUBSTR('Introdução ORACLE 19c',1,11),
LENGTH('Introdução ORACLE 19c'), INSTR('Introdução ORACLE 19c','ORACLE')
FROM dual; --FROM dual é para retornar o valor (existe em todos os bancos)

SELECT first_name "Nome", LPAD(first_name, 20, ' ') "Nome alinhado a direita", RPAD(first_name, 20, ' ') "Nome alinhado a esquerda"
FROM   employees;

------ Funções Number ------
    -- ROUND(arredonda as casas)
    -- TRNNC (corta as casas sem arredondar)
    -- MOD (retorno da divisão)
    -- ABS (retorna o numero positivo)
    -- SQRT (retorna a raiz quadrada)
    
SELECT ROUND(45.923,2), ROUND(45.923,0) FROM dual;
SELECT TRUNC(45.923,2), TRUNC(45.923,0) FROM dual;
SELECT MOD(1300,600) RESTO FROM dual;
SELECT ABS(-9), SQRT(9) FROM dual;

------ Funções Date ------ (formato é definido pelo banco)
    -- SYSDATE (retorna data atual)
    -- data + numero, data - numero (adicionar dias)
    -- data + numero /24 (adicionar horas, pode usar para semanas porém tem q alterar a logica)
    -- MOUNTHS_BETWEEN, ADD_MONHS, NEXT_DAY, LAST_DAY, 
        --ROUND(arredondar), TRUNC
    
    SELECT sysdate FROM dual;
    SELECT sysdate, sysdate + 30, sysdate + 60, sysdate - 30 FROM dual;
    
    SELECT first_name, last_name, ROUND(MONTHS_BETWEEN(sysdate, hire_date),2) "MESES DE TRABALHO" FROM employees;

    SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3), NEXT_DAY(SYSDATE,'Friday'), LAST_DAY(SYSDATE) FROM dual; --Pega a proxima e ultima sexta feira

    SELECT sysdate, ROUND(SYSDATE, 'MONTH'), ROUND(SYSDATE, 'YEAR'),  TRUNC(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'YEAR') FROM  dual;
        --se já passou da metade do mes arredonda para cima (não muito usado)
       
    SELECT SYSDATE, TO_CHAR(TRUNC(SYSDATE),'DD/MM/YYYY HH24:MI:SS') FROM  dual; --Para comprar dias sem as horas
    

------ Funções de Conversão(implicia e explicita) ------ 
    -- Ideal sempre usar a conversão explicita
    -- TO_CHAR(arg, 'formato') ]
        SELECT last_name,TO_CHAR(hire_date, 'DD/MM/YYYY  HH24:MI:SS') DT_ADMISSÂO FROM employees; --convertendo para caractere
        SELECT sysdate,TO_CHAR(sysdate, 'DD/MM/YYYY  HH24:MI:SS') DATA FROM   dual;
        SELECT last_name, TO_CHAR(hire_date, 'DD, "de" Month "de" YYYY') DT_ADMISSÂO FROM employees;
        SELECT last_name, TO_CHAR(hire_date, 'FMDD, "de" Month "de" YYYY') DT_ADMISSÂO FROM employees; --FM elimina zeros e espaços a esquerda
        
        -- 9 é para supressão de zeros a esquerda, 0 é incluindo os zeros
        SELECT first_name, last_name, TO_CHAR(salary, 'L99G999G999D99') SALARIO FROM employees; -- 'L' é moeda local, G é para o simbolo ".', D é o decimal
    
        -- Caractere para numero
        SELECT TO_NUMBER('12000,50') FROM  dual;
        
        -- Caractere para data
        SELECT TO_DATE('06/02/2020','DD/MM/YYYY') DATA FROM  dual;
        
        -- Funcoes Alinhadas
        SELECT first_name, last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date),0) NUMERO_MESES
        FROM   employees
        WHERE  hire_date = TO_DATE('17/06/2003','DD/MM/YYYY');
        
        -- Funcoes Genericas
            --Nvl (se o argumento for nulo usa o parametro informado)
                SELECT last_name, salary, NVL(commission_pct, 0), salary*12 SALARIO_ANUAL, 
                (salary*12) + (salary*12*NVL(commission_pct, 0)) REMUNERACAO_ANUAL
                FROM employees;
                
            --nvl2 (se for nulo usa o primeiro argumento, se não for usa o segundo )
            SELECT last_name, salary, commission_pct,
            NVL2(commission_pct, 10, 0) PERCENTUAL_ATERADO
            FROM employees;
            
            --NULLIF(recebe 2 argumentos e compara, se for igual retorna null, se for igual retorna o primeiro)
            SELECT NULLIF(1000,1000), NULLIF(1000,2000) FROM dual;
            
            --COALESCE (recebe uma lista de argumentos, procura na lista e o primeiro diferente de nulo retorna)
            SELECT COALESCE(NULL, NULL, 'Expresssão 3'), 
                COALESCE(NULL, 'Expressão 2', 'Expresssão 3'),
                COALESCE('Expressão 1', 'Expressão 2', 'Expresssão 3')
            FROM dual;

------ Expressões Condicionais ------ 
    -- CASE
        /*
        CASE exp 
            WHEN expr1 THEN
                return expr1
            WHEN expr2 THEN
                return expr1
            ELSE
                return expr
        END alias;
        */
        
        SELECT last_name, job_id, salary,
            CASE job_id
                WHEN 'IT_PROG' THEN 1.10*salary
                WHEN 'ST_CLERK' THEN 1.15*salary
                WHEN 'SA_REP' THEN 1.20*salary
                ELSE salary 
             END "NOVO SALARIO"
        FROM employees;

    -- DECODE(Coluna, argumento, resultado
    SELECT last_name, job_id, salary,
    DECODE(job_id,  'IT_PROG' , 1.10*salary,
                    'ST_CLERK', 1.15*salary,
                    'SA_REP'  , 1.20*salary
                              , salary) "NOVO SALARIO"
    FROM employees;







    