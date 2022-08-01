package org.zerock.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	
	public Criteria() {
		this(1, 10);
		// 1page당 10개씩
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
