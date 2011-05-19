/*
-- -----------------------------------------------------------------------------
--		Type   : Fichier javascript
--      Projet : BD50
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 18/05/2011
-- -----------------------------------------------------------------------------
*/

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
		return false
	}
	else if(password.value.length!=8){
		document.getElementById("passwordText").innerHTML ="Le mot de passe doit faire 8 caract�res";
		return false
	}
	return true;
}

function verifiermail(mail) {
   return (mail.indexOf("@")>=0)&&(mail.indexOf(".")>=0);
}

/*Fonction permettant de valider la s�lection d'un cr�neau horaire*/
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
