const btnConfirms = document.getElementsByClassName("btn-confirm");
const popup = document.getElementById("confirmPopup");
const pop = document.getElementById("confirmPayment");
const popcancel = document.getElementById("confirmCancel")
const btn_confirm_popup = document.getElementById("btn-confirm-popup");
const btn_cancel_popup = document.getElementById("btn-cancel-popup");
const btn_confirm_pop = document.getElementById("btn-confirm-pop");
const btn_cancel_pop = document.getElementById("btn-cancel-pop");
const btn_confirm_cancel = document.getElementById("btn-confirm-cancel");
const btn_cancel_cancel = document.getElementById("btn-cancel-cancel");
const btnStatuss = document.getElementsByClassName("btn-status");
const btnCancels = document.getElementsByClassName("btn-cancel");
for (let i = 0; i < btnStatuss.length; i++) {
	if (btnStatuss[i].innerText === "Done") {
		btnConfirms[i].style.pointerEvents = "none";
		btnCancels[i].style.pointerEvents = "none";
		btnConfirms[i].style.background = "white";
	} else
		btnStatuss[i].style.background = "yellow";
	if (btnConfirms[i].innerText === "Confirmed") {
		btnConfirms[i].style.pointerEvents = "none";
		btnCancels[i].style.pointerEvents = "none";
		btnStatuss[i].style.pointerEvents = "all";
	} else if (btnConfirms[i].innerText === "Canceled") {
		btnConfirms[i].style.pointerEvents = "none";
		btnCancels[i].style.pointerEvents = "none";
		btnConfirms[i].style.background = "#3399FF";
	} else {
		btnStatuss[i].style.pointerEvents = "none";
		btnConfirms[i].addEventListener("click", function() {
			popup.style.display = "block";
			btn_confirm_popup.addEventListener("click", function() {
				popup.style.display = "none";
				btnConfirms[i].style.pointerEvents = "none";
				btnStatuss[i].style.background = "yellow";
				btnCancels[i].style.pointerEvents = "none";
				btnStatuss[i].style.pointerEvents = "all";
				location.reload();
			});
			btn_cancel_popup.addEventListener("click", function() {
				popup.style.display = "none";
			})
			var orderId = this.parentElement.parentElement.children[1].textContent;
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "OrderStatusServlet", true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState === XMLHttpRequest.DONE) {
					if (xhr.status === 200) {
						console.log(xhr.responseText);
					} else {
						console.error("Request failed with status:", xhr.status);
					}
				}
			};
			xhr.send("orderId=" + encodeURIComponent(orderId));
		});

	}
}
for (let i = 0; i < btnStatuss.length; i++) {
	btnStatuss[i].addEventListener("click", function() {
		pop.style.display = "block";
		btn_confirm_pop.addEventListener("click", function() {
			pop.style.display = "none";
			btnConfirms[i].style.pointerEvents = "none";
			btnStatuss[i].style.background = "yellow";
			btnCancels[i].style.pointerEvents = "none";
			btnStatuss[i].style.pointerEvents = "all";
			location.reload();
		});
		btn_cancel_pop.addEventListener("click", function() {
			pop.style.display = "none";
		})
		var orderId = this.parentElement.parentElement.children[1].textContent;
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "PaymentStatusServlet", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE) {
				if (xhr.status === 200) {
					console.log(xhr.responseText);
				} else {
					console.error("Request failed with status:", xhr.status);
				}
			}
		};
		xhr.send("orderId=" + encodeURIComponent(orderId));
	});

}
for (let i = 0; i < btnCancels.length; i++) {
	btnCancels[i].addEventListener("click", function() {
		popcancel.style.display = "block";
		btn_confirm_cancel.addEventListener("click", function() {
			popcancel.style.display = "none";
			btnConfirms[i].style.pointerEvents = "none";
			btnConfirms[i].style.background = "white";
			location.reload();
		});
		btn_cancel_cancel.addEventListener("click", function() {
			popcancel.style.display = "none";
		})
		var orderId = this.parentElement.parentElement.children[1].textContent;
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "CancelStatusServlet", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE) {
				if (xhr.status === 200) {
					console.log(xhr.responseText);
				} else {
					console.error("Request failed with status:", xhr.status);
				}
			}
		};
		xhr.send("orderId=" + encodeURIComponent(orderId));
	});

}
/**
 * 
 */