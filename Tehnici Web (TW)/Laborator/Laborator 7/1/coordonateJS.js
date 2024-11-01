window.onmousedown=function(e)
{
	var dv=document.createElement("div");
	document.body.appendChild(dv);
	dv.style.border="1px solid black";
	dv.style.position="absolute";
	dv.style.top=dv.style.left="0"; //doar la 0 pot sa nu pun unitatea de masura
	dv.style.width=e.clientX+"px";
	dv.style.height=e.clientY+"px";
	if(e.shiftKey) dv.style.backgroundColor="red";
	else dv.style.backgroundColor="blue";
	dv.id="dreptunghi";
}

window.onmouseup=function(e)
{
	var dv=document.getElementById("dreptunghi");
	if(dv) //returneaza null daca nu exista dv
		dv.remove();
}