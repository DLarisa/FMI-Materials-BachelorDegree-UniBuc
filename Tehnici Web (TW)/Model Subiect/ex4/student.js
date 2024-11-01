window.onkeydown=function(e)
{
	var elem=document.getElementsByClassName("d1");
	if(e.key=='q') pas=1;
	if(e.key=='w') pas=-1;
	for(i of elem)
	{
		var inaltime=parseInt(getComputedStyle(i).height);
		inaltime=Math.max(inaltime+pas,0);
		i.style.height=inaltime+"px";
	}
}