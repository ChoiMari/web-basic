package kr.or.kosa.action;

import lombok.Getter;
import lombok.Setter;

/*
 * 클라이언트가 서버에게 요청하는 작업은 2가지
 * 1.화면보여줘, 2.처리해줘
 * 
 * 화면을 주거나, 비지니스 로직을 처리해서 결과 응답하거나 2가지
 * 

 * 
 */
@Getter @Setter
public class ActionForward {
	private boolean isRedirect = false; // 뷰의 전환 여부를 결정
	private String path = null;//이동 경로의 주소 관리(forward시킬 경로)
	
}
