package kr.or.kosa.service;

import java.util.List;

import kr.or.kosa.dao.EmpDao;
import kr.or.kosa.dto.EmpDto;


/**
 * Dao에서 try-catch로 다 처리해서 생략함
 */
public class EmpService {
	private EmpDao empDao;
	
	//생성자...
	public EmpService() { //주입받고 싶은데...
		empDao = new EmpDao(); 
	}
	
	public int createEmp(EmpDto dto) { // 사원 등록
		int resultRow = empDao.insertEmp(dto); //Dao에서 try-catch로 다 처리했음
		
		if(resultRow > 0) { // 정상 수행
			System.out.println("[createEmp] 정상 수행");
		}else {
			System.out.println("[createEmp] create 실패");
		}
		
		return resultRow;
	}
	
	//조건조회 empno로 1건의 사원을 조회함 //empno가 고유데이터 전제(유니크)
	public EmpDto readEmpByEmpno(int empno) { 
		//사번으로 사원 1건 조회
		EmpDto empDto = empDao.getEmpByEmpno(empno);
		
		if(empDto != null) { // 정상수행
			System.out.println("[readEmpByEmpno] 정상수행");
		}else {
			System.out.println("실패 - 조회 결과가 없거나..");
		}
		return empDto;
	}
	
	public List<EmpDto> readEmpAllList() { 
		//전체 사원 조회
		List<EmpDto> empList = empDao.getEmpAllList();
		
		if(empList != null) {
			System.out.println("[readEmpAllList] 정상수행");
			//확인해봄 - 디버깅위해
			System.out.println("[readEmpAllList 결과] : " + empList.toString());
		}else {
			System.out.println("실패 - 테이블에 데이터 아예 없거나..");
		}
		
		return empList;
	}
	
	public int updateEmp(EmpDto dto) { // 사원 정보 수정
		int resultRow = empDao.updateEmp(dto);
		if(resultRow > 0) { // 정상 수행
			System.out.println("[updateEmp] 정상 수행");
		}else {
			System.out.println("[updateEmp] update 실패");
		}
		
		return resultRow;
	}
	
	public int deleteEmpByEmpno(int empno) { // 사번으로 사원 삭제
		int resultRow = empDao.deleteEmp(empno);
		if(resultRow > 0) { // 정상 수행
			System.out.println("[deleteEmpByEmpno] 정상 수행");
		}else {
			System.out.println("[deleteEmpByEmpno] delete 실패");
		}
		return resultRow;
	}
	
}
