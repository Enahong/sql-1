-- 로또 
CREATE TABLE lotto_master (
  seq_no       NUMBER NOT NULL, -- 로또회차 
  draw_date    DATE,            -- 추첨일
  num1         NUMBER,          -- 당첨번호1
  num2         NUMBER,          -- 당첨번호2
  num3         NUMBER,          -- 당첨번호3
  num4         NUMBER,          -- 당첨번호4
  num5         NUMBER,          -- 당첨번호5
  num6         NUMBER,          -- 당첨번호6
  bonus        NUMBER           -- 보너스번호
 );
 
ALTER TABLE lotto_master
ADD CONSTRAINTS lotto_master_pk PRIMARY KEY (seq_no);
	
CREATE TABLE lotto_detail (
    seq_no         NUMBER NOT NULL,  -- 로또회차
    rank_no        NUMBER NOT NULL,  -- 등수
    win_person_no  NUMBER,           -- 당첨자수
    win_money      NUMBER            -- 1인당 당첨금액
 );
 
ALTER TABLE lotto_detail
ADD CONSTRAINTS lotto_detail_pk PRIMARY KEY (seq_no, rank_no);

 
-- 교통사고
CREATE TABLE traffic_accident (
    year              NUMBER       NOT NULL,  -- 연도
    trans_type        VARCHAR2(30) NOT NULL,  -- 교통수단
    total_acct_num    NUMBER,                 -- 사고발생건수
    death_person_num  NUMBER                  -- 사망자수   
);

ALTER TABLE traffic_accident
ADD CONSTRAINTS traffic_accident_pk PRIMARY KEY (year, trans_type);


-- 미세먼지 
CREATE TABLE fine_dust (
    gu_name           VARCHAR2(50) NOT NULL,  -- 구 명
    mea_station       VARCHAR2(30) NOT NULL,  -- 측정소
    mea_date          DATE         NOT NULL,  -- 측정일자
    pm10              NUMBER,                 -- 미세먼지농도
    pm25              NUMBER                  -- 초미세먼지농도
);

ALTER TABLE fine_dust
ADD CONSTRAINTS fine_dust_pk PRIMARY KEY (gu_name, mea_station, mea_date);


CREATE TABLE fine_dust_standard (
    org_name          VARCHAR2(50) NOT NULL,  -- 기관명
    std_name          VARCHAR2(30) NOT NULL,  -- 미세먼지 기준
    pm10_start        NUMBER,                 -- 미세먼지농도(시작)
    pm10_end          NUMBER,                 -- 미세먼지농도(끝)
    pm25_start        NUMBER,                 -- 초미세먼지농도(시작)
    pm25_end          NUMBER                  -- 초미세먼지농도  (끝)  
);

ALTER TABLE fine_dust_standard
ADD CONSTRAINTS fine_dust_standard_pk PRIMARY KEY (org_name, std_name);

