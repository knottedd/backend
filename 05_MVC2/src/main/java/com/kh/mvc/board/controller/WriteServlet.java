package com.kh.mvc.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.common.util.FileRename;
import com.kh.mvc.mamber.model.service.MemberService;
import com.kh.mvc.mamber.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/board/write")
public class WriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public WriteServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
    	Member loginMember = (session == null) ? null : (Member) session.getAttribute("loginMember");
	
    	if (loginMember != null) {
    		request.getRequestDispatcher("/views/board/write.jsp").forward(request, response);
    	} else {
    		request.setAttribute("msg", "로그인 후 사용할 수 있습니다.");
			request.setAttribute("location", "/");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
			
    	}
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// cos.jar가 라이브러리에 들어가 있음으로 파일 업로드를 담당해주는 클래스를 간편하게 사용 가능하다.
    	// 해당 과정을 통해 게시판에서 파일 업로드를 하면 프로젝트 안에 upload/board 폴더 안으로 해당 파일이 들어간다.
    	int result = 0;
    	Board board = null;
    	
    	// 파일이 저장될 경로
    	String path = getServletContext().getRealPath("/resources/upload/board");
    	
    	// 파일의 사이즈 지정 (10MB = 10485760byte)
    	int maxSize = 10485760;
    	
    	// 인코딩 설정
    	String encoding = "UTF-8";
    	
    	// 파일 업로드 객체에 request, 지정해준 경로, 지정해준 사이즈, 지정해준 인코딩, renamepolicy 순으로 넣어준다.
    	// 여기서 new DefaultFileRenamePolicy()는 동일한 파일 이름이 업로드 될 때 이름 뒤에 1 ~ 9999 를 붙혀 자동으로 변경한다.
    	// FileRenamePolicy 인터페이스를 사용하여 common/util 쪽에 FileRename 클래스를 생성해
    	// 원하는 FileRename 규칙에 맞춰 새로 객체화 시킨 후 저장 가능
    	// 새로 재정의 한 FileRename 규칙으로 인해 클라이언트가 파일을 업로드 할 시 자동으로 날짜와 시간 랜덤값을 부여해 서버에 저장한다.
    	MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
    	
    	
    	// 폼 파라미터로 넘어온 값들 (파일에 대한 정보 X)
    	// MultipartRequest 안에 request가 매개 값으로 있기때 문에 생성 후 파라미터를 가져 올땐 MultipartRequest를 사용하면 된다.
    	String title = mr.getParameter("title");
    	String writer = mr.getParameter("writer");
    	String content = mr.getParameter("content");
    	
    	// 파일에 대한 정보를 가져올 때
    	// 실제로 서버에 저장된 이름
    	String filesystemName = mr.getFilesystemName("upfile");
    	// 사용자가 브라우저에서 선택한 이름
    	String originalFileName = mr.getOriginalFileName("upfile");
    	
    	HttpSession session = request.getSession(false);
    	Member loginMember = (session == null) ? null : (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		board = new Board();
    		
    		board.setWriterNo(loginMember.getNo());
    		board.setTitle(title);
    		board.setContent(content);
    		board.setOriginalFileName(originalFileName);
    		board.setRenamedFileName(filesystemName);
    		
    		result = new BoardService().save(board);
    		
    		if(result > 0) {
    			request.setAttribute("msg", "게시글 등록 성공");
    			request.setAttribute("location", "/board/list");
    		} else {
    			request.setAttribute("msg", "게시글 등록 실패");
    			request.setAttribute("location", "/board/list");
    		}
    	
    	} else {
    		request.setAttribute("msg", "로그인 후 사용할 수 있습니다.");
			request.setAttribute("location", "/");	
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	
	}

}
