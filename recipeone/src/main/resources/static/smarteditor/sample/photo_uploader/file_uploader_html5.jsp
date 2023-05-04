<%--------------------------------------------------------------------------------
	* 화면명 : Smart Editor 2.8 에디터 - 다중 파일 업로드 처리
	* 파일명 : /SE2/sample/photo_uploader/file_uploader_html5.jsp
--------------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	// 로컬경로에 파일 저장하기 ============================================
	String fileInfo = "";

	// 파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
	String fileName = request.getHeader("file-name");

	// 확장자
	String fileName_suffix = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
	String[] suffixArr = {"jpg", "png", "bmp", "gif"};

	int cnt = 0;
	for(int i = 0; i <suffixArr.length; i++){
		if(fileName_suffix.equals(suffixArr[i])){
			cnt++;
		}
	}
	
	if(cnt == 0){
		out.println("NOTALLOW_" + fileName);
	} else {
		String dafaultPath = request.getSession().getServletContext().getRealPath("/");
		String filePath = dafaultPath + "img" + File.separator + "smarteditor" + File.separator;
		
		File file = new File(filePath);
		if(!file.exists()){
			file.mkdirs();
		}
		String autoFileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
		
		String rFileName = filePath + autoFileName;
		InputStream is = request.getInputStream();
		OutputStream os = new FileOutputStream(rFileName);
		int num;
		byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
		while ((num = is.read(b, 0, b.length)) != -1) {
			os.write(b, 0, num);
		}
		if (is != null) {
			is.close();
		}
		os.flush();
		os.close();
		
		fileInfo += "&bNewLine=true";
		fileInfo += "&sFileName=" + fileName;
		fileInfo += "&sFileURL=/img/smarteditor/" + autoFileName;
		out.println(fileInfo);
	}
%>
