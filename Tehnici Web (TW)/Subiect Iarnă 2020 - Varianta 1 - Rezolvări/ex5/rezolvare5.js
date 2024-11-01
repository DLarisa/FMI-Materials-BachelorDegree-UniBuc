window.onload = function()
{
	document.onmousemove = function()
	{
		var x = event.clientX;     
		var y = event.clientY;  
	
		var divuri = document.getElementsByTagName("div");
		for(d of divuri)
		{
			var stil = getComputedStyle(d);
			if(x <= parseInt(stil.left)) d.style.backgroundColor = "blue";
			else d.style.backgroundColor = "red";
			
			d.onmouseover = function()
			{
				this.style.backgroundColor = "purple";
			}
		}
	}
}