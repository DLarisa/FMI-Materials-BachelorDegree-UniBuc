
function format2Cifre(nr){
	return (nr<10)? "0"+nr : ""+nr
}

function sirOra()
{
	d = new Date(); //data curenta
	hh=format2Cifre(d.getHours());
	mm=format2Cifre(d.getMinutes());
	ss=format2Cifre(d.getSeconds());
	ms=d.getMilliseconds();
	return `${hh}:${mm}:${ss} ${ms}`;
	
}

var idInterval=-1, idTimeout=-1, idTimeoutRec=-1

window.onload=function()
{
	var butonInterval=document.querySelectorAll("#interval button")[0];
	var butonTimeout=document.querySelectorAll("#timeout button")[0];
	var butonTimeoutRec=document.querySelectorAll("#timeout_rec button")[0];

	var opresteInterval=document.querySelectorAll("#interval button")[1];
	var opresteTimeout=document.querySelectorAll("#timeout button")[1];
	var opresteTimeoutRec=document.querySelectorAll("#timeout_rec button")[1];	
	
	butonInterval.onclick=function()
	{
		if(idInterval==-1) 
			idInterval=setInterval(afisInDiv, 1000, this.nextElementSibling.nextElementSibling);
	}
	butonTimeout.onclick=function()
	{
		if(idTimeout==-1) 
			idTimeout=setTimeout(afisInDiv, 1000, this.nextElementSibling.nextElementSibling);
	}
	function t_rec(dv)
	{
		afisInDiv(dv);
		idTimeoutRec=setTimeout(t_rec, 1000, dv); //1000 milisecunde = 1 sec
	}
	butonTimeoutRec.onclick=function()
	{
		t_rec(this.nextElementSibling.nextElementSibling);
	}	

	opresteInterval.onclick=function()
	{
		if(idInterval!=-1) 
		{
			clearInterval(idInterval);
			idInterval=-1;
		}
	}
	opresteTimeout.onclick=function()
	{
		if(idTimeout!=-1) 
		{
			clearTimeout(idTimeout);
			idTimeout=-1;
		}
	}
	
	opresteTimeoutRec.onclick=function()
	{
		if(idTimeoutRec!=-1) 
		{
			clearTimeout(idTimeoutRec);
			idTimeoutRec=-1;
		}
	}	
}

function afisInDiv(dv)
{
	dv.innerHTML+=sirOra() +"<br/>"
	dv.scrollTop=dv.scrollHeight; //ca sa fie mereu "scrollat" in jos
}