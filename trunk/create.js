/*
-- -----------------------------------------------------------------------------
--		Type   : Fichier javascript
--      Projet : BD50
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
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
		document.getElementById("passwordText").innerHTML ="Le mot de passe doit faire 8 caractères";
		return false
	}
	return true;
}

function verifiermail(mail) {
   return (mail.indexOf("@")>=0)&&(mail.indexOf(".")>=0);
}

/*Fonction permettant de valider la sélection d'un créneau horaire*/
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
