
const showMenu = (toggleId, navbarId, bodyId) => {
    const toggle = document.getElementById(toggleId),
    navbar = document.getElementById(navbarId),
    bodypadding = document.getElementById(bodyId)

    if(toggle && navbar){
        toggle.addEventListener('click', ()=>{
            navbar.classList.toggle('show')
            toggle.classList.toggle('rotate')
            bodypadding.classList.toggle('expander')
        })
    }
}
showMenu('nav-toggle', 'navbar', 'body')

// get ra cac id name = nav-link
const linkColor = document.querySelectorAll('.nav-link');

// hien cai da click
function colorLink(){
    linkColor.forEach(l => l.classList.remove('active'))
    this.classList.add('active')
}

linkColor[0].classList.add('active');
linkColor.forEach(l => l.addEventListener('click', colorLink))

// test
const homeIcon = document.getElementById('home-icon');
const userIcon = document.getElementById('user-icon');
const priceIcon = document.getElementById('price-icon');
const noteIcon = document.getElementById('note-icon');
const rateIcon = document.getElementById('rate-icon');
const deliveryIcon = document.getElementById('delivery-icon');

const homePage = document.getElementById('home-page');
const userPage = document.getElementById('user-page');
const pricePage = document.getElementById('price-page');
const notePage = document.getElementById('note-page');
const ratePage = document.getElementById('rate-page');
const deliveryPage = document.getElementById('delivery-page');

window.addEventListener('DOMContentLoaded', function(){
    homePage.classList.add('active-page');
});

homeIcon.addEventListener('click', function(){
    homePage.classList.add('active-page');
    userPage.classList.remove('active-page');
    pricePage.classList.remove('active-page');
    notePage.classList.remove('active-page');
    ratePage.classList.remove('active-page');
    deliveryPage.classList.remove('active-page');
});

userIcon.addEventListener('click', function(){
    homePage.classList.remove('active-page');
    userPage.classList.add('active-page');
    pricePage.classList.remove('active-page');
    notePage.classList.remove('active-page');
    ratePage.classList.remove('active-page');
    deliveryPage.classList.remove('active-page');
});

priceIcon.addEventListener('click', function(){
    homePage.classList.remove('active-page');
    userPage.classList.remove('active-page');
    pricePage.classList.add('active-page');
    notePage.classList.remove('active-page');
    ratePage.classList.remove('active-page');
    deliveryPage.classList.remove('active-page');
});

noteIcon.addEventListener('click', function(){
    homePage.classList.remove('active-page');
    userPage.classList.remove('active-page');
    pricePage.classList.remove('active-page');
    notePage.classList.add('active-page');
    ratePage.classList.remove('active-page');
    deliveryPage.classList.remove('active-page');
});

rateIcon.addEventListener('click', function () {
    homePage.classList.remove('active-page');
    userPage.classList.remove('active-page');
    pricePage.classList.remove('active-page');
    notePage.classList.remove('active-page');
    ratePage.classList.add('active-page');
    deliveryPage.classList.remove('active-page');
});

deliveryIcon.addEventListener('click', function () {
    homePage.classList.remove('active-page');
    userPage.classList.remove('active-page');
    pricePage.classList.remove('active-page');
    notePage.classList.remove('active-page');
    ratePage.classList.remove('active-page');
    deliveryPage.classList.add('active-page');
});

