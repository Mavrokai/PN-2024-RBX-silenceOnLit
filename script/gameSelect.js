import { rightNumber } from "./rightNumber.js";
import { ticTacDoe } from "./ticTacDoe.js";

export function gameSelect() {
    //récupérer les  élèments dont on a besoin :
    const gameMenu = document.querySelector('#game-select');
    const gameZone = document.querySelector('.game-zone');

    
    //actions/fonctions à appliquer
    function gameChoice() {
       let choiceNumber = gameMenu.value;
       

       switch(choiceNumber) {
            case '3':
                reset();                
                ticTacDoe(gameZone);
                break;
            case '2':
                reset();
                rightNumber(gameZone);
                break;
            default:
                reset();
                break;
       }
            
    }

    function reset() {
        gameZone.innerHTML = "";
        gameZone.setAttribute("class", "game-zone");
    }

    //déclencheur

    gameMenu.addEventListener('change', gameChoice)    

}