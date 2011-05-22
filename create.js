/*
-- -----------------------------------------------------------------------------
--		Type   : Fichier javascript
--      Projet : BD50
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 21/05/2011
-- -----------------------------------------------------------------------------
*/

sfHover = function() {
             var sfEls = document.getElementsByTagName("li");
             for (var i=0; i<sfEls.length; i++) {
              sfEls[i].onmouseover = function() {
                this.className = this.className.replace(new RegExp(" sfhover"), "");
                this.className += " sfhover";
              }
              sfEls[i].onmouseout = function() {
                this.className = this.className.replace(new RegExp(" sfhover"), "");
              }
             }
        }
        if (window.attachEvent) window.attachEvent("onload", sfHover);

function valider(form,document){

	mail=form.mail.value;
	firstname=form.firstname.value;
	lastname=form.lastname.value;
	login=form.login.value;
	password=form.password.value;
	
	if(		mail== ""
		|| 	mail== null
		||	firstname== ""
		|| 	firstname== null 
		|| 	lastname== ""
		|| 	lastname== null
		||	login== ""
		|| 	login== null
		||	password== ""
		|| 	password== null) {			
		alert("Veuillez remplir tous les champs obligatoires");
		return false;
	}
	else if(!verifiermail(mail)){
		document.getElementById("mailText").innerHTML ="Format invalide";
		return false;
	}
	else if(password.value.length!=8){
		document.getElementById("passwordText").innerHTML ="Le mot de passe doit faire 8 caractères";
		return false;
	}
	return true;
}

function verifiermail(mail) {
   return (mail.indexOf("@")>=0)&&(mail.indexOf(".")>=0);
}

/*Fonction permettant de valider la création d'un créneau horaire*/
function validerCreneau(form,document){

	heureDebutCreneau = form.vheureDebutCreneau.value;
	
	if(heureDebutCreneau == null || heureDebutCreneau == ""){
		alert("Veuillez remplir le champ de l'heure de début du créneau.");
		return false;
	}
	
	//TODO : vérifier que l'heure de début du créneau est strictement inférieure à l'heure de fin si elle existe.
		// Si heure de début strictement inférieure à heure de fin : OK ;
		// Si heure de début identique à heure de fin : false ;
		// Si heure de début strictement supérieure à heure de fin : inverser les heures de début et de fin.
		
	return true;
}

/*Fonction permettant de déterminer si un utilisateur confirmer son choix*/
function confirmerChoix(form,document){
  if (confirm("Confirmez-vous votre décision ?")) {
    return true;
  }
   return false;
}

/*Fonction permettant de valider la création d'un terrain*/
function validerTerrain(form,document){

	libelleSurface = form.vlibelleSurface.value; // On récupère : code, nature et libelle
	actif = form.vactif.value;
	
	if(  
	     libelleSurface == null 
	   ||  libelleSurface == "" 
	   ||  actif == null 
	   ||  actif == "" 
	){
		alert("Veuillez remplir tous les champs obligatoires");
		return false;
	}else{		
	
		//On construit un tableau qui va contenir les 3 valeurs (code, nature et libelle)
		var codeNatureLibelleArray = new Array();
		codeNatureLibelleArray = libelleSurface.split('*'); // On découpe la chaine
		
		//On extrait le code
		vCode = codeNatureLibelleArray[0];
		//On extrait la nature
		vNature = codeNatureLibelleArray[1];
		//On peut extraire le libelle si besoin
		//vLibelle = codeNatureLibelleArray[2];
		
		//On indique les bonnes valeurs dans les balises hidden qui correspondent à la nature et au code de la surface sélectionnée			
		document.getElementById("idVcodeSurface").value = vCode;		
		document.getElementById("idVnatureSurface").value = vNature;	
		//document.getElementById("vlibelleSurface").value = vLibelle;
	}
		
	return true;
}
