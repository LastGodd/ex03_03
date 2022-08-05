<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Tables</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Tables
					<button id="regBtn" type="button" class="btn btn-xs btn-primary pull-right">Register New Board</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table width="100%"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#</th>
								<th>Title</th>
								<th>Writer</th>
								<th>RegDate</th>
								<th>UpdateDate</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list }" var="board">
								<tr class="odd gradeX">
									<td><c:out value="${board.bno }" /></td>
									<td><a class="move" href="<c:out value='${board.bno }' />"><c:out value="${board.title }" /></a></td>
									<td><c:out value="${board.writer }" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${board.regdate }" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${board.updateDate }" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- /.table-responsive -->
				</div>
				<!-- /.panel-body -->
				<!-- prev, next값이 초기화된다. -->
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="paginate_item">
								<a class="page_link" href="#">Prev</a>
							</li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
								<a href="<c:out value='${num }'/>">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_item">
								<a class="page_link" href="#">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
</div>
<!-- /#page-wrapper -->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>

<form id="actionForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
</form>

<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		history.replaceState({}, null, null);

		function checkModal(result) {
			if (result === '' || history.state ) {
				return;
			}
			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " +parseInt(result) +"번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function() {
			self.location="/board/register";
		});
		
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr('href')+"'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		
	});
</script>

<%@include file="../includes/footer.jsp"%>