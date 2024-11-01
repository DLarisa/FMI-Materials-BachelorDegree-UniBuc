window.onkeydown = function(e)
{
	if(e.key=='d')
	{
		var d = new Date();
		
		var x = d.getDay();
		if(x==0) x="Duminica";
		else if(x==1) x="Luni";
		else if(x==2) x="Marti";
		else if(x==3) x="Miercuri";
		else if(x==4) x="Joi";
		else if(x==5) x="Vineri";
		else if(x==6) x="Sambata";
		
		var l = d.getMonth() + 1;
		var an = d.getFullYear() % 100;
		x = x + "." + l + "." + an; 
		
		var input = document.getElementById("data");
		input.value = x;
	}
}