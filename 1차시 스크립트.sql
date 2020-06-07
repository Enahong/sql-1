--1-1 
-- 테이블 생성
CREATE TABLE  EMP_TEST (
       emp_no      VARCHAR2(30)  NULL,
       emp_name    VARCHAR2(80)  NULL,
       salary      NUMBER        NULL,
       hire_date   DATE          NULL
);


-- 데이터 입력 
INSERT INTO EMP_TEST VALUES ( NULL, NULL, 10, NULL);

-- 삭제 
TRUNCATE TABLE EMP_TEST;

--emp_no 컬럼을 NOT NULL로 수정 
ALTER TABLE EMP_TEST 
MODIFY emp_no      VARCHAR2(30)  NOT NULL;

--emp_name 컬럼을 NOT NULL, 10자리로 수정 
ALTER TABLE EMP_TEST 
MODIFY emp_name    VARCHAR2(10)  NOT NULL;


-- 데이터 입력 
INSERT INTO EMP_TEST VALUES ( NULL, NULL, 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, NULL, 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, '홍길동', 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, '김유신가나다라마바사', 10, NULL);


--emp_name 컬럼을 NOT NULL, 100자리로 수정 
ALTER TABLE EMP_TEST 
MODIFY emp_name    VARCHAR2(100);


INSERT INTO EMP_TEST VALUES ( 10, '김유신가나다라마바사', 10, NULL);

-- 기본키 추가 
ALTER TABLE EMP_TEST
ADD CONSTRAINTS EMP_TEST_PK PRIMARY KEY (EMP_NO);

-- 데이터 입력 
INSERT INTO EMP_TEST VALUES ( 10, '홍길동', 10, NULL);

INSERT INTO EMP_TEST VALUES ( 20, '홍길동2', 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, '홍길동3', 10, NULL);

INSERT INTO EMP_TEST (emp_no, emp_name, salary )
VALUES ( 30, '김유신', 10);

-- DEFAULT 추가
ALTER TABLE EMP_TEST
MODIFY hire_date   DATE DEFAULT SYSDATE;

INSERT INTO EMP_TEST (emp_no, emp_name, salary )
VALUES ( 40, '김유신2', 10);