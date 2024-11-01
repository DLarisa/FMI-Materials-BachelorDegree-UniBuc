window.onload = function()
{
	document.getElementById("rng").onchange = function()
	{
		x = this.value;
		elemente = document.getElementsByTagName("div");
		for(el of elemente)
			if(el.innerHTML==x) 
			{
				el.style.border = "solid green 2px";
			}
	}
}