--1-1 
-- ���̺� ����
CREATE TABLE  EMP_TEST (
       emp_no      VARCHAR2(30)  NULL,
       emp_name    VARCHAR2(80)  NULL,
       salary      NUMBER        NULL,
       hire_date   DATE          NULL
);


-- ������ �Է� 
INSERT INTO EMP_TEST VALUES ( NULL, NULL, 10, NULL);

-- ���� 
TRUNCATE TABLE EMP_TEST;

--emp_no �÷��� NOT NULL�� ���� 
ALTER TABLE EMP_TEST 
MODIFY emp_no      VARCHAR2(30)  NOT NULL;

--emp_name �÷��� NOT NULL, 10�ڸ��� ���� 
ALTER TABLE EMP_TEST 
MODIFY emp_name    VARCHAR2(10)  NOT NULL;


-- ������ �Է� 
INSERT INTO EMP_TEST VALUES ( NULL, NULL, 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, NULL, 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, 'ȫ�浿', 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, '�����Ű����ٶ󸶹ٻ�', 10, NULL);


--emp_name �÷��� NOT NULL, 100�ڸ��� ���� 
ALTER TABLE EMP_TEST 
MODIFY emp_name    VARCHAR2(100);


INSERT INTO EMP_TEST VALUES ( 10, '�����Ű����ٶ󸶹ٻ�', 10, NULL);

-- �⺻Ű �߰� 
ALTER TABLE EMP_TEST
ADD CONSTRAINTS EMP_TEST_PK PRIMARY KEY (EMP_NO);

-- ������ �Է� 
INSERT INTO EMP_TEST VALUES ( 10, 'ȫ�浿', 10, NULL);

INSERT INTO EMP_TEST VALUES ( 20, 'ȫ�浿2', 10, NULL);

INSERT INTO EMP_TEST VALUES ( 10, 'ȫ�浿3', 10, NULL);

INSERT INTO EMP_TEST (emp_no, emp_name, salary )
VALUES ( 30, '������', 10);

-- DEFAULT �߰�
ALTER TABLE EMP_TEST
MODIFY hire_date   DATE DEFAULT SYSDATE;

INSERT INTO EMP_TEST (emp_no, emp_name, salary )
VALUES ( 40, '������2', 10);