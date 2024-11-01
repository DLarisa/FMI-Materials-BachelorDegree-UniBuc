window.onload = function()
{
	var elemente = document.getElementsByTagName("*");
	for(el of elemente)
	{
		if(el.classList.length >= 3) el.classList.add("c3");
	}
	
	document.body.onclick = function()
	{
		for(el of elemente)
		{
			var cls = el.classList;
			for(i=0; i<cls.length; i++)
			{
				if(!cls[i].search('z'))
				{
					cls.remove(cls[i]);
					j--;
				}
			}
		}
	}
}