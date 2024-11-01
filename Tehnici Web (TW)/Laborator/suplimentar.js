window.onload=function()
{
	var ol=document.createElement("ol");
	ol.id="lista";
	document.body.appendChild(ol);
	ol.innerHTML=localStorage.getItem("continut") ? localStorage.getItem("continut") : " ";
	btn=document.getElementById("buton");
	btn.onclick=function()
	{
		var valoare=document.getElementById("textbox").value;
		var ol=document.getElementById("lista");
		ol.innerHTML+=`<li>${valoare}</li>`;
		localStorage.setItem("continut", ol.innerHTML);
	}
	
}