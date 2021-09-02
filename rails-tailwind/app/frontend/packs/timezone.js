import * as jstz from 'jstz';

function setCookie(name, value) {
  const expires = new Date();
  expires.setTime(expires.getTime() + 24 * 60 * 60 * 1000);
  document.cookie = `${name}=${value};expires=${expires.toUTCString()};SameSite=Strict`;
}

const timezone = jstz.determine();
console.log(timezone.name());
setCookie('timezone', timezone.name());
