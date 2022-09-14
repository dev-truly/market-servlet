<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title><c:out value="${param.boardName}" /></title>
    <link href="/market/css/bootstrap.min.css" rel="stylesheet">
    <link href="/market/css/font-awesome.min.css" rel="stylesheet">
    <link href="/market/css/prettyPhoto.css" rel="stylesheet">
    <link href="/market/css/price-range.css" rel="stylesheet">
    <link href="/market/css/animate.css" rel="stylesheet">
	<link href="/market/css/main.css" rel="stylesheet">
	<link href="/market/css/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/market/js/html5shiv.js"></script>
    <script src="/market/js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
	<link rel="stylesheet" href="/market/css/board.css" />
	<style>
		.search-area {text-align: right;margin-bottom: 5px;}
		.search-area select {border:solid 1px #c7c7c7;background: none;padding: 10px; font-size:16px;border-radius: 3px;width:auto;}
		.search-area input {border:solid 1px #c7c7c7;background: none;padding: 10px 10px 8px 10px; font-size:16px;border-radius: 3px;}
		table tbody a, table tbody a:link {color: #000;}
	</style>
</head><!--/head-->

<body>
<c:choose>
	<c:when test="${param.pageSize == null}"><c:set var="pageSize" value="10" /></c:when>
	<c:otherwise><c:set var="pageSize" value="${param.pageSize}" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${param.pageNo == null}"><c:set var="pageNo" value="1" /></c:when>
	<c:otherwise><c:set var="pageNo" value="${param.pageNo}" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${param.sort == null}"><c:set var="sort" value="asc" /></c:when>
	<c:otherwise><c:set var="sort" value="${param.sort}" /></c:otherwise>
</c:choose>
	<header id="header"><!--header-->
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	</header><!--/header-->

	<section id="cart_items">
		<div class="container">
			<div class="breadcrumbs">
				<ol class="breadcrumb">
				  <li><a href="#">Main</a></li>
				  <li class="active board-title"><c:out value="${param.boardName}" /></li>
				</ol>
			</div>
			<h2 class="board-title"><c:out value="${param.boardName}" /></h2>
			<div class="search-area">
				<c:if test="${!(param.board eq 'notice')}">
					<div style="float:left;text-align: left;">
						<button class="btn btn-default" id="btn-write">글 작성</button>
					</div>
				</c:if>
				<form id="boardSearchForm" name="boardSearchForm" method="get" style="display:inline-block;">
					<input type="hidden" name="pageSize" value='<c:out value="${pageSize}" />' />
					<input type="hidden" name="pageNo" value='<c:out value="${pageNo}" />' />
					<input type="hidden" name="sort" value='<c:out value="${sort}" />' />
					<select name="searchType">
						<option value="title"
								<c:if test="${param.searchType eq 'title'}">selected</c:if>
						/>제목</option>
						<option value="content"
								<c:if test="${param.searchType eq 'content'}">selected</c:if>
						>내용</option>
						<option value="writer"
								<c:if test="${param.searchType eq 'writer'}">selected</c:if>
						>작성자</option>
					</select>
					<input type="text" name="searchValue" value='<c:out value="${param.searchValue}" />' />
				</form>
			</div>
			<div class="table-responsive">
				<table class="table">
					<colgroup>
						<col style="width:100px;" />
						<col style="width:auto;" />
						<col style="width:150px;" />
						<col style="width:150px;" />
						<col style="width:100px;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">날짜</th>
							<th scope="col">조회</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th colspan="5">게시글을 불러오는 중 입니다.</th>
						</tr>
					</tbody>
				</table>
				<div class="pagination-area" style="text-align: center; height: 40px;">
				</div>
			</div>
		</div>
	</section>


	<footer id="footer"><!--Footer-->
		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	</footer><!--/Footer-->

    <script src="/market/js/jquery.js"></script>
	<script src="/market/js/bootstrap.min.js"></script>
	<script src="/market/js/jquery.scrollUp.min.js"></script>
    <script src="/market/js/jquery.prettyPhoto.js"></script>
	<script src="/market/js/common.js"></script>
	<script src="/market/js/Pagination.js"></script>
	<script>
		paginationArea = document.querySelector(".pagination-area");
		if (document.querySelector("#btn-write") != null) {
			document.querySelector("#btn-write").addEventListener("click", () => {
				location.href = `/market/board/${param.board}/write?\${new URLSearchParams(new FormData(document.boardSearchForm)).toString()}`;
			});
		}

		XMLAjax("/market/api/board/<%=request.getParameter("board")%>/list", "GET",
			{
				pageSize: <c:out value="${pageSize}" />,
				pageNo: <c:out value="${pageNo}" />,
				sort: `<c:out value="${sort}" />`,
				searchType: `<c:out value="${param.searchType}" />`,
				searchValue: `<c:out value="${param.searchValue}" />`,
			},
			(data) => {
				let resultData = JSON.parse(data);
				let tableSelector = document.querySelector(".table tbody");
				if (!resultData) {
					tableSelector.innerHTML = `<tr><td colspan="5">게시글을 불러오는데 실패 했습니다.</td></tr>`;
				}
				else {
					if (resultData.data == undefined || !resultData.result) {
						tableSelector.innerHTML = `<tr><td colspan="5">등록 된 게시글이 없습니다.</td></tr>`
					}
					else {
						tableSelector.innerHTML = "";
						let boardNumber = resultData.totalCount - (<c:out value="${pageSize}" /> * (<c:out value="${pageNo}" /> - 1));

						resultData.data.forEach((v) => {
							//console.log(new Date(v.regDate).getFullYear());
							tableSelector.innerHTML += `
						<tr>
							<th scope="row">\${boardNumber}</th>
							<td class="title">
								<a href="/market/board/<c:out value="${param.board}" />/view?boardNo=\${v.boardNo + '&' + new URLSearchParams(new FormData(document.boardSearchForm)).toString()}" >
									\${v.title}\${(v.attachCnt > 0) ? ' <i class="fa fa-file-o"></i>' : ''}
								</a>
							</td>
							<td>\${v.writer}</td>
							<td>\${setDateFormat(v.regDate)}</td>
							<td>\${v.readCount}</td>
						</tr>
						` ;
							boardNumber--;
						});

						let searchParams = {}
						new FormData(document.boardSearchForm).forEach((v, k) => {
							searchParams[k] = v;
						})
						new Pagination(paginationArea,
								<c:out value="${pageNo}" />,
								<c:out value="${pageSize}" />,
								resultData.totalCount,
								10,undefined,
								searchParams
						);
					}
				}
			}
		)
		document.boardSearchForm.addEventListener("submit", (e) => {
			e.target.pageNo.value = 1;
		})

	</script>
</body>
</html>