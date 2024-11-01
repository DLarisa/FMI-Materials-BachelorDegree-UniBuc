function numarRandom() {
    var r = Math.floor(Math.random() * 501);
    return r;
}

window.onload = function() {
    var btn = document.getElementById("res");
    btn.style.display = "block";
    var x;
    if (localStorage.getItem("suma") == null) {
        document.body.appendChild(document.createTextNode('0'));
        x = numarRandom();
        localStorage.setItem("suma", x);
    }
    else {
        var sum = localStorage.getItem("suma");
        x = numarRandom();
        document.body.appendChild(document.createTextNode("\n" + sum));
        localStorage.setItem("suma", parseInt(sum) + x);
    }
    btn.onclick = function() {
        localStorage.clear();
    }
    
    
}