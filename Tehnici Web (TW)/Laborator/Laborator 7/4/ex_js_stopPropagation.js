function f(elem)
{
	//TO DO alert cu tagul elementului pe care s-a facut click
	alert(elem.tagName);
}

window.onload=function()
{
	
	albastru=true
	
	document.getElementById("dv").onclick=function(ev){
		f(this)
		if(ev.target==ev.currentTarget)
		{
			this.style.backgroundColor=albastru ? "red" : "blue";
			albastru=!albastru;
		}
	}
	
	document.getElementById("btn").onclick=function(ev){
		f(this)		
	}
	
	document.getElementById("btn2").onclick=function(ev){
		f(this)
		ev.stopPropagation(); //La Examen
	}	
}