var litera=null;

window.onkeydown=function(e)
{
	var tasta=e.key;
	if(!litera) //litera nu exista, deci tb sa o creez
	{	
		litera=document.createElement("div");
		document.body.appendChild(litera);
		litera.style.fontSize="10px";
		litera.innerHTML=tasta;
	}
	else
		litera.style.fontSize=(parseInt(litera.style.fontSize)+1)+"px";
}

window.onkeyup=function()
{
	if(litera)
	{
		litera.remove();
		litera=null;
	}
}