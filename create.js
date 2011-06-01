/*------------------------------------------------------------
|	   Type   : Fichier javascript							  |
|      Projet : BD50										  |
|      Auteur : Gonzalves / Invernizzi / Joly / Leviste	      |
|      Date de dernière modification : 23/05/2011		      |
-------------------------------------------------------------*/

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

/*Fonction permettant de déterminer si un utilisateur confirmer son choix*/
function confirmerChoix(form,document){
  if (confirm("Confirmez-vous votre décision ?")) {
    return true;
  }
   return false;
}

/*Fonction permettant de déterminer si un utilisateur confirmer son choix*/
function confirmerChoixLien(){
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

/*Fonction permettant de valider la création d'un entrainement*/
function validerEntrainement(form,document){

	//On récupère le libellé, le nombre de places et les dates de début de fin
	libEntrainement = form.vlibEntrainement.value; 
	nbPlaces = form.vnbPlaces.value;	  // nombre sous la forme : nn
	dateDebutDay=vdateDebutDay.value;     // nombre sous la forme : jj
	dateDebutMonth=vdateDebutMonth.value; // nombre sous la forme : mm
	dateDebutYear=vdateDebutYear.value;   // nombre sous la forme : aaaa
	dateFinDay=vdateFinDay.value;		  // nombre sous la forme : jj
	dateFinMonth=vdateFinMonth.value;     // nombre sous la forme : mm
	dateFinYear=vdateFinYear.value;		  // nombre sous la forme : aaaa
	
	//On vérifie que les informations du formulaire ont été saisies ou sélectionnées
	if(  
	     libEntrainement == null 
	 ||  libEntrainement == "" 
	){
		alert("Veuillez indiquer un libellé pour l'entrainement.");
		document.getElementById("vlibEntrainementError").innerHTML ="Le libellé pour l'entrainement est obligatoire.";	
		return false;
	}
	//Si toutes les informations obligatoires ont été saisies
	else{	
	
		document.getElementById("vlibEntrainementError").innerHTML ="";	
		//On vérifie la validité des dates sélectionnées (Existent-elles ?)
		
		//Construction de la date de début de l'entrainement
		var dateDebutEntrainement = new Date (dateDebutYear,(dateDebutMonth-1),dateDebutDay);		
		var dateDebutEntrainementValide = false;
		
		//Vérification de la validité de la date de début de l'entrainement
		if( 
		   (dateDebutEntrainement.getDate()     == dateDebutDay) 
		&& (dateDebutEntrainement.getMonth()+1  == dateDebutMonth) 
		&& (dateDebutEntrainement.getFullYear() == dateDebutYear)
		){
			dateDebutEntrainementValide = true;
			document.getElementById("vDateDebutEntrainementError").innerHTML ="";	
		}else{
			document.getElementById("vDateDebutEntrainementError").innerHTML ="La date de début de l'entrainement n'est pas une date valide.";		
		}
		
		//Construction de la date de fin de l'entrainement
		var dateFinEntrainement = new Date (dateFinYear,(dateFinMonth-1),dateFinDay);		
		var dateFinEntrainementValide = false;
		
		//Vérification de la validité de la date de fin de l'entrainement
		if( 
		   (dateFinEntrainement.getDate()     == dateFinDay) 
		&& (dateFinEntrainement.getMonth()+1  == dateFinMonth) 
		&& (dateFinEntrainement.getFullYear() == dateFinYear)
		){
			dateFinEntrainementValide = true;
			document.getElementById("vDateFinEntrainementError").innerHTML ="";
		}else{
			document.getElementById("vDateFinEntrainementError").innerHTML ="La date de fin de l'entrainement n'est pas une date valide.";
		}
						
		//Si l'une ou les deux dates sont invalides alors on affiche les messages d'erreurs
		if(dateDebutEntrainementValide==false || dateFinEntrainementValide==false ){
			return false;
		}
		//Sinon, si les deux dates sont valides on vérifie que la cohérence des dates
		//En effet, la date de début doit être inférieure ou égale à la date de fin
		else{
			//On compare les deux dates en récupérant le nombre de millisecondes écoulés depuis le 1er janvier 1970 pour chacune des deux dates
			var difference = dateDebutEntrainement.getTime() - dateFinEntrainement.getTime();
			
			//Si la différence est supérieure à 0 c'est que l'heure de début est supérieure à l'heure de fin du créneau
			if(difference > 0){
				document.getElementById("vDateDebutEntrainementError").innerHTML ="La date de début doit être inférieure ou égale à la date de fin.";
				document.getElementById("vDateFinEntrainementError").innerHTML ="La date de fin doit être supérieure ou égale à la date de début.";
				return false;
			}
			//Sinon, si la différence est négative ou égale à 0 alors les dates sont cohérentes. 
			//On met donc à jour les champs "hidden" du formulaire qui vont contenir les dates de début de de fin de l'entrainement
			else{
				var separateur = "/";		
				document.getElementById("idVdateDebut").value = dateDebutDay+separateur+dateDebutMonth+separateur+dateDebutYear;
				document.getElementById("idVdateFin").value = dateFinDay+separateur+dateFinMonth+separateur+dateFinYear;					
			}
		}		
	}
	return true;
}

/*Fonction permettant de valider la mise à jour d'un entrainement*/
function validerUpdEntrainement(form,document){

	//On récupère le libellé, le nombre de places et les dates de début de fin
	libEntrainement = form.vlibEntrainement.value; 
	nbPlaces = form.vnbPlaces.value;	  // nombre sous la forme : nn
	
	//On vérifie que les informations du formulaire ont été saisies ou sélectionnées
	if(  
	     libEntrainement == null 
	 ||  libEntrainement == "" 
	){
		alert("Veuillez indiquer un libellé pour l'entrainement.");
		document.getElementById("vlibEntrainementError").innerHTML ="Le libellé pour l'entrainement est obligatoire.";	
		return false;
	}
	return true;
}

/*Fonction permettant de valider la création d'un créneau*/
function validerCreneau(form,document){
  
  //Récupération des heures et minutes de début de fin du créneau
  heureDebutCreneau  = form.vheureDebut.value;
  minuteDebutCreneau = form.vminuteDebut.value;
  heureFinCreneau    = form.vheureFin.value;
  minuteFinCreneau   = form.vminuteFin.value;
    
  if(  
	       heureDebutCreneau == null 
	   ||  heureDebutCreneau == "" 
	   ||  minuteDebutCreneau == null 
	   ||  minuteDebutCreneau == "" 	   	  
	   ||  heureFinCreneau == "" 	   	   
	   ||  heureFinCreneau == "" 
	   ||  minuteFinCreneau == null 
	   ||  minuteFinCreneau == "" 
	){		
		alert("Veuillez remplir tous les champs obligatoires.");
		return false;
	}else{
		//Création de deux dates fictives pour comparer facilement le début et la fin du créneau
		var year   = 1970;
		var month  = 0;
		var day    = 0;
		var second = 0;
		
		var dateDebutCreneau = new Date ( year, month, day , heureDebutCreneau, minuteDebutCreneau, second );
		var dateFinCreneau = new Date ( year, month, day , heureFinCreneau, minuteFinCreneau, second );
		
		//On compare les deux dates en récupérant le nombre de millisecondes écoulés depuis le 1er janvier 1970 pour chacune des deux dates
		var difference = dateDebutCreneau.getTime() - dateFinCreneau.getTime();
		
		//Si la différence est supérieure ou égale à 0 c'est que l'heure de début est supérieure à l'heure de fin du créneau
		if(difference >= 0){
			document.getElementById("vheureDebutError").innerHTML ="L'heure de début doit être strictement inférieure à l'heure de fin.";
			document.getElementById("vheureFinError").innerHTML ="L'heure de fin doit être strictement supérieure à l'heure de début.";
			return false;
		}
		//Sinon, si la différence est négative alors le créneau est valide. On met donc à jour les champs "hidden" du formulaire qui vont contenir les heures du début et de fin du créneau
		else{
			var separateur = "h";
			document.getElementById("idVheureDebutCreneau").value = heureDebutCreneau+separateur+minuteDebutCreneau; 	
			document.getElementById("idVheureFinCreneau").value = heureFinCreneau+separateur+minuteFinCreneau;		 
		}
	}
	//On retroune vrai si le créneau est valide
	return true;
}

/*Fonction permettant de valider la création d'un créneau*/
function validerMAJCreneau(form,document){
  
  //Récupération des heures et minutes de début de fin du créneau
  heureDebutCreneau  = form.vheureDebut.value;
  minuteDebutCreneau = form.vminuteDebut.value;
  heureFinCreneau    = form.vheureFin.value;
  minuteFinCreneau   = form.vminuteFin.value;

  if(  
	       heureDebutCreneau == null 
	   ||  heureDebutCreneau == "" 
	   ||  minuteDebutCreneau == null 
	   ||  minuteDebutCreneau == "" 	   	  
	   ||  heureFinCreneau == null	   	   
	   ||  heureFinCreneau == "" 
	   ||  minuteFinCreneau == null 
	   ||  minuteFinCreneau == "" 
	){		
		alert("Veuillez remplir tous les champs obligatoires");
		return false;
	}else{
		//Création de deux dates fictives pour comparer facilement le début et la fin du créneau
		var year   = 1970;
		var month  = 0;
		var day    = 0;
		var second = 0;
		
		var dateDebutCreneau = new Date ( year, month, day , heureDebutCreneau, minuteDebutCreneau, second );
		var dateFinCreneau = new Date ( year, month, day , heureFinCreneau, minuteFinCreneau, second );
		
		//On comparaison les deux dates en récupérant le nombre de millisecondes écoulés depuis le 1er janvier 1970 pour chacune des deux dates
		var difference = dateDebutCreneau.getTime() - dateFinCreneau.getTime();
		
		//Si la différence est supérieure ou égale à 0 c'est que l'heure de début est supérieure à l'heure de fin du créneau
		if(difference >= 0){
			document.getElementById("vheureFinError").innerHTML ="L'heure de fin doit être strictement supérieure à l'heure de début.";
			return false;
		}
		//Sinon, si la différence est négative alors le créneau est valide. On met donc à jour le champ "hidden" du formulaire qui va contenir l'heure de fin du créneau
		else{
			var separateur = "h";	
			document.getElementById("idVheureFinCreneau").value = heureFinCreneau+separateur+minuteFinCreneau;		 
		}
	}
	//On retroune vrai si le créneau est valide
	return true;
}

/*Fonction permettant de valider l'ajout d'une nouvelle codification*/
function validerCodification(form,document){
  
  //Récupération des heures et minutes de début de fin du créneau
  code  = form.vcode.value;
  nature = form.vnature.value;
  libelle    = form.vlibelle.value;
    
  if(  
	       code == null 
	   ||  code == "" 
	   ||  nature == null 
	   ||  nature == "" 	
	){		
		alert("Veuillez remplir tous les champs obligatoires.");
		document.getElementById("vCodeError").innerHTML ="Le code est obligatoire.";
		document.getElementById("vNatureError").innerHTML ="La nature est obligatoire.";
		return false;
	}
	//On retroune vrai si la codification est valide
	return true;
}