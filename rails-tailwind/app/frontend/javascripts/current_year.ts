// Set current year
document.addEventListener('DOMContentLoaded', () => {
    let currentYearTag = document.getElementById("current_year");
    currentYearTag.innerHTML = String(new Date().getFullYear());
});