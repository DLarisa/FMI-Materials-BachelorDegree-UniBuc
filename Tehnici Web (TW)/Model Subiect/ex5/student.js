window.onclick=function()
{
	var buton=document.createElement("div");
	buton.setAttribute("class", "animat");
	buton.style.position="absolute";
	document.body.appendChild(buton);
	
	var x = event.clientX;
	var y = event.clientY;
	var aleator=Math.random();
	if(aleator<=0.5) buton.style.animationName="miscare1";
	else			 buton.style.animationName="miscare2";
	
	stil=getComputedStyle(buton);
	buton.style.top=y-parseInt(stil.height)/2+"px";
	buton.style.left=x-parseInt(stil.width)/2+"px";
	
	buton.onclick=function(e){e.stopPropagation()}
}