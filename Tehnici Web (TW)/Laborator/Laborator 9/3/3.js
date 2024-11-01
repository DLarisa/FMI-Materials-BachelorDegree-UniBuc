window.onload=function()
{
	var ch1=document.createElement("input");
	ch1.type="checkbox";
	document.body.appendChild(ch1);
	var ch2=document.createElement("input");
	ch2.type="checkbox";
	document.body.appendChild(ch2);
	
	ch1.checked=true;
	ch1.onchange=function()
	{ch2.checked=!ch2.checked;}
	ch2.onchange=function()
	{ch1.checked=!ch1.checked;}
}