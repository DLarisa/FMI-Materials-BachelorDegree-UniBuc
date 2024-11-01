window.onload=function(){
	var btns=document.querySelectorAll(".a.b");
	for (b of btns){
		b.onclick=function(){
			if(!this.classList.contains("c") && !this.classList.contains("d"))
				this.classList.add("zzz");
		}
	}
	
	special=document.getElementById("clase_multe");
	special.onclick=function(){
		for(i=0; i<special.classList.length; i++){
			cls=special.classList.item(i);
			if(cls[cls.length-1]%2==0) {special.classList.remove(cls);i--;}
		}
	}
}