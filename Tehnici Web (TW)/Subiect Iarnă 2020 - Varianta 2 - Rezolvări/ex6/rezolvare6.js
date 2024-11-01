window.onload = function() {
    let pinxyz = this.document.querySelectorAll("div.xyz p");
    for(p of pinxyz) {
        console.log(p.children);
        if(p.children.length > 5) {
            let randomr = Math.random() * 255;
            let randomg = Math.random() * 255;
            let randomb = Math.random() * 255;
            p.style.border = "solid rgb(" + randomr + ',' + randomg + ',' + randomb + ") 2px";
        }
    }
}