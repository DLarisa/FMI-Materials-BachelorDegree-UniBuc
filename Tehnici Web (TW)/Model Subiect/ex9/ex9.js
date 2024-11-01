window.addEventListener("load",function(){
	setInterval(
		function(){
			document.body.appendChild(document.createTextNode(Math.floor(Math.random()*1000)+" "));
			document.body.normalize();
		},500
	);
});