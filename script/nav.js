export function navFunction() {
    function navFunction() {}//On va récupérer les éléments html dont on va se servir
    let bouton = document.querySelector('#burger-button');
    let menu = document.querySelector('nav');
    let isDown = false;
    
    //Définir les fonctions/actions qui vont être utilisées

    function navDown () {
        if(isDown) {
            menu.style.top = "-30vh";
            setTimeout(()=>{isDown = false}, 1200)

            
        } else {
            menu.style.top = "33vh";
            setTimeout(()=>{isDown = true}, 1200)
        }
        
    }
    //mettre en places les déclencheurs des actions

    bouton.addEventListener('click', navDown);
}