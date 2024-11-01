window.onload = function() {
    let input = document.getElementById("nrp");
    input.addEventListener("focusout", function() {
        if(isNaN(parseInt(this.value)))
            return;
        this.interval = setInterval(function(input) {
            let no = document.querySelectorAll("p").length + 1;
            if (no >= input.value) {
                clearInterval(input.interval);
                return;
            }
            let p = document.createElement("p");
            p.innerText = no;
            document.body.appendChild(p);
            p.onclick = function() {
                clearInterval(input.interval);
                setTimeout(function(value) {
                    alert(value);
                }, 2000, document.querySelectorAll("p").length)
            }
        }, 500, this)
    })
}