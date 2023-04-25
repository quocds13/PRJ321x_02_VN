const txtUsername = document.getElementById("uname");
const txtPassword = document.getElementById("upass");
const btnLogin = document.getElementById("btnLogin");

let errString = "";
btnLogin.addEventListener("click",()=>{
	if(txtPassword.value == "" || txtPassword.value == null){
		errString += "Password can not be blank\n";
	}
	if(txtUsername.value == "" || txtUsername.value == null){
		errString += "Username can not be blank\n";
	}
	if(errString.length > 0)
		alert(errString);
});