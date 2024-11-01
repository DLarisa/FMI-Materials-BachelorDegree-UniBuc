window.onkeypress = function (e) {
    if (e.key >= 0 && e.key <= 9) {
        let ps = document.querySelectorAll("p");
        for (let p of ps) {
            if (p.innerText.split(' ').length > e.key) {
                document.body.removeChild(p);
                // console.log("deleting" + p.innerText);
            }
        }
    }

}