<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>로그인 | E-Shopper</title>
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
	<link rel="shortcut icon" href="/market/images/ico/favicon.ico">
	<link rel="icon" href="/market/images/ico/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="/market/images/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/market/images/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/market/images/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="/market/images/ico/apple-touch-icon-57-precomposed.png">
	<link rel="stylesheet" href="/market/css/account.css" />
</head><!--/head-->

<body>
<header id="header"><!--header-->
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
</header><!--/header-->

<section id="form"><!--form-->
	<div class="container">
		<div class="row">
			<div class="signup-form" style="width:33%; margin:0 auto;text-align:center;"><!--sign up form-->
				<h2>로그인</h2>
				<form id="loginform" name="loginform"
					  action="/market/account/login" method="post"><!-- 상대경로표시 -->
					<table id="signup-table">
						<colgroup>
							<col style="width: 100px;" />
							<col style="width: 300px;" />
						</colgroup>
						<tr>
							<th>아이디(ID)</th>
							<td>
								<input type="text" id="memberId" name="memberId" data-value-type="id" data-not-null="true" data-value-title="아이디" />
								<div class="blank-area"></div>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" id="passwd" name="passwd" data-value-type="pwd" data-not-null="true" data-value-title="비밀번호" />
								<div class="blank-area"></div>
							</td>
						</tr>
					</table>
					<div style="padding-top: 30px;">
						<button type="submit" class="btn btn-default" style="margin:0 auto;">로그인</button>
					</div>
				</form>
			</div><!--/sign up form-->
		</div>
	</div>
</section><!--/form-->


<footer id="footer"><!--Footer-->
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</footer><!--/Footer-->



<script src="/market/js/jquery.js"></script>
<script src="/market/js/price-range.js"></script>
<script src="/market/js/jquery.scrollUp.min.js"></script>
<script src="/market/js/bootstrap.min.js"></script>
<script src="/market/js/jquery.prettyPhoto.js"></script>
<script src="/market/js/main.js"></script>
<script src="/market/js/common.js"></script>
<script src="/market/js/PnJValidation.js"></script>
<script type="text/javascript">
	let loginForm = document.loginform;
	let loginValid = new PnJValidation(document.loginform,
			['memberId', 'passwd'],
	);

	loginValid.setSubmitAction(() => {
		let loginForm = loginValid.getForm();
		JSONRequest('/market/account/login', new FormData(loginForm), (data) => {
			let resultData = JSON.parse(data);
			if (resultData.result) {
				location.href = "/market/";
			}
			else {
				alert("로그인에 실패 했습니다.");
				loginForm.reset();
				document.querySelector("#memberId").focus();
			}
		});
	});

	document.querySelector("#memberId").focus();
</script>
</body>
</html>