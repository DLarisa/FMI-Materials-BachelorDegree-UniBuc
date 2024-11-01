var img=null;

window.onload=function()
{
	document.getElementById("lnk").onclick=function(e)
	{
		e.preventDefault();
		if(!img)
		{
			img=document.createElement("img");
			img.src=this.href;
			document.body.appendChild(img);
		}
		else
		{
			img.remove();
			img=null;
		}
	}
}