const statuss = document.getElementsByClassName("status");
const cancelBtns = document.getElementsByClassName("btn-cancel");
for (let i = 0; i < statuss.length; i++) {
	if (statuss[i].innerText === "Confirm..") {
		cancelBtns[i].style.pointerEvents = "all";
	} else if (statuss[i].innerText === 'Done') {
		cancelBtns[i].style.pointerEvents = "none";
		cancelBtns[i].innerText = "Thanks"
		cancelBtns[i].style.background = "#FFFF00";
	} else if (statuss[i].innerText === 'Canceled') {
		cancelBtns[i].innerText = "Confirm";
		cancelBtns[i].style.background = "#00FF00";
	} else {
		cancelBtns[i].style.pointerEvents = "none";
		cancelBtns[i].style.background = "white";
	}
}
for (let i = 0; i < cancelBtns.length; i++) {
	cancelBtns[i].addEventListener("click", function() {

	})
}/**
 * 
 */