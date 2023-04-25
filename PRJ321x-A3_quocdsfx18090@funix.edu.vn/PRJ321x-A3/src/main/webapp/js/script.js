'use strict';
const btnSignUp = document.getElementById("btn-signup");
const btnLogin = document.getElementById("btn-login");
const btnLogout = document.getElementById("btn-logout");
const number = document.getElementById("numDisplayProduct");
const successMessage = document.getElementById("successfully");
const errorsMessage = document.getElementById("errors");
if (btnLogin != null) {
	btnLogin.addEventListener('click', () => {
		window.location = "./login.jsp";
	});
}
if (btnSignUp != null) {
	btnSignUp.addEventListener('click', () => {
		window.location = "./register.jsp";
	});
}
/*
btnLogout.addEventListener('click', ()=>{
	alert("1234");
});*/
if (number != null) {
	number.addEventListener("change", () => {
		window.location = `./main?num=${number.value}`;
	});
}

function getMessage(messString) {
	if (successMessage != null) {
		window.addEventListener('load', () => {
			swal(
				'Success',
				`${messString}<b style="color:green;"> thành công</b>`,
				'success'
			)
		});
	} else if (errorsMessage != null) {
		window.addEventListener('load', () => {
			swal(
				'Error!',
				`Có <b style="color:red;"> lỗi </b>trong quá trình ${messString}!`,
				'error'
			)
		});
	}
}