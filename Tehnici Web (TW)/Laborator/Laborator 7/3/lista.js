window.onload=function()
{
	var lst=document.getElementById("lista");
	for(li of lst.children)
	{
		li.onclick=function()
		{
			this.style.color="green";
			li_p=this;
			while(li_p)
			{
				li_p=li_p.previousElementSibling;
				if(li_p) li_p.style.color="red";
			}
			li_p=this;
			while(li_p)
			{
				li_p=li_p.nextElementSibling;
				if(li_p) li_p.style.color="blue";
			}
		}
	}
}