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
		.table tbody tr:first-child td {padding: 10px;}
		.table tbody tr:first-child td div { float: left; }
		.table tbody tr:first-child td span { padding: 0 5px; font-size: 13px; color: #8d8d8d; }
		.table tbody tr:first-child td span#split { padding: 0 5px; font-size: 15px; color: #d2d2d2; }
		.table tbody tr td#data-content { text-align: unset; padding: 20px; }
		.table tbody tr.attach-area td {text-align: left; font-size: 13px; padding-left: 20px; color: #8d8d8d;}
		#modal { position: absolute;background: #000; z-index: 10; top:0; left:0; width: 100%; height:100%;opacity: 0.7; display: none; }
		#board-password-area { position: fixed; background: #fff; z-index: 11; border-radius: 10px; top: 0; left: 0;text-align:center; padding: 20px; display:none; width: 353px; height: 80px; }
		#board-password-area div { float: left; }
		#board-password-area button { margin: 3px 3px; }
		input[name="boardPassword"] { font-size: 18px; padding: 5px; height: 40px; border: solid 1px #dadada; border-radius: 3px; }
		#board-password-button-area { height: 40px; }
	</style>
</head><!--/head-->

<body>
<c:choose>
	<c:when test="${param.boardNo == null}"><c:set var="boardNo" value="10" /></c:when>
	<c:otherwise><c:set var="boardNo" value="${param.boardNo}" /></c:otherwise>
</c:choose>
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
			<div class="search-area" style="height:48px;">
				<form id="boardSearchForm" name="boardSearchForm" method="get">
					<input type="hidden" name="pageSize" value='<c:out value="${pageSize}" />' />
					<input type="hidden" name="pageNo" value='<c:out value="${pageNo}" />' />
					<input type="hidden" name="sort" value='<c:out value="${sort}" />' />
					<input type="hidden" name="searchType" value='<c:out value="${param.searchType}" />' />
					<input type="hidden" name="searchValue" value='<c:out value="${param.searchValue}" />' />
				</form>
			</div>
			<div class="table-responsive">
				<table class="table">
					<colgroup>
						<col style="width:auto;" />
					</colgroup>
					<thead>
						<tr>
							<th id="data-title" scope="col" style="text-align: left; padding-left: 20px;"></th>
						</tr>
					</thead>
					<tbody>
						<tr id="board-info">
							<td style="text-align: left; padding-left: 20px;">
								<div style="width:20%;">
									<span id="data-writer"></span><span id="split">|</span><span id="data-regDate"></span>
								</div>
								<div style="width:80%;text-align:right;padding-right: 20px;">
									<span>조회수</span> <span id="data-readCount">0</span>
								</div>
							</td>
						</tr>
						<tr>
							<td id="data-content" ></td>
						</tr>
					</tbody>
				</table>
				<div class="pagination-area" style="text-align: right; height: 40px;">
					<c:if test="${!(param.board eq 'notice')}">
						<button class="delete btn btn-default">삭제</button>
						<button class="modify btn btn-default">수정</button>
					</c:if>
					<button class="listView btn btn-default">목록</button>
				</div>
			</div>
		</div>
	</section>
	<div id="modal"></div>
	<div id="board-password-area">
		<form name="boardPasswordForm" method="post">
			<div>
				<input type="hidden" name="boardNo" value="<c:out value="${boardNo}" />" />
				<input type="hidden" name="mode" value="delete" />
				<input type="password" name="boardPassword" placeholder="비밀번호 입력" />
			</div>
			<div id="board-password-button-area"><button type="submit" class="btn btn-default" name="board-password-submit">입력</button><button type="button" class="btn btn-default" name="board-password-cancel">취소</button></div>
		</form>
	</div>
	<footer id="footer"><!--Footer-->
		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	</footer><!--/Footer-->

    <script src="/market/js/jquery.js"></script>
	<script src="/market/js/bootstrap.min.js"></script>
	<script src="/market/js/jquery.scrollUp.min.js"></script>
    <script src="/market/js/jquery.prettyPhoto.js"></script>
	<script src="/market/js/common.js"></script>
	<script src="/market/js/DisplayAnimation.js"></script>
	<script>
		paginationArea = document.querySelector(".pagination-area");

		document.querySelector("button.listView").addEventListener("click", () => {
			location.href = "/market/board/<%=request.getParameter("board")%>/list?" + new URLSearchParams(new FormData(document.boardSearchForm)).toString();
		});

		<c:if test="${!(param.board eq 'notice')}">
		let modalBackArea = new DisplayAnimation(document.querySelector("#modal"));
		const boardModalTimer = 400;
		document.querySelector(".delete").addEventListener("click", () => {
			boardPasswordAreaShow(boardModalTimer, "delete");
		});

		document.querySelector(".modify").addEventListener("click", () => {
			boardPasswordAreaShow(boardModalTimer, "modify");
		});

		const boardPasswordForm = document.boardPasswordForm;
		const boardPasswordArea = document.querySelector("#board-password-area");
		const areaStyle = getComputedStyle(boardPasswordArea);
		const areaHeight = areaStyle.height.replace("px", "");
		const areaWidth = areaStyle.width.replace("px", "");
		const boardPasswordAreaShow = (boardModalTimer, mode) => {
			boardPasswordForm.mode.value = mode;
			setTimeout(() => {
				let top = ((window.innerHeight / 2) - (areaHeight / 2)) + (document.documentElement.scrollTop / 2);
				let left = ((window.innerWidth / 2) - (areaWidth / 2)) - (document.documentElement.scrollLeft / 2);

				boardPasswordArea.style.top = `\${top}px`;
				boardPasswordArea.style.left = `\${left}px`;
				boardPasswordArea.style.display = "block";
			}, boardModalTimer);
			modalBackArea.slideDown(boardModalTimer);
		}

		const boardPasswordAreaHide = () => {
			boardPasswordForm.reset();
			modalBackArea.hide();
			document.querySelector("#board-password-area").style.display = "none";
		}

		boardPasswordForm.addEventListener("submit", (e) => {
			e.preventDefault();
			JSONRequest(window.location.pathname, new FormData(e.target), (data) => {
				const resultData = JSON.parse(data);
				if (resultData.result) {
					if (e.target.mode.value === "delete") {
						if (confirm("데이터를 정말 삭제 하시겠습니까?")) {
							JSONRequest(`/market/board/<%=request.getParameter("board")%>/delete`, new FormData(e.target), (data) => {
								let deleteResult = JSON.parse(data);
								if (deleteResult.result) {
									alert("게시글 삭제에 성공 했습니다.");
									location.href = "/market/board/<%=request.getParameter("board")%>/list?" + new URLSearchParams(new FormData(document.boardSearchForm)).toString();
								}
								else {
									alert("해당 게시글 삭제에 실패 했습니다.");
								}
							});
						}
					}
					else {
						location.href = "/market/board/<%=request.getParameter("board")%>/modify?boardNo=<%=request.getParameter("boardNo")%>&" + new URLSearchParams(new FormData(document.boardSearchForm)).toString();
					}
					boardPasswordAreaHide();
				}
				else {
					alert("비밀번호를 확인해 주세요");
					e.target.reset();
					e.target.boardPassword.focus();
				}
			});
		})

		document.querySelector(`button[name="board-password-cancel"]`).addEventListener("click", () => {
			boardPasswordAreaHide();
		})
		</c:if>
		XMLAjax("/market/api/board/<%=request.getParameter("board")%>/view", "GET",
			{
				boardNo: <c:out value="${boardNo}" />,
			},
			(data) => {
				let resultData = JSON.parse(data);
				let tableSelector = document.querySelector(".table tbody");
				if (resultData.result) {
					document.querySelector("#data-title").innerHTML = resultData.data.title;
					document.querySelector("#data-writer").innerHTML = resultData.data.writer;
					document.querySelector("#data-readCount").innerHTML = resultData.data.readCount.toLocaleString("en-US");
					document.querySelector("#data-regDate").innerHTML = setFullDateFormat(resultData.data.regDate);
					document.querySelector("#data-content").innerHTML = nl2br(resultData.data.content);
					if (resultData.data.attachCnt > 0 && resultData.attachData != null) {
						let attachRow = document.createElement("tr");
						attachRow.classList.add('attach-area');
						attachRow.append(document.createElement("td"));
						attachRow.querySelector("td").setAttribute("colspan", "2");
						for (let i = 0; i < resultData.attachData.length; i++) {
							let attachFileDiv = document.createElement('div');
							attachFileDiv.innerHTML = `첨부파일\${i + 1} : <a href="/market/board/attach/download?serverFileName=\${resultData.attachData[i].serverFileName}&oriFileName=\${resultData.attachData[i].oriFileName}">\${resultData.attachData[i].oriFileName}</a>`;
							attachRow.querySelector("td").append (
								attachFileDiv
							);
						}
						document.querySelector("#board-info").after(attachRow);
					}

				}
				else {
					switch (resultData.err_code) {
						case "01" :
							alert("잘못 된 게시글 번호 입니다.");
							history.back();
							break;
						case "02" :
							alert("게시글 로드에 실패 했습니다.");
							history.back();
							break;
						case "03" :
							alert("잘못 된 게시글 번호 입니다.");
							history.back();
							break;
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