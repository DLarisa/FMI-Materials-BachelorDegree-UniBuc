function randInt(a,b)
{
	return Math.trunc(a+(b-a)*Math.random());
}


var vPrenume=["Costica", "Gigel", "Dorel", "Maricica", "Dorica", "Gigileana", "Crinisoara", "Zoe", "Gogu", "Bob"];
var vPrefixeNume=["Bubul", "Bondar", "Dudul", "Gogul", "Zumzul"];
var vSufixeNume=["ache", "escu", "esteanu","eanu", "eschi"];
var grupe=["A", "B", "C", "D"];


function noteRandom()
{
	var nrNote=randInt(1,5);
	var note=[];
	for(let i=0;i<nrNote;i++)
	{
		note.push(randInt(1,11));
	}
	return note;
}


function elevRandom()
{
	return{
		prenume: vPrenume[randInt(0, vPrenume.length)],
		nume: vPrefixeNume[randInt(0, vPrefixeNume.length)]+vSufixeNume[randInt(0, vSufixeNume.length)],
		grupa: grupe[randInt(0, grupe.length)],
		note: noteRandom()
	};
}
function genereazaElevi(n)
{
	var elevi=[];
	for(let i=0; i<n; i++)
	{
		elevi.push(elevRandom());
	}
	console.log(elevi);
	return elevi;
}

function creeazaRand(tipCelula, vector)
{
	var tr=document.createElement("tr"); //TO DO sa se creeze un rand
	for(x of vector)
	{
		var celula=document.createElement(tipCelula);
		celula.innerHTML = x; //TO DO continutul celulei trebuie sa fie valoarea din vector
		tr.appendChild(celula);// TO DO adaugati celula in rand
	}
	return tr;
}

function creeazaTabel(elevi)
{
	if(!elevi || elevi.length==0) return;
	
	var tabel=document.createElement("table");
	tabel.id="tab";
	var thead=document.createElement("thead");// TO DO - creare thead
	tabel.appendChild(thead); // TO DO - adugare thead in tabel (aici e variabila, nu tipul de date)
	var rand=creeazaRand("th", Object.keys(elevi[0])); //daca apelez cu numele clasei, metoda statica
	console.log("Proprietati:"); console.log(Object.keys(elevi[0]));
	thead.appendChild(rand);
		
	
	var tbody=document.createElement("tbody");
	tabel.appendChild(tbody);
	for(elev of elevi) //TO DO vrem ca variabila elev sa aiba pe rand ca valoare fiecare element din elevi
	{
		rand=creeazaRand("td", Object.values(elev));
		console.log("Valori:"); console.log(Object.values(elev));
		tbody.appendChild(rand);
		rand.classList.add(elev.grupa);//clasa sa fie egala cu clasa elevului
		
		//2
		rand.onclick=function(e)
		{
			if(e.ctrlKey)
			{
				this.remove(); //nu rand pt ca mereu va sterge ultimul rand
				printLog("Am șters un elev.");
			}
			else
			{
				this.classList.toggle("selectat");
				if(this.classList.contains("selectat")) printLog("Elev Selectat");
				else printLog("Elev Deselectat");
			}
		}
	}
	return tabel;
}

window.onload=function()
{
	var v_elevi=genereazaElevi(10);
	document.getElementById("container_tabel").appendChild(creeazaTabel(v_elevi));
	//5
	document.getElementById("add_inceput").onclick=function()
	{
		var rand=creeazaRand("td", Object.values(elevRandom()));
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //getElementsByTagName=colectia de taguri tbody din tabel si din ea luam primul element (si unicul in cazul nostru), cel de pe pozitia [0]
		tbody.insertBefore(rand, tbody.firstChild);
	}
	//6
	document.getElementById("add_sfarsit").onclick=function()
	{
		var rand=creeazaRand("td", Object.values(elevRandom()));
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //getElementsByTagName=colectia de taguri tbody din tabel si din ea luam primul element (si unicul in cazul nostru), cel de pe pozitia [0]
		tbody.appendChild(rand);
	}
	//7
	document.getElementById("deselectare").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //getElementsByTagName=colectia de taguri tbody din tabel si din ea luam primul element (si unicul in cazul nostru), cel de pe pozitia [0]
		var randuri=tbody.getElementsByClassName("selectat"); //aceasta colectie dinamica se updateaza pe masura ce sterg elemente 
		while(randuri.length>0) randuri[0].classList.remove("selectat");
		/*
		sau var randuri=tbody.querySelectorAll(".selectat") --da un vector care nu se mai actualizeaza
		for(let i=0; i<randuri.length; i++) randuri[i].classList.remove("selectat");
		*/
	}
	//7 - sau
	document.getElementById("deselectare").onclick=deselectare;
	function deselectare()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //getElementsByTagName=colectia de taguri tbody din tabel si din ea luam primul element (si unicul in cazul nostru), cel de pe pozitia [0]
		var randuri=tbody.getElementsByClassName("selectat"); //aceasta colectie dinamica se updateaza pe masura ce sterg elemente 
		while(randuri.length>0) randuri[0].classList.remove("selectat");
	}
	//8
	document.getElementById("sterge").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; 
		do
		{
			var rasp=prompt("Clasa?");
		}while(grupe.indexOf(rasp)==-1);
		deselectare();
		var elevi=tabel.querySelectorAll(rasp);
		for(el of elevi)
		{
			el.classList.add("selectat");
		}
		var conf=confirm("Șterge?");
		if(conf)
		{
			for(el of elevi) el.remove();
		}
	}
	//9
	document.getElementById("sorteaza_nume").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //am un singur tbody in tabel
		v_tr=Array.prototype.slice.call(tbody.children); //tbody.children=toti copii lui tbody si nu e vector; array ca sa devina array si sa putem sorta
		v_tr.sort(function(a, b)
		{
			return (a.children[1].innerHTML+a.children[0].innerHTML).localeCompare(b.children[1].innerHTML+b.children[0].innerHTML);
		});
		//appendChild=muta nodul(daca nodul deja exista) la finalul containerului
		for(tr of v_tr)
		{
			tbody.appendChild(tr);
		}
	}
	//10
	document.getElementById("sorteaza_medie").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //am un singur tbody in tabel
		v_tr=Array.prototype.slice.call(tbody.children);
		v_tr.sort(function(a, b)
		{
			note_a=a.children[3].innerHTML.split(",");
			note_b=b.children[3].innerHTML.split(",");
			//cum sa facem suma 
			sum_a=note_a.reduce(function (total, num) 
			{
				return parseInt(total) + parseInt(num);
			});
			sum_b=note_b.reduce(function (total, num) 
			{
				return parseInt(total) + parseInt(num);
			});
			media_a=sum_a/note_a.length;
			media_b=sum_b/note_b.length;
			return media_a-media_b;
		});
		for(tr of v_tr)
		{
			tbody.appendChild(tr);
		}
	}
	//11
	document.getElementById("gaseste_elev").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //am un singur tbody in tabel
		v_tr=Array.prototype.slice.call(tbody.children);
		var prenume=prompt("Prenume: ");
		indice=v_tr.findIndex(function(a)
		{
			return a.children[0].innerHTML==prenume;
		});
		if(indice!=-1) alert(indice+1);
		else alert("NU!");
	}
	//12
	document.getElementById("inverseaza").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //am un singur tbody in tabel
		v_tr=Array.prototype.slice.call(tbody.children);
		for(let i=v_tr.length-1; i>=0; i--)
		{
			tbody.appendChild(v_tr[i]);
		}
	}
	//13
	document.getElementById("goleste_tabel").onclick=function()
	{
		var tabel=document.getElementById("tab");
		var tbody=tabel.getElementsByTagName("tbody")[0]; //am un singur tbody in tabel
		tbody.innerHTML=" ";
	}
}

nrLog=0;
//3
function printLog(logtext)
{
	var info=document.getElementById("info");
	var p=document.createElement("p");
	p.innerHTML='['+(new Date())+']'+logtext;
	info.appendChild(p);
	//4
	nrLog++;
	info.title=nrLog;
	
	//15
	info.scrollTop=info.scrollHeight;
}


//14
window.onkeypress=function(e)  //cand apas tasta, se declanseaza evenimentul e 
{
	var cod=e.charCode ? e.charCode : e.keyCode;
	var tasta=String.fromCharCode(cod).toUpperCase(); //transforma in litera mare -> toUpperCase
	var ind=grupe.findIndex(function(a)
	{
		return a==tasta;
	});
	if(ind==-1) return;
	//conversia inversa "a".charCodeAt(0)
	
	var tabel=document.getElementById("tab");
	var tbody=tabel.getElementsByTagName("tbody")[0];
	v_tr=tbody.querySelectorAll(".selectat");
	for(rand of v_tr)
	{
		for(gr of grupe) rand.classList.remove(gr);
		rand.classList.add(tasta);
		rand.children[2].innerHTML=tasta;
	}
}
