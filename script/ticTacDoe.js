/**
 * Affiche et gère un jeu de morpion, le plus beau jeu du monde
 * 
 * @param {HTMLElement} zone Zone dans laquelle va s'afficher le jeu 
 */
export function ticTacDoe(zone) 
{
    //Déclaration des variables globales
    let infoZone;
    let gridZone;
    let squares = [];
    let isActive = [];
    let playerOne = true;

    //une fonction pour initiatliser le jeu

    function ttdInit() {
        zone.classList.add('ttd-zone');

        infoZone = document.createElement('div');
        infoZone.classList.add('info-zone', 'apparence-zone');
        infoZone.style.width = '30%';

        zone.appendChild(infoZone);

        gridZone = document.createElement('div');
        gridZone.classList.add('grid-zone', 'apparence-zone');
        gridZone.style.width = '55%';        

        zone.appendChild(gridZone);

        for(let i = 0; i<9; i++) {
            let square = document.createElement('div');
            square.classList.add('square');
            squares.push(square);
            isActive.push(true);

            gridZone.appendChild(square);
        }

        for(let i=0; i<squares.length; i++) {
            squares[i].addEventListener('click', squareClick.bind(squares[i],i));
        }

        console.log(squares);
    }

    //une fonction pour gérer le clic sur les cases

    function squareClick(i) {
        if(isActive[i]) {
            if(playerOne) {
                this.style.backgroundImage = 'url(../assets/eddard.png)';
                
            } else {
                this.style.backgroundImage = 'url(../assets/cersei.png)';
            }
            
            playerOne = !playerOne;
            isActive[i] = false;
            
        }
        
    }
    //une fonction pour la fin de jeu

    function gameOver() {

    }
    //on lance la fonction d'initialisation pour lancer le jeu
    
    ttdInit();
}