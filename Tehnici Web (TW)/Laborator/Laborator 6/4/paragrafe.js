window.onload=function()
{
	document.getElementById("albastreste").onclick = albastreste;
	
}

function albastreste()
{
	pgfs=document.querySelectorAll("p");
	for(pg of pgfs)
	{
		var stil=getComputedStyle(pg);
		if(stil.color=="rgb(255, 0, 0)")
			pg.style.color="blue";
	}
	
	/*
	//de observat si apoi de comentat
	alert(pgfs[0].style.color)
	pgfs[0].style.color="blue"
	alert(pgfs[0].style.color)
	*/
}