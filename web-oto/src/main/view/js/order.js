const statuss = document.getElementsByClassName("status");
const cancelBtns = document.getElementsByClassName("btn-cancel");
const cancelOrder = document.getElementsByClassName("cancel-order");
for (let i = 0; i < statuss.length; i++) {
	if (statuss[i].innerText === "Confirm..") {
		cancelBtns[i].style.pointerEvents = "all";
		cancelOrder[i].style.pointerEvents = "all";
		cancelOrder[i].style.cursor = "pointer";
	} else if (statuss[i].innerText === 'Done') {
		cancelBtns[i].style.pointerEvents = "none";
		cancelBtns[i].innerText = "Thanks"
		cancelBtns[i].style.background = "#FFFF00";
		cancelOrder[i].style.pointerEvents = "none";
		cancelOrder[i].style.cursor = "default";
	} else if (statuss[i].innerText === 'Canceled') {
		cancelBtns[i].innerText = "Confirm";
		cancelBtns[i].style.background = "#00FF00";
	} else {
		cancelBtns[i].style.pointerEvents = "none";
		cancelOrder[i].style.pointerEvents = "none";
		cancelOrder[i].style.cursor = "default";
		cancelBtns[i].style.background = "white";
	}
}