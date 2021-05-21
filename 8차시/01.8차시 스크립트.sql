-- 1. �ζ� �м� 
-- lotto_master ���̺� ���� 
CREATE TABLE lotto_master (
  seq_no       NUMBER NOT NULL, -- �ζ�ȸ�� 
  draw_date    DATE,            -- ��÷��
  num1         NUMBER,          -- ��÷��ȣ1
  num2         NUMBER,          -- ��÷��ȣ2
  num3         NUMBER,          -- ��÷��ȣ3
  num4         NUMBER,          -- ��÷��ȣ4
  num5         NUMBER,          -- ��÷��ȣ5
  num6         NUMBER,          -- ��÷��ȣ6
  bonus        NUMBER           -- ���ʽ���ȣ
 );
 
ALTER TABLE lotto_master
ADD CONSTRAINTS lotto_master_pk PRIMARY KEY (seq_no);
	
-- lotto_detail ���̺� ���� 	
CREATE TABLE lotto_detail (
    seq_no         NUMBER NOT NULL,  -- �ζ�ȸ��
    rank_no        NUMBER NOT NULL,  -- ���
    win_person_no  NUMBER,           -- ��÷�ڼ�
    win_money      NUMBER            -- 1�δ� ��÷�ݾ�
 );
 
ALTER TABLE lotto_detail
ADD CONSTRAINTS lotto_detail_pk PRIMARY KEY (seq_no, rank_no);


SELECT *
  FROM lotto_master
 ORDER BY 1;

SELECT *
  FROM lotto_detail
 ORDER BY 1, 2;


-- 1.�ߺ� ��ȣ ��ȸ
SELECT num1, COUNT(*)
  FROM lotto_master
 GROUP BY num1
 ORDER BY 1;
 
SELECT num1 ,num2 ,num3  ,num4 ,num5 ,num6 , COUNT(*)
  FROM lotto_master
 GROUP BY num1, num2, num3, num4, num5, num6
 ORDER BY 1, 2, 3, 4, 5, 6;
 
SELECT num1 ,num2 ,num3  ,num4 ,num5 ,num6 , COUNT(*)
  FROM lotto_master
 GROUP BY num1, num2, num3, num4, num5, num6
 HAVING COUNT(*) > 1
 ORDER BY 1, 2, 3, 4, 5, 6; 
 

-- 2. ���� ���� ��÷�� ��ȣ ��ȸ 
-- NUM1 �÷� ���� ��÷ �Ǽ� ��ȸ
SELECT num1 lotto_num, COUNT(*) CNT
  FROM lotto_master
 GROUP BY num1
 ORDER BY 2 DESC; 
 
-- num1�� num2 ���� ���� ��÷�� ��ȣ - 1
SELECT num1 lotto_num, COUNT(*) CNT
  FROM lotto_master
 GROUP BY num1
 UNION ALL
SELECT num2 lotto_num, COUNT(*) CNT
  FROM lotto_master
 GROUP BY num2
 ORDER BY 1; 
 
-- num1�� num2 ���� ���� ��÷�� ��ȣ - 2
SELECT lotto_num, SUM(CNT) AS CNT
  FROM ( SELECT num1 lotto_num, COUNT(*) CNT
           FROM lotto_master
          GROUP BY num1
          UNION ALL
         SELECT num2 lotto_num, COUNT(*) CNT
           FROM lotto_master
          GROUP BY num2
       )
GROUP BY lotto_num
ORDER BY 2 DESC;        
 
-- ��ü ��ȣ �÷��� ���� ���� ���� ��÷�� ��ȣ ��ȸ 
SELECT lotto_num, SUM(CNT) AS CNT
  FROM ( SELECT num1 lotto_num, COUNT(*) CNT
           FROM lotto_master
          GROUP BY num1
          UNION ALL
         SELECT num2 lotto_num, COUNT(*) CNT
           FROM lotto_master
          GROUP BY num2
         UNION ALL
         SELECT num3 lotto_num, COUNT(*) CNT
           FROM lotto_master
          GROUP BY num3
         UNION ALL
         SELECT num4 lotto_num, COUNT(*) CNT
           FROM lotto_master
          GROUP BY num4
         UNION ALL
         SELECT num5 lotto_num, COUNT(*) CNT
           FROM lotto_master  
          GROUP BY num5
         UNION ALL
         SELECT num6 lotto_num, COUNT(*) CNT
           FROM lotto_master  
          GROUP BY num6
       )
 GROUP BY lotto_num      
 ORDER BY 2 DESC;  
 
  
-- ���� ���� ��÷���� ���� ȸ���� ��ȣ, �ݾ� ��ȸ
SELECT a.seq_no
      ,a.draw_date
      ,b.win_person_no
      ,b.win_money
      ,a.num1 ,a.num2 ,a.num3
      ,a.num4 ,a.num5 ,a.num6 ,a.bonus
  FROM lotto_master a
      ,lotto_detail b
 WHERE a.seq_no = b.seq_no
   AND b.rank_no = 1
 ORDER BY b.win_money DESC;

-- 2. ������ �м� 

-- ������
CREATE TABLE traffic_accident (
    year              NUMBER       NOT NULL,  -- ����
    trans_type        VARCHAR2(30) NOT NULL,  -- �������
    total_acct_num    NUMBER,                 -- ���߻��Ǽ�
    death_person_num  NUMBER                  -- ����ڼ�   
);

ALTER TABLE traffic_accident
ADD CONSTRAINTS traffic_accident_pk PRIMARY KEY (year, trans_type);



SELECT *
  FROM traffic_accident;


-- (1) ����, ������ܺ� �� ���Ǽ� ��ȸ
SELECT YEAR
      ,trans_type
      ,SUM(total_acct_num)   AS ���Ǽ�
      ,SUM(death_person_num) AS ����ڼ�
FROM traffic_accident
WHERE 1=1
GROUP BY YEAR, trans_type
ORDER BY 1, 2;


SELECT CASE WHEN year BETWEEN 1980 AND 1989 THEN '1980���'
            WHEN year BETWEEN 1990 AND 1999 THEN '1990���'
            WHEN year BETWEEN 2000 AND 2009 THEN '2000���'
            WHEN year BETWEEN 2010 AND 2019 THEN '2010���'
      END AS YEARS
      ,trans_type
      ,SUM(total_acct_num)   AS ���Ǽ�
FROM traffic_accident
WHERE 1=1
GROUP BY CASE WHEN year BETWEEN 1980 AND 1989 THEN '1980���'
              WHEN year BETWEEN 1990 AND 1999 THEN '1990���'
              WHEN year BETWEEN 2000 AND 2009 THEN '2000���'
              WHEN year BETWEEN 2010 AND 2019 THEN '2010���'
         END, trans_type
ORDER BY 1, 2;


-- (2) ���뺰 ������ ���� �м�
SELECT trans_type
      ,CASE WHEN year BETWEEN 1980 AND 1989 THEN total_acct_num ELSE 0 END "1980���"
      ,CASE WHEN year BETWEEN 1990 AND 1999 THEN total_acct_num ELSE 0 END "1990���"
      ,CASE WHEN year BETWEEN 2000 AND 2009 THEN total_acct_num ELSE 0 END "2000���"
      ,CASE WHEN year BETWEEN 2010 AND 2019 THEN total_acct_num ELSE 0 END "2010���"
FROM traffic_accident
WHERE 1=1
ORDER BY trans_type;


SELECT trans_type
      ,SUM(CASE WHEN year BETWEEN 1980 AND 1989 THEN total_acct_num ELSE 0 END) "1980���"
      ,SUM(CASE WHEN year BETWEEN 1990 AND 1999 THEN total_acct_num ELSE 0 END) "1990���"
      ,SUM(CASE WHEN year BETWEEN 2000 AND 2009 THEN total_acct_num ELSE 0 END) "2000���"
      ,SUM(CASE WHEN year BETWEEN 2010 AND 2019 THEN total_acct_num ELSE 0 END) "2010���"
FROM traffic_accident
WHERE 1=1
GROUP BY trans_type
ORDER BY trans_type;


-- (3) ������ܺ� ���� ���� ����� ���� �߻��� ���� ���ϱ�
SELECT trans_type
      ,MAX(death_person_num) death_per
  FROM traffic_accident
 GROUP BY trans_type;


SELECT a.*
 FROM traffic_accident a
    ,( SELECT trans_type
             ,MAX(death_person_num) death_per
         FROM traffic_accident
        GROUP BY trans_type
     ) b
WHERE a.trans_type       = b.trans_type
  AND a.death_person_num = b.death_per;


-- 3. Ÿ��Ÿ�� �м� 
CREATE TABLE titanic2 AS
SELECT passengerid
      ,CASE WHEN survived = 0 THEN '���' ELSE '����' end survived
      ,TO_CHAR(pclass) || '���' pclass  ,name
      ,DECODE(sex, 'male','����', 'female','����', '����') gender
      ,age, sibsp ,parch  ,ticket ,fare  ,cabin
      ,CASE embarked WHEN 'C' THEN '������-�θ��θ�'
                     WHEN 'Q' THEN '���Ϸ���-����Ÿ��'
                     WHEN 'S' THEN '����-��������'
                     ELSE ''
      END embarked
FROM titanic
ORDER BY 1;


-- (1-1) ���� ����/����� �� 
SELECT gender, survived, COUNT(*) cnt
  FROM titanic2
 GROUP BY gender, survived
 ORDER BY 1, 2;

-- (1-2) ���� ����/����� ���� ����
SELECT gender, survived, cnt, 
              ROUND(cnt / SUM(cnt) OVER ( PARTITION BY gender ORDER BY gender),2) ����
  FROM ( SELECT gender, survived, count(*) cnt
           FROM titanic2
          GROUP BY gender, survived
       ) t ;


--(2-1) ��޺� ����/����� �� 

SELECT pclass, survived, COUNT(*) cnt
  FROM titanic2
 GROUP BY pclass, survived
 ORDER BY 1, 2;

-- (2-2) ��޺� ����/����� ���� ����

SELECT pclass, survived, cnt, 
       ROUND(cnt / SUM(cnt) OVER ( PARTITION BY pclass ORDER BY pclass),2) ����
  FROM ( SELECT pclass, survived, count(*) cnt
           FROM titanic2
          GROUP BY pclass, survived
       ) t ;
       
       
-- (3) ���ɴ뺰 ����/����� �� 
SELECT CASE WHEN age BETWEEN 1  AND 9 THEN '(1)10�� ����'
            WHEN age BETWEEN 10 AND 19 THEN '(2)10��'
            WHEN age BETWEEN 20 AND 29 THEN '(3)20��'
            WHEN age BETWEEN 30 AND 39 THEN '(4)30��'
            WHEN age BETWEEN 40 AND 49 THEN '(5)40��'
            WHEN age BETWEEN 50 AND 59 THEN '(6)50��'
            WHEN age BETWEEN 60 AND 69 THEN '(7)60��'
            ELSE '(8)70�� �̻�'
        END ages 
       ,survived, COUNT(*)
  FROM titanic2
 GROUP BY CASE WHEN age BETWEEN 1  AND 9 THEN '(1)10�� ����'
               WHEN age BETWEEN 10 AND 19 THEN '(2)10��'
               WHEN age BETWEEN 20 AND 29 THEN '(3)20��'
               WHEN age BETWEEN 30 AND 39 THEN '(4)30��'
               WHEN age BETWEEN 40 AND 49 THEN '(5)40��'
               WHEN age BETWEEN 50 AND 59 THEN '(6)50��'
               WHEN age BETWEEN 60 AND 69 THEN '(7)60��'
               ELSE '(8)70�� �̻�'
           END
          ,survived
ORDER BY 1,2; 


SELECT age
  FROM titanic2
 ORDER BY 1 DESC;

SELECT age
  FROM titanic2
 ORDER BY 1;


SELECT CASE WHEN age BETWEEN 0  AND 9  THEN '(1)10�� ����'
            WHEN age BETWEEN 10 AND 19 THEN '(2)10��'
            WHEN age BETWEEN 20 AND 29 THEN '(3)20��'
            WHEN age BETWEEN 30 AND 39 THEN '(4)30��'
            WHEN age BETWEEN 40 AND 49 THEN '(5)40��'
            WHEN age BETWEEN 50 AND 59 THEN '(6)50��'
            WHEN age BETWEEN 60 AND 69 THEN '(7)60��'
            ELSE '(8)70�� �̻�'
        END ages 
       ,survived, COUNT(*)
  FROM titanic2
 WHERE age IS NOT NULL -- NULL ����  
 GROUP BY CASE WHEN age BETWEEN 1  AND 9  THEN '(1)10�� ����'
               WHEN age BETWEEN 10 AND 19 THEN '(2)10��'
               WHEN age BETWEEN 20 AND 29 THEN '(3)20��'
               WHEN age BETWEEN 30 AND 39 THEN '(4)30��'
               WHEN age BETWEEN 40 AND 49 THEN '(5)40��'
               WHEN age BETWEEN 50 AND 59 THEN '(6)50��'
               WHEN age BETWEEN 60 AND 69 THEN '(7)60��'
               ELSE '(8)70�� �̻�'
           END
          ,survived
ORDER BY 1,2; 



SELECT CASE WHEN age BETWEEN 0  AND 9  THEN '(1)10�� ����'
            WHEN age BETWEEN 10 AND 19 THEN '(2)10��'
            WHEN age BETWEEN 20 AND 29 THEN '(3)20��'
            WHEN age BETWEEN 30 AND 39 THEN '(4)30��'
            WHEN age BETWEEN 40 AND 49 THEN '(5)40��'
            WHEN age BETWEEN 50 AND 59 THEN '(6)50��'
            WHEN age BETWEEN 60 AND 69 THEN '(7)60��'
            WHEN age >= 70             THEN '(8)70�� �̻�'
            ELSE '(9)�˼�����'
        END ages 
       ,survived, COUNT(*)
  FROM titanic2
 GROUP BY CASE WHEN age BETWEEN 1  AND 9  THEN '(1)10�� ����'
               WHEN age BETWEEN 10 AND 19 THEN '(2)10��'
               WHEN age BETWEEN 20 AND 29 THEN '(3)20��'
               WHEN age BETWEEN 30 AND 39 THEN '(4)30��'
               WHEN age BETWEEN 40 AND 49 THEN '(5)40��'
               WHEN age BETWEEN 50 AND 59 THEN '(6)50��'
               WHEN age BETWEEN 60 AND 69 THEN '(7)60��'
               WHEN age >= 70             THEN '(8)70�� �̻�'
               ELSE '(9)�˼�����'
           END
          ,survived
ORDER BY 1,2; 


-- (5) ����,����� ���� �θ��ڽļ��� ����/����� ��

SELECT sibsp, parch, survived, count(*)
  FROM titanic2
 GROUP BY sibsp, parch, survived
 ORDER BY 1, 2, 3;
 
-- titanic Graph Query
SELECT gender, survived, COUNT(*) cnt
  FROM titanic2
 GROUP BY gender, survived;


SELECT pclass, survived, count(*)
  FROM titanic2
GROUP BY pclass, survived
ORDER BY pclass, survived;


SELECT sibsp, survived, count(*)
  FROM titanic2
 GROUP BY sibsp, survived
 ORDER BY 1, 2;
 
 
SELECT parch, survived, count(*)
  FROM titanic2
 GROUP BY parch, survived
 ORDER BY 1, 2;


-- �����ͺм� �ð�ȭ2
-- covid19_country ���̺� ����
CREATE TABLE covid19_country (
  countrycode                 VARCHAR2(10) NOT NULL, 
  countryname                 VARCHAR2(80) NOT NULL, 
  continent                   VARCHAR2(50), 
  population                  NUMBER,
  population_density          NUMBER,
  median_age                  NUMBER,
  aged_65_older               NUMBER,
  aged_70_older               NUMBER,
  hospital_beds_per_thousand  NUMBER,
  PRIMARY KEY (countrycode)    
);

-- covid19_data ���̺� ����
CREATE TABLE covid19_data (
  countrycode                 VARCHAR2(10) NOT NULL, 
  issue_date                  DATE        NOT NULL,  
  cases                       NUMBER, 
  new_cases_per_million       NUMBER, 
  deaths                      NUMBER, 
  icu_patients                NUMBER, 
  hosp_patients               NUMBER, 
  tests                       NUMBER, 
  reproduction_rate           NUMBER, 
  new_vaccinations            NUMBER, 
  stringency_index            NUMBER,
  PRIMARY KEY (countrycode, issue_date)   
);

-- covid19_data ���̺��� countrycode ���� OWID�� ���۵Ǵ� ������ ����
SELECT countrycode, COUNT(*)
  FROM covid19_data
 WHERE countrycode LIKE 'OWID%' 
 GROUP BY countrycode ;


DELETE covid19_data
 WHERE countrycode LIKE 'OWID%' ;

 SELECT COUNT(*)
   FROM covid19_data
  WHERE countrycode LIKE 'OWID%' ;

COMMIT;

-- covid19_data ���̺��� ������ �÷� NULL�� 0���� ����
UPDATE covid19_data
   SET cases = 0
 WHERE cases IS NULL;


UPDATE covid19_data
   SET cases                 = NVL(cases, 0)
      ,new_cases_per_million = NVL(new_cases_per_million, 0)
      ,deaths                = NVL(deaths, 0)
      ,icu_patients          = NVL(icu_patients, 0)
      ,hosp_patients         = NVL(hosp_patients, 0)
      ,tests                 = NVL(tests, 0)
      ,reproduction_rate     = NVL(reproduction_rate, 0)
      ,new_vaccinations      = NVL(new_vaccinations, 0)
      ,stringency_index      = NVL(stringency_index, 0);
      
COMMIT;      

-- 1.2020�� ����, �����, ������ ������
SELECT TO_CHAR(b.issue_date, 'YYYYMM') months,
       a.continent, a.countryname, 
       SUM(b.cases) ������ 
  FROM covid19_country a
 INNER JOIN covid19_data b
    ON a.countrycode = b.countrycode
 WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
 GROUP BY TO_CHAR(b.issue_date, 'YYYYMM'),
          a.continent, a.countryname
 ORDER BY 1, 2, 3; 


-- 2-1.2020�� ����, �����, ������ ������, ������� ������ ���� 
WITH covid1 AS (
SELECT TO_CHAR(b.issue_date, 'YYYYMM') months,
       a.continent, a.countryname, 
       SUM(b.cases) case_num       
  FROM covid19_country a
 INNER JOIN covid19_data b
    ON a.countrycode = b.countrycode
 WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
 GROUP BY TO_CHAR(b.issue_date, 'YYYYMM'),
          a.continent, a.countryname
),
covid2 AS (
SELECT months, continent, countryname, 
       case_num,
       SUM(case_num) OVER (PARTITION BY months, continent) tot
  FROM covid1
)
SELECT months, continent, countryname, 
       case_num, tot, 
       DECODE(tot, 0, 0, ROUND(case_num / tot * 100,2)) rates
  FROM covid2 ;
  
-- 2-2.2020�� ����, �����, ������ ������, ������� ������ ����   
WITH covid1 AS (
SELECT TO_CHAR(b.issue_date, 'YYYYMM') months,
       a.continent, a.countryname, 
       SUM(b.cases) case_num       
  FROM covid19_country a
 INNER JOIN covid19_data b
    ON a.countrycode = b.countrycode
 WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
 GROUP BY TO_CHAR(b.issue_date, 'YYYYMM'),
          a.continent, a.countryname
)
SELECT months, continent, countryname, 
       case_num,
       ROUND(RATIO_TO_REPORT(case_num) OVER (PARTITION BY months, continent) * 100,2) rates
  FROM covid1
 ORDER BY 1, 2, 3;


-- 3.2020�� �ѱ��� ���� �˻� ��, Ȯ���� ��, Ȯ����
SELECT TO_CHAR(issue_date, 'MM') months,
       SUM(tests) �˻��,
       SUM(cases) Ȯ���ڼ�,
       CASE WHEN SUM(tests) = 0 THEN 0
            ELSE ROUND(SUM(cases) /SUM(tests) * 100,2) 
       END Ȯ����
  FROM covid19_data
 WHERE countrycode = 'KOR'
   AND TO_CHAR(issue_date, 'YYYY') = '2020'
 GROUP BY TO_CHAR(issue_date, 'MM')
 ORDER BY 1;


-- 4-1.2020�� ���� ���� Ȯ���ڰ� ���� ���� 5�� ���� ����
SELECT countryname, case_num
  FROM ( SELECT a.countryname, 
                SUM(b.cases) case_num
           FROM covid19_country a
          INNER JOIN covid19_data b
             ON a.countrycode = b.countrycode
          WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
          GROUP BY a.countryname
          ORDER BY 2 DESC )
 WHERE ROWNUM <= 5
 ORDER BY 2 DESC;         
 
 
-- 4-2.2020�� ���� ���� Ȯ���ڰ� ���� ���� 5�� ���� ����
SELECT countryname, case_num, seq
  FROM ( SELECT a.countryname, 
                SUM(b.cases) case_num,
                ROW_NUMBER() OVER (ORDER BY SUM(b.cases) DESC ) seq
           FROM covid19_country a
          INNER JOIN covid19_data b
             ON a.countrycode = b.countrycode
          WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
          GROUP BY a.countryname
       )
 WHERE seq <= 5
 ORDER BY 3;
 
-- 4-3.2020�� ���� ���� Ȯ���ڰ� ���� ���� 5�� ���� ���� 
SELECT countryname, case_num
  FROM ( SELECT a.countryname, 
                SUM(b.cases) case_num
           FROM covid19_country a
          INNER JOIN covid19_data b
             ON a.countrycode = b.countrycode
          WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
          GROUP BY a.countryname
        )
 ORDER BY 2 DESC
 FETCH FIRST 5 ROWS ONLY;
 
-- 5. 2020�� �α� ��� ������� ���� 20�� ������?
SELECT *
  FROM ( SELECT a.countryname, 
                MAX(a.population) popu,
                SUM(b.deaths) death_num,
                ROUND(DECODE(MAX(a.population),0,0, SUM(b.deaths) / MAX(a.population))*100,4) death_rate
           FROM covid19_country a
          INNER JOIN covid19_data b
             ON a.countrycode = b.countrycode
          WHERE TO_CHAR(b.issue_date, 'YYYY') = '2020'
          GROUP BY a.countryname
          ORDER BY 4 DESC 
       )
 WHERE ROWNUM <= 20 ;
 
-- 6. 2020�� ������ Ȯ���ڿ� ������� ���� ����
CREATE OR REPLACE VIEW covid19_mon_v AS
WITH covid AS (
SELECT b.countryname,
       TO_CHAR(a.issue_date, 'MM') months,
       SUM(a.cases) case_num,
       SUM(a.deaths) death_num
  FROM covid19_data a
 INNER JOIN covid19_country b
    ON a.countrycode = b.countrycode
 GROUP BY b.countryname, TO_CHAR(a.issue_date, 'MM')
)
SELECT countryname, 
       '1.Ȯ��' gubun,
       SUM(CASE WHEN months = 01 THEN case_num ELSE 0 END) "01",
       SUM(CASE WHEN months = 02 THEN case_num ELSE 0 END) "02",
       SUM(CASE WHEN months = 03 THEN case_num ELSE 0 END) "03",
       SUM(CASE WHEN months = 04 THEN case_num ELSE 0 END) "04",
       SUM(CASE WHEN months = 05 THEN case_num ELSE 0 END) "05",
       SUM(CASE WHEN months = 06 THEN case_num ELSE 0 END) "06",
       SUM(CASE WHEN months = 07 THEN case_num ELSE 0 END) "07",
       SUM(CASE WHEN months = 08 THEN case_num ELSE 0 END) "08",
       SUM(CASE WHEN months = 09 THEN case_num ELSE 0 END) "09",
       SUM(CASE WHEN months = 10 THEN case_num ELSE 0 END) "10",
       SUM(CASE WHEN months = 11 THEN case_num ELSE 0 END) "11",
       SUM(CASE WHEN months = 12 THEN case_num ELSE 0 END) "12"
  FROM covid
 GROUP BY countryname
 UNION ALL
SELECT countryname, 
       '2.���' gubun,
       SUM(CASE WHEN months = 01 THEN death_num ELSE 0 END) "01",
       SUM(CASE WHEN months = 02 THEN death_num ELSE 0 END) "02",
       SUM(CASE WHEN months = 03 THEN death_num ELSE 0 END) "03",
       SUM(CASE WHEN months = 04 THEN death_num ELSE 0 END) "04",
       SUM(CASE WHEN months = 05 THEN death_num ELSE 0 END) "05",
       SUM(CASE WHEN months = 06 THEN death_num ELSE 0 END) "06",
       SUM(CASE WHEN months = 07 THEN death_num ELSE 0 END) "07",
       SUM(CASE WHEN months = 08 THEN death_num ELSE 0 END) "08",
       SUM(CASE WHEN months = 09 THEN death_num ELSE 0 END) "09",
       SUM(CASE WHEN months = 10 THEN death_num ELSE 0 END) "10",
       SUM(CASE WHEN months = 11 THEN death_num ELSE 0 END) "11",
       SUM(CASE WHEN months = 12 THEN death_num ELSE 0 END) "12"
  FROM covid 
 GROUP BY countryname
 ORDER BY 1, 2 ;
 
 
SELECT *
FROM covid19_mon_v;
 
 
 
-- �ð�ȭ query 
-- 1. �� �Ⱓ ���� ���� ����ڸ� �� ���� 10�� ���� ��Ȳ ��ȸ
%sql
SELECT *
  FROM ( SELECT b.countryname,
                SUM(a.deaths) death_num
           FROM covid19_data a
          INNER JOIN covid19_country b
             ON a.countrycode = b.countrycode
          GROUP BY b.countryname
          ORDER BY 2 DESC
       )
 WHERE ROWNUM <= 10
 
-- 2. �� �Ⱓ ����� ���� 10�� ������ Ȯ���ڿ� ����� ��Ȳ ��ȸ
%sql
SELECT *
  FROM ( SELECT b.countryname,
                SUM(a.deaths) death_num,
                SUM(a.cases) case_num
           FROM covid19_data a
          INNER JOIN covid19_country b
             ON a.countrycode = b.countrycode
          GROUP BY b.countryname
          ORDER BY 2 DESC
       )
 WHERE ROWNUM <= 10
 
 
-- 3. �ѱ��� ���� Ȯ���� ��Ȳ
%sql
SELECT TO_CHAR(issue_date, 'YYYY-MM') months,
       SUM(cases) Ȯ���ڼ�
  FROM covid19_data
 WHERE countrycode = 'KOR'
 GROUP BY TO_CHAR(issue_date, 'YYYY-MM')
 ORDER BY 1
 
 
-- 4.����� ���� 5�� ������ ���� ����� ��Ȳ
%sql
WITH covid1 AS (
SELECT a.countrycode, 
       SUM(a.deaths) death_num
  FROM covid19_data a
 GROUP BY a.countrycode
 ORDER BY 2 DESC
),
covid2 AS (
SELECT *
  FROM covid1
 WHERE ROWNUM <= 5 )
SELECT b.countryname,
       TO_CHAR(a.issue_date, 'YYYY-MM') months,
       SUM(a.deaths) death_num
  FROM covid19_data a
 INNER JOIN covid19_country b
    ON a.countrycode = b.countrycode
 WHERE EXISTS ( SELECT 1
                  FROM covid2 c
                 WHERE a.countrycode = c.countrycode)
 GROUP BY b.countryname, TO_CHAR(a.issue_date, 'YYYY-MM')
 ORDER BY 2
 
 
-- ETC
SELECT b.countryname,
       SUM(a.cases) cases_num
  FROM covid19_data a
 INNER JOIN covid19_country b
    ON a.countrycode = b.countrycode
 GROUP BY b.countryname;
 
 
 








 
