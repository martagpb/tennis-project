/*
-- -----------------------------------------------------------------------------
--		Type   : Fichier javascript
--      Projet : BD50
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 21/05/2011
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
		document.getElementById("passwordText").innerHTML ="Le mot de passe doit faire 8 caract�res";
		return false;
	}
	return true;
}

function verifiermail(mail) {
   return (mail.indexOf("@")>=0)&&(mail.indexOf(".")>=0);
}

/*Fonction permettant de valider la cr�ation d'un cr�neau horaire*/
function validerCreneau(form,document){

	heureDebutCreneau = form.vheureDebutCreneau.value;
	
	if(heureDebutCreneau == null || heureDebutCreneau == ""){
		alert("Veuillez remplir le champ de l'heure de d�but du cr�neau.");
		return false;
	}
	
	//TODO : v�rifier que l'heure de d�but du cr�neau est strictement inf�rieure � l'heure de fin si elle existe.
		// Si heure de d�but strictement inf�rieure � heure de fin : OK ;
		// Si heure de d�but identique � heure de fin : false ;
		// Si heure de d�but strictement sup�rieure � heure de fin : inverser les heures de d�but et de fin.
		
	return true;
}

/*Fonction permettant de d�terminer si un utilisateur confirmer son choix*/
function confirmerChoix(form,document){
  if (confirm("Confirmez-vous votre d�cision ?")) {
    return true;
  }
   return false;
}

/*Fonction permettant de valider la cr�ation d'un terrain*/
function validerTerrain(form,document){

	libelleSurface = form.vlibelleSurface.value; // On r�cup�re : code, nature et libelle
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
		codeNatureLibelleArray = libelleSurface.split('*'); // On d�coupe la chaine
		
		//On extrait le code
		vCode = codeNatureLibelleArray[0];
		//On extrait la nature
		vNature = codeNatureLibelleArray[1];
		//On peut extraire le libelle si besoin
		//vLibelle = codeNatureLibelleArray[2];
		
		//On indique les bonnes valeurs dans les balises hidden qui correspondent � la nature et au code de la surface s�lectionn�e			
		document.getElementById("idVcodeSurface").value = vCode;		
		document.getElementById("idVnatureSurface").value = vNature;	
		//document.getElementById("vlibelleSurface").value = vLibelle;
	}
		
	return true;
}
