function addToCart(productId) {
	var xhr = new XMLHttpRequest();
	xhr.open('GET', 'add-to-cart?id=' + productId, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			alert('Add to cart successfully!');
		}
	};
	xhr.send();
}