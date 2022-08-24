<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Login | E-Shopper</title>
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
					<h2>회원 가입 정보 입력</h2>
					<form id="registerform" name="registerform"
						  action="/market/account/signup" method="post"><!-- 상대경로표시 -->
						<table id="signup-table">
							<colgroup>
								<col style="width: 100px;" />
								<col style="width: 300px;" />
							</colgroup>
							<tr>
								<th>아이디(ID)</th>
								<td>
									<input type="text" id="memberId" name="memberId" data-value-type="id" data-not-null="true" data-value-title="아이디" />
									<div id="id-check" class="warning">아이디를 입력해 주세요</div>
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type="password" id="passwd" name="passwd" data-value-type="pwd" data-not-null="true" data-value-title="비밀번호" />
									<div id="passwd-check" class="warning"></div>
								</td>
							</tr>
							<tr>
								<th>비밀번호 확인</th>
								<td>
									<input type="password" id="confirm" name="confirm" data-not-null="true" data-value-title="비밀번호 확인" />
									<div id="passwd-confirm" class="warning"></div>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" id="memberName" name="memberName" data-not-null="true" data-value-title="이름" />
									<div class="blank-area"></div>
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<input type="text" id="email" name="email" data-value-type="email" data-not-null="true" data-value-title="이메일" placeholder="OOO@OOO.com" />
									<div class="blank-area"></div>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<input type="text" id="tel" name="tel" data-value-type="hp" data-not-null="true" data-value-title="연락처" placeholder="010-0000-0000" />
									<div class="blank-area"></div>
								</td>
							</tr>
						</table>
						<div style="padding-top: 30px;">
							<button type="submit" class="btn btn-default" style="margin:0 auto;">회원가입</button>
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
		let idCheckFlag = false;
		let pwdConfirmFlag = false;

		const inputPwd = document.querySelector("#passwd");
		const inputPwdConfirm = document.querySelector("#confirm");
		const inputId = document.querySelector("#memberId");
		const idCheckArea = document.querySelector("#id-check");
		window.onload = () => {
			inputId.focus();
		}


		//document.registerform.value = "허허허";
		let joinValid = new PnJValidation(document.registerform,
				['memberId', 'passwd', 'confirm', 'memberName', 'email', 'tel'],
		);

		const idValidPattern = joinValid.getPattern("id");
		const pwdValidPattern = joinValid.getPattern("pwd");

		joinValid.setSubmitAction(() => {
			if (!idCheckFlag) {
				alert("아이디를 확인해 주세요");
				inputId.focus();
				return;
			}
			else if (!pwdConfirmFlag) {
				alert("비밀번호가 일치하지 않습니다.");
				inputPwdConfirm.focus();
				return;
			}
			const targetForm = joinValid.getForm();
			let formData = new FormData(targetForm);
			JSONRequest(targetForm.action, formData, (data) => {
				const obj = JSON.parse(data);
				if (obj.result) {
					alert("회원 가입에 성공 했습니다.");
					location.href = "/market/account/login";
				}
				else {
					alert("회원 가입에 실패 했습니다.");
				}
			});
		});

		inputPwdConfirm.addEventListener("keyup", (e) => {
			if (e.target.value.length > 0 && e.target.value != inputPwd.value) {
				checkAreaToggle(document.querySelector("#passwd-confirm"), `입력된 비밀번호와 일치 하지 않습니다.`, false);
				pwdConfirmFlag = false;
			}
			else if (e.target.value.length == 0) {
				document.querySelector("#passwd-confirm").innerHTML = ``;
			}
			else if (e.target.value == inputPwd.value) {
				checkAreaToggle(document.querySelector("#passwd-confirm"), `비밀번호가 일치 합니다.`, true);
				pwdConfirmFlag = true;
			}
		})
		inputPwd.addEventListener("keyup", (e) => {
			if (e.target.value.length > 0 && pwdValidPattern[0].test(e.target.value)) {
				checkAreaToggle(document.querySelector("#passwd-check"), "사용 가능한 비밀번호 입니다.", true);
			}
			else if (e.target.value.length == 0){
				document.querySelector("#passwd-check").innerHTML = ``;
			}
			else if (!pwdValidPattern[0].test(e.target.value)) {
				checkAreaToggle(document.querySelector("#passwd-check"), `대소문자, 숫자, 기호가 조합된 8~30자리`, false);
			}

			if (inputPwdConfirm.value.length > 0 && e.target.value.length > 0
					&& (e.target.value == inputPwdConfirm.value)
			) {
				checkAreaToggle(document.querySelector("#passwd-confirm"), `비밀번호가 일치 합니다.`, true);
				pwdConfirmFlag = true;
			}
			else if (inputPwdConfirm.value.length > 0 && (e.target.value != inputPwdConfirm.value)
			) {
				checkAreaToggle(document.querySelector("#passwd-confirm"), `입력된 비밀번호와 일치 하지 않습니다.`, false);
				pwdConfirmFlag = false;
			}
		});

		inputId.addEventListener("keyup", (e) => {
			if (e.target.value.length > 0 && idValidPattern[0].test(e.target.value)) {
				JSONRequest("/market/account/join-check",
						{"memberId": `\${e.target.value}`},
						(data) => {
							let obj = JSON.parse(data);

							if (obj.result) {
								checkAreaToggle(idCheckArea, '입력하신 아이디가 존재 합니다.', false);
								idCheckFlag = false;
							}
							else {
								checkAreaToggle(idCheckArea, '입력 하신 아이디는 사용이 가능 합니다.', true);
								idCheckFlag = true;
							}
						},
						() => {console.log('데이터 로드 실패')}
				);
			}
			else if (e.target.value.length == 0) {
				checkAreaToggle(idCheckArea, `아이디를 입력해 주세요`, false);
			}
			else {
				checkAreaToggle(idCheckArea, `'아이디'는 \${idValidPattern[1]}`, false);
			}
		});

		const checkAreaToggle = (element, msg, flag = false) => {
			console.log(msg);
			if (flag) {
				element.classList.remove("warning");
				element.classList.add("success");
			}
			else {
				element.classList.remove("success");
				element.classList.add("warning");
			}
			element.innerHTML = msg;
		}
	</script>
</body>
</html>