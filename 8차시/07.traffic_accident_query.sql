-- traffic accident
-- 연도, 교통수단별 총 사고건수 조회
SELECT YEAR
      ,trans_type
      ,SUM(total_acct_num)   AS 사고건수
      ,SUM(death_person_num) AS 사망자수
FROM traffic_accident
WHERE 1=1
GROUP BY YEAR, trans_type
ORDER BY 1, 2;


SELECT CASE WHEN year BETWEEN 1980 AND 1989 THEN '1980년대'
            WHEN year BETWEEN 1990 AND 1999 THEN '1990년대'
            WHEN year BETWEEN 2000 AND 2009 THEN '2000년대'
            WHEN year BETWEEN 2010 AND 2019 THEN '2010년대'
       END AS YEARS
      ,trans_type
      ,SUM(total_acct_num)   AS 사고건수
      ,SUM(death_person_num) AS 사망자수
FROM traffic_accident
WHERE 1=1
GROUP BY CASE WHEN year BETWEEN 1980 AND 1989 THEN '1980년대'
              WHEN year BETWEEN 1990 AND 1999 THEN '1990년대'
              WHEN year BETWEEN 2000 AND 2009 THEN '2000년대'
              WHEN year BETWEEN 2010 AND 2019 THEN '2010년대'
         END, trans_type
ORDER BY 1, 2;


-- 연도별 추이 분석
-- 연도를 컬럼 형태로 조회
SELECT trans_type
      ,CASE WHEN year BETWEEN 1980 AND 1989 THEN total_acct_num ELSE 0 END "1980년대"
      ,CASE WHEN year BETWEEN 1990 AND 1999 THEN total_acct_num ELSE 0 END "1990년대"
      ,CASE WHEN year BETWEEN 2000 AND 2009 THEN total_acct_num ELSE 0 END "2000년대"
      ,CASE WHEN year BETWEEN 2010 AND 2019 THEN total_acct_num ELSE 0 END "2010년대"
FROM traffic_accident
WHERE 1=1
ORDER BY trans_type;

SELECT trans_type
      ,SUM(CASE WHEN year BETWEEN 1980 AND 1989 THEN total_acct_num ELSE 0 END) "1980년대"
      ,SUM(CASE WHEN year BETWEEN 1990 AND 1999 THEN total_acct_num ELSE 0 END) "1990년대"
      ,SUM(CASE WHEN year BETWEEN 2000 AND 2009 THEN total_acct_num ELSE 0 END) "2000년대"
      ,SUM(CASE WHEN year BETWEEN 2010 AND 2019 THEN total_acct_num ELSE 0 END) "2010년대"
FROM traffic_accident
WHERE 1=1
GROUP BY trans_type
ORDER BY trans_type;

-- 교통수단별 가장 많은 사망자 수가 발생한 연도 구하기
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
      ) B
WHERE a.trans_type       = b.trans_type
  AND a.death_person_num = b.death_per;


