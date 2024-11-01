window.onload = function() {
    document.getElementById("intregi").onchange = function() {
        let options = document.querySelectorAll("#numere > option");
        if(this.checked == true) {
            for(option of options) {
                if(parseInt(option.innerText) != option.innerText * 10 / 10)
                    option.style.display = "none";
            }
        } else {
            for(option of options) {
                option.style.display = "initial";
            }
        }
    }
}