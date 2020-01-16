CREATE OR REPLACE PROCEDURE create_dept_p ( p_dept_id NUMBER,
                                            p_dept_nm VARCHAR2,
                                            p_man_id  NUMBER,
                                            p_loc_id  NUMBER )
IS
  v_cnt  NUMBER;
BEGIN
    -- �μ���ȣ üũ 
    SELECT COUNT(*)
      INTO v_cnt
      FROM departments
     WHERE department_id = p_dept_id;
     
    -- v_cnt�� 0���� ũ�� �̹� �����ϴ� �μ��� 
    IF v_cnt > 0 THEN
       RAISE_APPLICATION_ERROR (-20201, p_dept_id || '�� �μ��� �̹� �����մϴ�');
       RETURN; -- ���ν������� return ������ ���� ���� ���� ���ϰ� �������� 
    END IF;
    
    -- �μ����� �Է� 
	INSERT INTO departments (department_id, department_name, manager_id, location_id)
	VALUES ( p_dept_id, p_dept_nm, p_man_id, p_loc_id );
	
	COMMIT;
	
EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR (-20205, SQLERRM);
  ROLLBACK;
END; 