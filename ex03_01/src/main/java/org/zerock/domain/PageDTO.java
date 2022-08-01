package org.zerock.domain;

import lombok.Data;

@Data
public class PageDTO {
	// 화면에서 보여지는 시작번호
	private int startPage;
	// 화면에서 보여지는 끝번호
	private int endPage;
	// 이전과 다음으로 이동 가능한 링크의 표시 여부
	private boolean prev, next;

	private int total;
	private Criteria cri;

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;

		// 페이징 끝번호 계산(눈에 보이는 5번째 페이지는 1번 버튼에 속해야함, 11번 페이지부터는 2번)
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;

		int realEnd = (int) (Math.ceil((total * 10.0) / cri.getAmount()));

		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

}
