-- 스칼라 서브쿼리 

-- 1
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id ) dept_name
  FROM employees a
 ORDER BY 1;
 
-- 2
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
       ) dept_name
  FROM employees a
 ORDER BY 1;
 

-- 3
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name, b.location_id
           FROM departments b
          WHERE a.department_id = b.department_id ) dept_name
  FROM employees a
 ORDER BY 1; 
 
-- 4
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, a.job_id
      ,( SELECT b.job_title || '(' || b.job_id || ')'
           FROM jobs b
          WHERE a.job_id = b.job_id ) job_names
FROM employees a
ORDER BY 1;

-- 5-1
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id   
 ORDER BY 1;

-- 5-2
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id ) dept_name
  FROM employees a
 ORDER BY 1;
 
-- 6
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id 
       ) dept_name,
       ( SELECT d.country_name
           FROM departments b
               ,locations c
               ,countries d
          WHERE a.department_id = b.department_id 
            AND b.location_id = c.location_id
            AND c.country_id = d.country_id
        ) country_name
             
  FROM employees a
 ORDER BY 1;

 
-- 인라인 뷰
-- 1
SELECT a.employee_id,
       a.first_name || a.last_name emp_name,
       a.department_id, 
       c.dept_name
FROM employees a,
    ( SELECT b.department_id, 
             b.department_name  dept_name
        FROM departments b 
    ) c
WHERE a.department_id = c.department_id
ORDER BY 1;
 
-- 2 
SELECT a.employee_id,
       a.first_name || a.last_name emp_name,
       a.department_id, 
       c.dept_name
FROM employees a,
    ( SELECT b.department_id, 
             b.department_name  dept_name
        FROM departments b
       WHERE a.department_id = b.department_id
    ) c
ORDER BY 1; 
  
-- 3 
SELECT a.employee_id,
       a.first_name || a.last_name emp_name,
       a.department_id, 
       c.dept_name
FROM employees a,
     LATERAL ( SELECT b.department_id, 
                      b.department_name  dept_name
                FROM departments b
               WHERE a.department_id = b.department_id
             ) c
  ORDER BY 1;   

-- 4
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       dept.department_name,
       loc.street_address, loc.city, loc.country_name
FROM employees a
   ,( SELECT *
        FROM departments b ) dept
   ,( SELECT l.location_id, l.street_address, 
             l.city, c.country_name
        FROM locations l,
             countries c
       WHERE l.country_id = c.country_id 
     ) loc
 WHERE a.department_id = dept.department_id
   AND dept.location_id = loc.location_id
 ORDER BY 1;   
             
             
-- 5
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       dept_loc.department_name,
       dept_loc.street_address, dept_loc.city, 
       reg.country_name, reg.region_name
FROM employees a
   ,( SELECT b.department_id, b.department_name,
             l.street_address, l.city, l.country_id
        FROM departments b,
             locations l
       WHERE b.location_id = l.location_id
     ) dept_loc
   ,( SELECT c.country_id, c.country_name,
             r.region_name
        FROM countries c,
             regions r
       WHERE c.region_id = r.region_id 
         AND c.country_id = dept_loc.country_id
     ) reg
 WHERE a.department_id = dept_loc.department_id
 ORDER BY 1;
 
 
-- 6
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       dept_loc.department_name,
       dept_loc.street_address, dept_loc.city, 
       reg.country_name, reg.region_name
FROM employees a
   ,( SELECT b.department_id, b.department_name,
             l.street_address, l.city, l.country_id
        FROM departments b,
             locations l
       WHERE b.location_id = l.location_id
     ) dept_loc
   ,LATERAL ( SELECT c.country_id, c.country_name,
             r.region_name
        FROM countries c,
             regions r
       WHERE c.region_id = r.region_id 
         AND c.country_id = dept_loc.country_id
     ) reg
 WHERE a.department_id = dept_loc.department_id
 ORDER BY 1; 
          
-- 7
SELECT a.department_id, a.last_name, a.salary,
       k.department_id second_dept_id,
       k.avg_salary 
  FROM employees a,
      ( SELECT b.department_id, AVG(b.salary) avg_salary
          FROM employees b
         GROUP BY b.department_id
      ) k
 WHERE a.department_id = k.department_id     
ORDER BY a.department_id;       
          
-- 중첩 서브쿼리
-- 1
SELECT *
  FROM departments 
 WHERE department_id IN ( SELECT department_id
                            FROM employees
                        ) ;

-- 2
SELECT *
  FROM departments a
 WHERE EXISTS ( SELECT  1
                  FROM employees b
                 WHERE a.department_id = b.department_id 
              ) ;

-- 3
SELECT *
  FROM departments a
 WHERE EXISTS ( SELECT 'A'
                  FROM employees b
                 WHERE a.department_id = b.department_id
                   AND b.salary > 10000 );

-- 4                   
SELECT employee_id,
       first_name || ' ' || last_name emp_name,
       job_id, 
       salary
  FROM employees 
 WHERE (job_id, salary ) IN ( SELECT job_id, min_salary
                                FROM jobs)
ORDER BY 1;                            

-- 5
SELECT last_name, employee_id
      ,salary + NVL(commission_pct, 0) tot_salary
      ,job_id, e.department_id
  FROM employees e
      ,departments d
WHERE e.department_id = d.department_id
  AND salary + NVL(commission_pct,0) > ( SELECT salary + NVL(commission_pct,0)
                                           FROM employees
                                          WHERE last_name = 'Pataballa')
ORDER BY last_name, employee_id;

-- 6
SELECT department_id, employee_id, last_name, salary
  FROM employees a
 WHERE salary > (SELECT AVG(salary)
                   FROM employees b
                  WHERE a.department_id = b.department_id)
ORDER BY department_id;



SELECT department_id, employee_id, last_name, salary
  FROM employees a
ORDER BY department_id;

SELECT department_id, AVG(salary)
  FROM employees b
 GROUP BY department_id
 ORDER BY 1;



------------------------------------------------------------

-- 세미조인
-- 1. IN 연산자 사용
SELECT *
  FROM employees a
 WHERE a.employee_id IN ( SELECT employee_id
                            FROM job_history )
 ORDER BY 1;
            
-- 2. Exists 연산자 사용                            
SELECT *
  FROM employees a
 WHERE EXISTS ( SELECT 0
                 FROM job_history  b
                WHERE a.employee_id = b.employee_id)
 ORDER BY 1;                                           

-- 안티조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name
  FROM employees a
 WHERE a.employee_id NOT IN ( SELECT employee_id
                                FROM job_history )
 ORDER BY 1;

SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name
  FROM employees a
 WHERE NOT EXISTS ( SELECT 0
                      FROM job_history  b
                     WHERE a.employee_id = b.employee_id)
 ORDER BY 1; 


--------------------------------------------------------------------
-- 다양한 유형의 서브쿼리 

SELECT last_name, employee_id
      ,salary + NVL(commission_pct, 0)
      ,job_id, e.department_id
  FROM employees e
      ,departments d
WHERE e.department_id = d.department_id
  AND salary + NVL(commission_pct,0) > ( SELECT salary + NVL(commission_pct,0)
                                           FROM employees
                                          WHERE last_name = 'Pataballa')
ORDER BY last_name, employee_id;


-- WITH 절
-- 1
WITH dept AS (
SELECT department_id, 
       department_name  dept_name
  FROM departments 
)
SELECT a.employee_id
      ,a.first_name || ' ' || a.last_name
  FROM employees a,
       dept b
 WHERE a.department_id = b.department_id
ORDER BY 1;       

 
-- 2
WITH dept_loc AS (
SELECT a.department_id, a.department_name dept_name,
       b.location_id, b.street_address, 
       b.city, b.country_id
  FROM departments a,
       locations b 
 WHERE a.location_id = b.location_id
),
cont AS (
SELECT b.department_id, b.dept_name, 
       b.street_address, b.city, a.country_name
  FROM countries a,
       dept_loc b
 WHERE a.country_id = b.country_id
)
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       b.dept_name, b.street_address,
       b.country_name
  FROM employees a,
       cont b
 WHERE a.department_id = b.department_id
 ORDER BY 1;       
        

-- 3
WITH emp_info AS (
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       b.department_id, b.department_name dept_name,
       c.street_address, c.city,
       d.country_name, e.region_name
  FROM employees a,
       departments b,
       locations c,
       countries d,
       regions e 
 WHERE a.department_id = b.department_id
   AND b.location_id   = c.location_id
   AND c.country_id    = d.country_id
   AND d.region_id     = e.region_id
)
SELECT *
  FROM emp_info
 ORDER BY 1;   


-- 4
WITH coun_sal AS (
SELECT c.country_id, SUM(a.salary) sal_amt
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id 
   AND b.location_id = c.location_id
GROUP BY c.country_id ),
mains AS (
SELECT b.country_name, a.sal_amt
  FROM coun_sal a,
       countries b
 WHERE a.country_id = b.country_id       
)
SELECT *
  FROM mains
 ORDER BY 1;     
 
-- Top N Query
-- 1 
SELECT *
FROM ( SELECT a.employee_id,
              a.first_name || ' ' || a.last_name emp_name,
              a.salary
         FROM employees a
        ORDER BY a.salary DESC
     ) b
WHERE ROWNUM <= 5; 

-- 2
SELECT *
FROM ( SELECT a.employee_id,
              a.first_name || ' ' || a.last_name emp_name,
              a.salary,
              ROW_NUMBER() OVER (ORDER BY a.salary DESC) ROW_SEQ
         FROM employees a
     ) b
WHERE ROW_SEQ <= 5;

-- 3
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary DESC
 FETCH FIRST 5 ROWS ONLY;
 
 
-- 4
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 FETCH FIRST 5 ROWS ONLY;
 
             
-- 5
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary DESC  
 FETCH FIRST 5 PERCENT ROWS ONLY;
 
 
-- 6
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary   
 FETCH FIRST 5 PERCENT ROWS ONLY;
 
-- 7
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary   
 FETCH FIRST 5 PERCENT ROWS WITH TIES;
 
 
-- SQL 처리과정 
-- 1
WITH coun_sal AS ( /*+ gather_plan_statistics */
SELECT c.country_id, SUM(a.salary) sal_amt
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id 
   AND b.location_id = c.location_id
GROUP BY c.country_id ),
mains AS (
SELECT b.country_name, a.sal_amt
  FROM coun_sal a,
       countries b
 WHERE a.country_id = b.country_id       
)
SELECT *
  FROM mains
 ORDER BY 1;
 
 
-- 2
SELECT /*+ gather_plan_statistics */
       d.country_name, SUM(a.salary) sal_amt
  FROM employees a,
       departments b,
       locations c, 
       countries d
 WHERE a.department_id = b.department_id 
   AND b.location_id = c.location_id
   AND c.country_id = d.country_id
GROUP BY d.country_name
ORDER BY 1;

 
SELECT *
FROM V$SQL 
WHERE sql_text LIKE '%gather%'
;


select *
from table(dbms_xplan.display_cursor ( 'gx8yap8azwk86', null, 'ADVANCED ALLSTATS LAST'));


-- 3
SELECT /*+ gather_plan_statistics */
       -- hong123
       a.employee_id, 
       a.first_name || ' ' || a.last_name emp_name,
       b.department_id, b.department_name dept_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id      
 ORDER BY 1; 
 
SELECT * -- 9f725pnmu4zcq
FROM V$SQL 
WHERE sql_text LIKE '%hong123%'
; 
 
 
select *
from table(dbms_xplan.display_cursor ( '9f725pnmu4zcq', null, 'ADVANCED ALLSTATS LAST'));
 
 
-- 로우를 컬럼으로 
CREATE TABLE score_table (
       YEARS     VARCHAR2(4),   -- 연도
       GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
    SUBJECTS     VARCHAR2(30),  -- 과목
       SCORE     NUMBER );      -- 점수 
       
       
INSERT INTO score_table VALUES('2020','중간고사','국어',92);
INSERT INTO score_table VALUES('2020','중간고사','영어',87);
INSERT INTO score_table VALUES('2020','중간고사','수학',67);
INSERT INTO score_table VALUES('2020','중간고사','과학',80);
INSERT INTO score_table VALUES('2020','중간고사','지리',93);
INSERT INTO score_table VALUES('2020','중간고사','독일어',82);
INSERT INTO score_table VALUES('2020','기말고사','국어',88);
INSERT INTO score_table VALUES('2020','기말고사','영어',80);
INSERT INTO score_table VALUES('2020','기말고사','수학',93);
INSERT INTO score_table VALUES('2020','기말고사','과학',91);
INSERT INTO score_table VALUES('2020','기말고사','지리',89);
INSERT INTO score_table VALUES('2020','기말고사','독일어',83);
COMMIT;       


SELECT *
  FROM score_table;
  
  
SELECT years,
       gubun,
       CASE WHEN subjects = '국어'   THEN score ELSE 0 END "국어",
       CASE WHEN subjects = '영어'   THEN score ELSE 0 END "영어",
       CASE WHEN subjects = '수학'   THEN score ELSE 0 END "수학",
       CASE WHEN subjects = '과학'   THEN score ELSE 0 END "과학",
       CASE WHEN subjects = '지리'   THEN score ELSE 0 END "지리",
       CASE WHEN subjects = '독일어' THEN score ELSE 0 END "독일어"
 FROM score_table a;  
 
 
 
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학,
       SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
 FROM (
       SELECT years, gubun,       
              CASE WHEN subjects = '국어'   THEN score ELSE 0 END "국어",
              CASE WHEN subjects = '영어'   THEN score ELSE 0 END "영어",
              CASE WHEN subjects = '수학'   THEN score ELSE 0 END "수학",
              CASE WHEN subjects = '과학'   THEN score ELSE 0 END "과학",
              CASE WHEN subjects = '지리'   THEN score ELSE 0 END "지리",
              CASE WHEN subjects = '독일어' THEN score ELSE 0 END "독일어"
        FROM score_table a
     )
  GROUP BY years, gubun;
  
  
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학,
       SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
 FROM (
       SELECT years, gubun,       
              DECODE(subjects,'국어',score,0) "국어",
              DECODE(subjects,'영어',score,0) "영어",
              DECODE(subjects,'수학',score,0) "수학",
              DECODE(subjects,'과학',score,0) "과학",
              DECODE(subjects,'지리',score,0) "지리",
              DECODE(subjects,'독일어',score,0) "독일어"
        FROM score_table a
     )
  GROUP BY years, gubun;  
  
  
WITH mains AS ( SELECT years, gubun,
                       CASE WHEN subjects = '국어'   THEN score ELSE 0 END "국어",
                       CASE WHEN subjects = '영어'   THEN score ELSE 0 END "영어",
                       CASE WHEN subjects = '수학'   THEN score ELSE 0 END "수학",
                       CASE WHEN subjects = '과학'   THEN score ELSE 0 END "과학",
                       CASE WHEN subjects = '지리'   THEN score ELSE 0 END "지리",
                       CASE WHEN subjects = '독일어' THEN score ELSE 0 END "독일어"
                  FROM score_table a
               )
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학,
       SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
 FROM mains
GROUP BY years, gubun;  


SELECT *
  FROM ( SELECT years, gubun, subjects, score
          FROM score_table )
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', '과학', '지리', '독일어')
        );
        
-- 컬럼을 로우로 
CREATE TABLE score_col_table  (
    YEARS     VARCHAR2(4),   -- 연도
    GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
    KOREAN    NUMBER,        -- 국어점수
    ENGLISH   NUMBER,        -- 영어점수
    MATH      NUMBER,        -- 수학점수
    SCIENCE   NUMBER,        -- 과학점수
    GEOLOGY   NUMBER,        -- 지리점수
    GERMAN    NUMBER         -- 독일어점수
    );        
    
    
INSERT INTO score_col_table
VALUES ('2020', '중간고사', 92, 87, 67, 80, 93, 82 );

INSERT INTO score_col_table
VALUES ('2020', '기말고사', 88, 80, 93, 91, 89, 83 );

COMMIT;

SELECT *
  FROM score_col_table;
    
    
SELECT YEARS, GUBUN, '국어' AS SUBJECT, KOREAN AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '영어' AS SUBJECT, ENGLISH AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '수학' AS SUBJECT, MATH AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '과학' AS SUBJECT, SCIENCE AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '지리' AS SUBJECT, GEOLOGY AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '독일어' AS SUBJECT, GERMAN AS SCORE
  FROM score_col_table
 ORDER BY 1, 2 DESC;    
 
 
 
SELECT *
  FROM score_col_table
UNPIVOT ( score
            FOR subjects IN ( KOREAN   AS '국어',
                              ENGLISH  AS '영어',
                              MATH     AS '수학',
                              SCIENCE  AS '과학',
                              GEOLOGY  AS '지리',
                              GERMAN   AS '독일어'
                            )
        ); 
        
        
CREATE OR REPLACE TYPE obj_subject AS OBJECT (
      YEARS     VARCHAR2(4),   -- 연도
      GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
      SUBJECTS  VARCHAR2(30),  -- 과목
      SCORE     NUMBER         -- 점수
     );        
     
     
CREATE OR REPLACE TYPE subject_nt IS TABLE OF obj_subject;     



CREATE OR REPLACE FUNCTION fn_pipe_table_ex
  RETURN subject_nt
  PIPELINED
IS

  vp_cur  SYS_REFCURSOR;
  v_cur   score_col_table%ROWTYPE;

  -- 반환할 컬렉션 변수 선언 (컬렉션 타입이므로 초기화를 한다)
  vnt_return  subject_nt :=  subject_nt();
BEGIN
  -- SYS_REFCURSOR 변수로 ch14_score_col_table 테이블을 선택해 커서를 오픈
  OPEN vp_cur FOR SELECT * FROM score_col_table ;

  -- 루프를 돌며 입력 매개변수 vp_cur를 v_cur로 패치
  LOOP
    FETCH vp_cur INTO v_cur;
    EXIT WHEN vp_cur%NOTFOUND;

    -- 컬렉션 타입이므로 EXTEND 메소드를 사용해 한 로우씩 신규 삽입
    vnt_return.EXTEND();
    -- 컬렉션 요소인 OBJECT 타입에 대한 초기화
    vnt_return(vnt_return.LAST) := obj_subject(null, null, null, null);

    -- 컬렉션 변수에 커서 변수의 값 할당
    vnt_return(vnt_return.LAST).YEARS     := v_cur.YEARS;
    vnt_return(vnt_return.LAST).GUBUN     := v_cur.GUBUN;
    vnt_return(vnt_return.LAST).SUBJECTS  := '국어';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.KOREAN;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 국어 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '영어';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.ENGLISH;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 영어 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '수학';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.MATH;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 수학 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '과학';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.SCIENCE;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 과학 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '지리';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.GEOLOGY;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 지리 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '독일어';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.GERMAN;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 독일어 반환

  END LOOP;
  RETURN;
END;


SELECT *
  FROM TABLE ( fn_pipe_table_ex );