window.onload=function()
{
	document.getElementById("rng").onchange=function()
	{
		document.body.style.fontSize=this.value+"px";
		if (this.value>= parseInt(this.min)+(this.max-this.min)/2)  document.body.style.color="red";
		else                                                        document.body.style.color="black";
	}
	
	var rdbtn=document.querySelectorAll("input[type=radio]");
	for (rb of rdbtn) rb.name="r";
	document.getElementById("btn").onclick=function()
	{
		var v_rad=document.getElementsByName("r");
		for (rad of v_rad)
			if(rad.checked)
				this.innerHTML=rad.nextSibling.nodeValue;
	}
}