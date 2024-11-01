 window.onload = function() {
     let button = document.getElementById("res");
     let ps = document.querySelectorAll("p");
     let last = sessionStorage.getItem("last")?sessionStorage.getItem("last"):-1;
     if(last != -1) 
        ps[last].style.color = "red";
     for(let id = 0; id< ps.length; ++id)
        ps[id].onclick = function() {
            sessionStorage.setItem("last", id);;
            this.style.color = "red";
        }
    button.onclick = function() {
        sessionStorage.removeItem("last");
        location.reload();
    }
 }