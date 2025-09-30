package kr.or.kosa.dao;

import kr.or.kosa.dto.MemberDTO;

public class MemberDao {
	  // 임시 사용자 데이터
    private MemberDTO[] users = {
        new MemberDTO("admin", "1234", "관리자", "admin"),
        new MemberDTO("user", "1234", "일반사용자", "user")
    };

    public MemberDTO login(String id, String pw) {
        for (MemberDTO user : users) {
            if (user.getId().equals(id) && user.getPw().equals(pw)) {
                return user; // 로그인 성공
            }
        }
        return null; // 로그인 실패
    }
}
