window.onload=function(){
	var pgfs=document.querySelectorAll("div+p");
	for(p of pgfs){
		p.onclick=function(){
			this.innerHTML=this.previousElementSibling.querySelectorAll("li").length;
		}
	}
}