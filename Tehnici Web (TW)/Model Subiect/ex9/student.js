window.onload=function(){
	document.body.innerHTML+=localStorage.getItem("numere")?localStorage.getItem("numere"):"";
	document.getElementById("salveaza").onclick=function(){
		localStorage.setItem("numere",document.body.lastChild.nodeValue);
	}
	document.getElementById("sterge").onclick=function(){
		localStorage.clear();
		document.body.removeChild(document.body.lastChild);
	}

}