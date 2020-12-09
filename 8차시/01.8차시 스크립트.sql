-- ¿Œµ¶Ω∫ 
CREATE TABLE INDEX_TEST AS
SELECT * 
  FROM ALL_OBJECTS ,
      ( SELECT *
          FROM DUAL 
       CONNECT BY LEVEL <= 100);

EXEC DBMS_STATS.GATHER_TABLE_STATS('ORAUSER', 'INDEX_TEST');

SELECT COUNT(*)
FROM INDEX_TEST;

SELECT COUNT(*)
FROM INDEX_TEST
WHERE OBJECT_NAME = 'EMPLOYEES';

SELECT COUNT(*)
FROM INDEX_TEST
WHERE OBJECT_NAME = 'LOCATIONS';

CREATE INDEX INDEX_TEST_IDX1 ON INDEX_TEST ( OBJECT_NAME);

SELECT COUNT(*)
FROM INDEX_TEST
WHERE OBJECT_NAME = 'EMPLOYEES';

SELECT COUNT(*)
FROM INDEX_TEST
WHERE OBJECT_NAME = 'LOCATIONS';


SELECT COUNT(*)
FROM INDEX_TEST
WHERE SUBSTR(OBJECT_NAME,1,9) = 'EMPLOYEES'
  AND OBJECT_TYPE = 'TABLE';


DROP INDEX INDEX_TEST_IDX1;

-- Ω√≥Î¥‘
GRANT CREATE SYNONYM TO HR2;

CREATE SYNONYM emp_dept_v2 FOR HR.emp_dept_v2;

SELECT *
  FROM emp_dept_v2;
  
SELECT OWNER, OBJECT_NAME, OBJECT_ID, OBJECT_TYPE
FROM ALL_OBJECTS
WHERE OBJECT_NAME IN ( 'ALL_OBJECTS', 'ALL_TABLES', 'USER_TABLES');


-- Ω√ƒˆΩ∫
TRUNCATE TABLE emp;

CREATE SEQUENCE emp_seq;

SELECT sequence_name, 
       min_value, 
       max_value, 
       increment_by, 
       cache_size, 
       last_number, 
       cycle_flag
FROM user_sequences;


INSERT INTO emp
SELECT emp_seq.NEXTVAL,
       first_name || ' ' || last_name,
       salary, hire_date
 FROM employees
WHERE department_id = 90;

SELECT *
  FROM emp;
  
  
SELECT emp_seq.CURRVAL
  FROM dual;
 
SELECT sequence_name, 
       min_value, 
       max_value, 
       increment_by, 
       cache_size, 
       last_number, 
       cycle_flag
FROM user_sequences
WHERE sequence_name = 'EMP_SEQ'; 


INSERT INTO emp
SELECT emp_seq.NEXTVAL,
       first_name || ' ' || last_name,
       salary, hire_date
 FROM employees
WHERE department_id = 60;

SELECT *
  FROM emp;
  
  
-- ¡æ«’Ω«Ω¿
-- 1. ∑Œ∂« 
SELECT *
  FROM lotto_master
 ORDER BY 1;

SELECT *
  FROM lotto_detail
 ORDER BY 1, 2;
  
  
---------------------------------------------------------------------------------------------




insert into fine_dust_standard values ('KOREA', '¡¡¿Ω', 0, 30, 0, 15);
insert into fine_dust_standard values ('KOREA', '∫∏≈Î', 31, 80, 16, 35);
insert into fine_dust_standard values ('KOREA', '≥™ª›', 81, 150, 36, 75);
insert into fine_dust_standard values ('KOREA', '∏≈øÏ≥™ª›', 151, 999, 76, 999);

COMMIT;
  