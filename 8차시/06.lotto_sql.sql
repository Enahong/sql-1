-- lotto
-- 1.중복 번호 조회
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
 

-- 2. 가장 많이 당첨된 번호 조회 
-- NUM1 컬럼 값의 당첨 건수 조회
SELECT num1 lotto_num, COUNT(*) CNT
  FROM lotto_master
 GROUP BY num1
 ORDER BY 2 DESC; 
 
-- num1과 num2 가장 많이 당첨된 번호 - 1
SELECT num1 lotto_num, COUNT(*) CNT
  FROM lotto_master
 GROUP BY num1
 UNION ALL
SELECT num2 lotto_num, COUNT(*) CNT
  FROM lotto_master
 GROUP BY num2
 ORDER BY 1; 
 
-- num1과 num2 가장 많이 당첨된 번호 - 2
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
 
-- 전체 번호 컬럼에 대해 가장 많이 당첨된 번호 조회 
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
 
  
-- 가장 많은 당첨금이 나온 회차와 번호, 금액 조회
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


 