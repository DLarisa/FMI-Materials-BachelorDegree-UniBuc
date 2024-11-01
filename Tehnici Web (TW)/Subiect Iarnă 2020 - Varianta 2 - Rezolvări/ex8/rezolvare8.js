window.onload = function() {
    let elem = document.getElementsByClassName("abc");
    for(e of elem) {
        if(e.classList.length == 2)
            for(cls of e.classList)
                if(cls != "abc")
                    e.classList.remove(cls);
    }
    document.body.onclick = function() {
        let all = document.querySelectorAll("*");
        for(el of all) {
            for(cls of el.classList) {
                if(cls.search(/[0-9]/) != -1) {
                    el.classList.add("numar");
                    break;
                }
            }
        }
    }
}