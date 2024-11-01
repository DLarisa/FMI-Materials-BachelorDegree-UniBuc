window.addEventListener("load", function(){
	var rng=document.getElementById("rng");
	rng.parentNode.insertBefore(document.createTextNode(rng.min),rng);
	rng.parentNode.insertBefore(document.createTextNode(rng.max),rng.nextSibling);
	rng.value=rng.min;
});
