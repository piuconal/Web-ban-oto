const linkStatuss = document.getElementsByClassName("link-status");
const btnConfirms = document.getElementsByClassName("btn-confirm");
const btnPayments = document.getElementsByClassName("btn-payment");
const linkPayments = document.getElementsByClassName("link-payment");
const btnCancels = document.getElementsByClassName("btn-cancel");
const linkCancels = document.getElementsByClassName("link-cancel");
for(let i = 0;i<linkStatuss.length;i++){
	if(btnConfirms[i].innerHTML === "Confirm.."){
		btnPayments[i].style.background = "red";
		btnPayments[i].style.pointerEvents = "none";
		linkPayments[i].style.pointerEvents = "none";
		linkPayments[i].style.cursor = "default";
	}else if(btnConfirms[i].innerHTML === "Confirmed"){
		btnPayments[i].style.background = "yellow";
		btnPayments[i].style.pointerEvents = "all";
		
		btnCancels[i].style.pointerEvents = "none";
		btnCancels[i].style.background = "white";
		linkCancels[i].style.pointerEvents = "none";
		linkCancels[i].style.cursor = "default";
		
		btnConfirms[i].style.pointerEvents = "none";
		btnConfirms[i].style.background = "orange";
		linkStatuss[i].style.pointerEvents = "none";
		linkStatuss[i].style.cursor = "default";
	}else if(btnConfirms[i].innerHTML === "Done"){
		btnConfirms[i].style.pointerEvents = "none";
		btnConfirms[i].style.background = "white";
		linkStatuss[i].style.pointerEvents = "none";
		linkStatuss[i].style.cursor = "default";
		
		btnPayments[i].style.background = "white";
		btnPayments[i].style.pointerEvents = "none";
		linkPayments[i].style.pointerEvents = "none";
		linkPayments[i].style.cursor = "default";
		
		btnCancels[i].style.pointerEvents = "none";
		btnCancels[i].style.background = "white";
		linkCancels[i].style.pointerEvents = "none";
		linkCancels[i].style.cursor = "default";
		
	}else{
		btnConfirms[i].style.pointerEvents = "none";
		btnConfirms[i].style.background = "#00FFFF";
		linkStatuss[i].style.pointerEvents = "none";
		linkStatuss[i].style.cursor = "default";
		
		btnCancels[i].style.pointerEvents = "none";
		btnCancels[i].style.background = "#555555";
		linkCancels[i].style.pointerEvents = "none";
		linkCancels[i].style.cursor = "default";
		
		btnPayments[i].style.background = "#00FFFF";
		btnPayments[i].style.pointerEvents = "none";
		linkPayments[i].style.pointerEvents = "none";
		linkPayments[i].style.cursor = "default";
	}
}
