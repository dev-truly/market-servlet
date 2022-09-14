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
		#data-title input[type="text"] { width: 100%; }
		input[type="text"], input[type="password"], textarea { padding: 5px; border: solid 1px #dadada;border-radius: 3px; }
		input[type="text"], input[type="password"] { font-size:18px; }
		textarea { background: #fff;}
		.table tbody th { vertical-align: middle;text-align: right; }
		.table tbody td { text-align: left !important; padding: 10px !important; }
		.filebox { margin: 3px; }
		.filebox .upload-name {
			display: inline-block;
			vertical-align: middle;
			border: solid 1px #dadada;
			border-radius: 3px;
			color: #999999;
			cursor: pointer;
		}
		.filebox .upload-name:focus {
			border: solid 1px #dadada;
			border-radius: 3px;
		}
		.filebox input[type="file"] { position: absolute;width: 0;height: 0;padding: 0;overflow: hidden;border: 0;}
		.filebox label { cursor: pointer; }
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
				<form method="post" name="modifyForm" action="/market/api/board/<c:out value='${param.board}' />/write">
				<table class="table">
					<colgroup>
						<col style="width:100px;" />
						<col style="width:auto;" />
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
							<td id="data-title">
								<input type="text" name="title" id="title" data-not-null="true" data-value-title="제목" />
							</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>
								<input type="text" name="writer" id="writer" value="${ loginmember.memberName }" data-not-null="true" data-value-title="작성자" />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td id="data-content">
								<textarea name="content" id="content" rows="20" data-not-null="true" data-value-title="내용"></textarea>
							</td>
						</tr>
						<tr id="add-attach-area">
							<th>첨부파일</th>
							<td>
								<div id="filebox-area" style="display: inline-block;">
									<div class="filebox" id="default-file-box">
										<input class="upload-name" type="text" readonly value="첨부파일" placeholder="첨부파일">
										<label for="file">파일찾기</label>
										<input type="file" class="attach-file" id="file" name="attach">
									</div>
								</div>
								<button type="button" id="add-file-box" style="display: inline-block;border:solid 1px #000; padding: 3px 6px 2px 6px;border-radius: 5px;"><i class="fa fa-plus"></i></button>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="pagination-area" style="text-align: right; height: 40px;">
					<button type="submit" class="btn btn-default">글 작성 완료</button>
					<button type="button" class="listView btn btn-default">목록</button>
				</div>
				</form>
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
	<script src="/market/js/PnJValidation.js"></script>
	<script>
		const fileBoxHtml = document.querySelector("#default-file-box").innerHTML;
		document.querySelector("#add-file-box").addEventListener("click", () => {
			let fileBoxArea = document.querySelector("#filebox-area");
			let fileBoxLength = fileBoxArea.querySelectorAll(".filebox").length;

			let addFileBox = document.createElement("div");
			addFileBox.classList.add("filebox");
			addFileBox.innerHTML = fileBoxHtml;
			addFileBox.querySelector("label").setAttribute("for", "file" + fileBoxLength);
			addFileBox.querySelector("#file").setAttribute("id", "file" + fileBoxLength);
			fileBoxArea.append(addFileBox);
			fileBoxReset();
		})

		let fileBoxChangeEvent = (e) => {
			e.target.parentElement.querySelector(".upload-name").value = e.target.value;
		};

		let fileBoxClickEvent = (e) => {
			e.target.parentElement.querySelector(".attach-file").click();
		};

		const fileBoxReset = () => {
			document.querySelectorAll(".attach-file").forEach((e) => {
				e.removeEventListener("change", fileBoxChangeEvent);
				e.addEventListener("change", fileBoxChangeEvent);
			});

			document.querySelectorAll(".upload-name").forEach((e) => {
				e.removeEventListener("click", fileBoxClickEvent);
				e.addEventListener("click", fileBoxClickEvent);
			});
		}
		fileBoxReset();

		const writeValid = new PnJValidation(document.modifyForm,
			['title', 'writer', 'content']
		);

		writeValid.setSubmitAction((e) => {
			const _form = writeValid._form;
			XMLAjax(_form.action, _form.method, new FormData(_form), (data) => {
				const resultData = JSON.parse(data);
				if (resultData.result) {
					alert("게시글 작성이 완료 되었습니다.");
					location.href = "/market/board/<%=request.getParameter("board")%>/list?" + new URLSearchParams(new FormData(document.boardSearchForm)).toString();
				}
				else {
					alert("게시글 등록에 실패 했습니다.");
				}
			});
		});

		const boardModifyForm = document.modifyForm;
		XMLAjax("/market/api/board/<%=request.getParameter("board")%>/view", "GET",
				{
					boardNo: <c:out value="${boardNo}" />,
				},
				(data) => {
					let resultData = JSON.parse(data);
					let tableSelector = document.querySelector(".table tbody");
					if (resultData.result) {
						boardModifyForm.title.value = resultData.data.title;
						boardModifyForm.writer.value = resultData.data.writer;
						boardModifyForm.content.innerHTML = nl2br(resultData.data.content);
						if (resultData.data.attachCnt > 0 && resultData.attachData != null) {
							let attachRow = document.createElement("tr");
							attachRow.classList.add('attach-area');
							attachRow.append(document.createElement("th"));
							attachRow.querySelector("th").innerText = "기존첨부";
							attachRow.append(document.createElement("td"));
							for (let i = 0; i < resultData.attachData.length; i++) {
								let attachFileDiv = document.createElement('div');
								attachFileDiv.setAttribute("id", `old-file-\${resultData.attachData[i].attachNo}`)
								attachFileDiv.innerHTML = `<span>첨부파일\${i + 1}</span> : \${resultData.attachData[i].oriFileName}<a href="javascript:attachDelete(\${resultData.attachData[i].attachNo}, '\${resultData.attachData[i].oriFileName}')">&nbsp;&nbsp;<i class="fa fa-times"></i></a>`;
								attachRow.querySelector("td").append (
										attachFileDiv
								);
							}

							document.querySelector("#add-attach-area").before(attachRow);
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
		const attachDelete = (attachNo, fileName) => {
			if (confirm(`선택 첨부파일을 삭제 하시겠습니까?\n삭제 후 복구 불가!!\n선택 파일명 : \${fileName}`)) {
				JSONRequest("/market/board/attach/delete", {"attachNo": attachNo, "boardNo": <c:out value="${boardNo}" />}, (data) => {
					const resultData = JSON.parse(data);
					if (resultData.result) {
						document.querySelector(`#old-file-\${attachNo}`).remove();
						const oriAttachObj = document.querySelectorAll(`.attach-area > td > div`);
						if (oriAttachObj.length > 0) {
							let i = 1;
							for (let i = 0; i < oriAttachObj.length; i++) {
								oriAttachObj[i].querySelector('span').innerText = `첨부파일\${i+1}`;
							}
						}
						else {
							document.querySelector(`.attach-area`).remove();
						}
						alert("정상적으로 삭제 되었습니다.");
					}
				});
			}
		}
		document.querySelector("button.listView").addEventListener("click", () => {
			location.href = "/market/board/<%=request.getParameter("board")%>/list?" + new URLSearchParams(new FormData(document.boardSearchForm)).toString();
		});
	</script>
</body>
</html>