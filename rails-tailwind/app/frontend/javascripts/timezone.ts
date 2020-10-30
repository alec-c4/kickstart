import * as jstz from "jstz";

function setCookie(name, value) {
    let expires = new Date();
    expires.setTime(expires.getTime() + (24 * 60 * 60 * 1000));
    document.cookie = name + '=' + value + ';expires=' + expires.toUTCString();
}

const timezone =jstz.determine();
console.log(timezone.name());
setCookie('timezone', timezone.name());