document.addEventListener('DOMContentLoaded', function() {
	document.querySelector('form').addEventListener('submit', function(event) {
		event.preventDefault(); // Ngăn chặn việc gửi biểu mẫu theo cách mặc định

		// Lấy dữ liệu từ các trường nhập liệu
		var name = document.getElementById('name').value;
		var price = document.getElementById('price').value;
		var category = document.getElementById('category').value;
		var image = document.getElementById('image').value;

		// Gửi yêu cầu AJAX đến máy chủ để thêm dữ liệu
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'create.jsp', true);
		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE
				&& xhr.status === 200) {
				// Xử lý phản hồi từ máy chủ (nếu cần)
				location.reload(); // Tải lại trang để cập nhật bảng dữ liệu
			}
		};

		// Chuẩn bị dữ liệu để gửi đi
		var params = 'name=' + encodeURIComponent(name)
			+ '&price=' + encodeURIComponent(price)
			+ '&category=' + encodeURIComponent(category)
			+ '&image=' + encodeURIComponent(image);
		// Gửi yêu cầu
		xhr.send(params);
	});
});