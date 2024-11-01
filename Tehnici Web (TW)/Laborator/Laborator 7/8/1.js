window.onload=function()
{
	var nr=localStorage.getItem("accesari");
	if(!nr) nr=1;
	else nr=parseInt(nr)+1;
	localStorage.setItem("accesari", nr); //pt cheia "accesari" = nr
	document.body.appendChild(document.createTextNode(nr)); //Pt Proiect
	var buton=document.createElement("button");
	buton.innerHTML="ok";
	document.body.appendChild(buton);
	buton.onclick=function()
	{
		this.previousSibling.nodeValue=0; //pt TextNode -> nodeValue; altfel innerHTML
		localStorage.clear(); //sterge toate cheile
	}
}