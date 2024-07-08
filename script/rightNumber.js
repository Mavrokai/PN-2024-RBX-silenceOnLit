/**
 * Jeu qui s'affiche sur une page web et qui consiste à deviner un nombre
 * @param {HTMLElement} zone zone dans laquelle s'affiche le jeu
 */
export function rightNumber(zone) {

    let propositionZone;
    let validateButton;
    let targetNumber;    
    let count;

   /**
    * Initialisation de la zone de jeu
    */ 
   function numberInit() {
        zone.classList.add('apparence-zone', 'number-zone');
        zone.innerHTML = '<div class="numberChoice"><label for="userProposition">choisissez un nombre entre 1 et 100</label><input type="number" id="userProposition"><input type="submit" value="Valider" id="validate"></div>'

        propositionZone = document.querySelector("#userProposition");
        validateButton = document.querySelector("#validate");
        targetNumber = Math.floor(Math.random()*100+1);
        count = 1;

        validateButton.addEventListener('click', verifyNumber);        
    }

    /**
     * Vérification de la proposition du joueur
     */
    function verifyNumber() {
       
        let userNumber = parseInt(propositionZone.value);
        //on un élément html dans une variable :
        let resZone = document.createElement('p')//on peut créer n'importe quelle balise
        //on va lui ajouter une classe
        resZone.classList.add('responseLine');

        //Ajouter du vontenu text à la balise
        if(isNaN(userNumber)) 
        {
            resZone.innerHTML = `${count} - n'est pas un nombre`;
            resZone.style.color = "red";
        } 
        else if (userNumber>targetNumber)
        {
            resZone.innerHTML = `${count} - ${userNumber} est trop grand`;  
        } 
        else if(userNumber<targetNumber) 
        {
            resZone.innerHTML = `${count} - ${userNumber} est trop petit`; 
        } 
        else 
        {
            resZone.innerHTML = `${count} - Bravo, vous avez trouvé le nombre ${userNumber}`; 
            gameOver();
        }
        count++;
        propositionZone.value="";

        //on l'ajoute page - 
        zone.appendChild(resZone);
        
   }

   function gameOver() {
        let userInterface = document.querySelector('.numberChoice');
        userInterface.innerHTML ="";

        let resetButton = document.createElement('button');
        resetButton.innerHTML ="Recommencer";
        resetButton.style.padding = "5px 30px"
        resetButton.addEventListener('click', numberInit);

        userInterface.appendChild(resetButton);
    }

    numberInit();

}