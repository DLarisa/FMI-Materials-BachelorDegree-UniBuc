window.addEventListener("load", function(){
	var rng=document.getElementById("rng");
	rng.max=Math.floor(20+Math.random()*20);
	rng.parentNode.insertBefore(document.createTextNode(rng.min),rng);
	rng.parentNode.appendChild(document.createTextNode(rng.max));
	rng.value=rng.min;
});