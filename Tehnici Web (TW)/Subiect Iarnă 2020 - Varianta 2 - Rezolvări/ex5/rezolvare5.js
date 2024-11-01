window.onload = function () {
    let divs = document.querySelectorAll("div");
    for (div of divs) {
        div.onmousemove = function (e) {
            e.stopPropagation();
        }
    }
    window.onmousemove = function (e) {
        let udiv = 0;
        for (div of divs) {
            let style = this.getComputedStyle(div);
            if (e.clientY > parseInt(style.top) + this.parseInt(style.height) && e.clientX >= this.parseInt(style.left) && e.clientX < parseInt(style.left) + parseInt(style.width)) {
                if(udiv == 0 || style.top > this.getComputedStyle(udiv).top)
                    udiv = div;
            }
        }
        let d = new Date();
        udiv.innerText = d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds();
    }
}