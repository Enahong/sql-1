CREATE OR REPLACE PROCEDURE create_dept_p ( p_dept_id NUMBER,
                                            p_dept_nm VARCHAR2,
                                            p_man_id  NUMBER,
                                            p_loc_id  NUMBER )
IS
  v_cnt  NUMBER;
BEGIN
    -- 부서번호 체크 
    SELECT COUNT(*)
      INTO v_cnt
      FROM departments
     WHERE department_id = p_dept_id;
     
    -- v_cnt가 0보다 크면 이미 존재하는 부서임 
    IF v_cnt > 0 THEN
       RAISE_APPLICATION_ERROR (-20201, p_dept_id || '번 부서가 이미 존재합니다');
       RETURN; -- 프로시저에서 return 만나면 이후 로직 수행 안하고 빠져나감 
    END IF;
    
    -- 부서정보 입력 
	INSERT INTO departments (department_id, department_name, manager_id, location_id)
	VALUES ( p_dept_id, p_dept_nm, p_man_id, p_loc_id );
	
	COMMIT;
	
EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR (-20205, SQLERRM);
  ROLLBACK;
END; 