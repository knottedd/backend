package com.kh.el.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// lombok.jar 파일을 프로젝트에 등록하는게 아닌 WEB-INF 안 lib 폴더 내부에 넣어두면 된다.

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Student {
	
	private String name;
	
	private int age;
	
	private int math;
	
	private int english;
	
}
