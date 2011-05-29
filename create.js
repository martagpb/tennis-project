/*------------------------------------------------------------
|	   Type   : Fichier javascript							  |
|      Projet : BD50										  |
|      Auteur : Gonzalves / Invernizzi / Joly / Leviste	      |
|      Date de derni�re modification : 23/05/2011		      |
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
		document.getElementById("passwordText").innerHTML ="Le mot de passe doit faire 8 caract�res";
		return false;
	}
	return true;
}

function verifiermail(mail) {
   return (mail.indexOf("@")>=0)&&(mail.indexOf(".")>=0);
}

/*Fonction permettant de d�terminer si un utilisateur confirmer son choix*/
function confirmerChoix(form,document){
  if (confirm("Confirmez-vous votre d�cision ?")) {
    return true;
  }
   return false;
}

/*Fonction permettant de d�terminer si un utilisateur confirmer son choix*/
function confirmerChoixLien(){
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

/*Fonction permettant de valider la cr�ation d'un entrainement*/
function test(form,document){
	alert("je suis pass� par le test");
	return false;
}


/*Fonction permettant de valider la cr�ation d'un entrainement*/
function validerEntrainement(form,document){

	libEntrainement = form.vlibEntrainement.value; // On r�cup�re : code, nature et libelle
	nbPlace= form.vnbPlaces.value;
	dateDebut=vdateDebut.value;
	date_fin=vdateFin.value;
	
	if(  
	     libEntrainement == null 
	   ||  libEntrainement == "" 
	   ||  nbPlace == null 
	   ||  nbPlace == "" 
	   ||  dateDebut == null 
	   ||  dateDebut == "" 
	   ||  date_fin == null 
	   ||  date_fin == "" 
	){
		alert("Veuillez remplir tous les champs obligatoires 1");
		return false;
		
	}else if(!validerDate(dateDebut)){
		return false;	
	}
	else if(!validerDate(dateFin)){
		return false;	
	}
	else if(nbPlace.value.length>2)||(nbPlace.value<1){
		alert("Veuillez saisir un nombre de place compris entre 1 et 99 2");
		return false;
	}
	else if(libEntrainement.length>50){
		alert("Veuillez saisir un libell� d'une taille maximale de 50 caract�res 3");
		return false;
	}
	else if (isNaN(nbPlace)==false){
			d.value=parseInt(nbPlace);
		}
		else{
			alert("Veuillez entrer une date correcte sous la forme 02/02/02 4");
			return false
	}	
	if(!coherenceDate(date1,date2){
		alert("Veuillez entrer des dates coh�rentes");
		return false
	}
	return true;
}

/*Fonction v�rifiant la validit� d'une date*/
function coherenceDate(date1,date2){
	tabChaine=date1.split('/')
	var day1=parseInt(tabChaine[0]);
	var month1=parseInt(tabChaine[1].split('/')[0]);
	var year1=parseInt(tabChaine[1].split('/')[1]);

	tabChaine=date2.split('/')
	var day2=parseInt(tabChaine[0]);
	var month2=parseInt(tabChaine[1].split('/')[0]);
	var year2=parseInt(tabChaine[1].split('/')[1]);
	
	if(year2<year1){
			return false
	}
	else if	(year2==year1)&&(month2<month1){
			return false
	}
		else if	(year2==year1)&&(month2==month1)&&(day2<day1){
			return false
	}
	return true;
}		

/*Fonction v�rifiant la validit� d'une date*/
function validerDate(date){

	tabChaine=date.split('/')
	var day=tabChaine[0];
	var month=tabChaine[1].split('/')[0];
	var year=tabChaine[1].split('/')[1];
	
	if(day.value.length!=2)||(month.value.length!=2)||(year.value.length!=2){	
		return false;
	}	
	if (isNaN(day)==false){
		d.value=parseInt(day);
	}
	else{
		return false;
	}
	if (isNaN(month)==false){
		d.value=parseInt(month);
	}
	else{
		return false;
	}
			if (isNaN(year)==false){
		d.value=parseInt(year);
	}
	else{
		return false;
	}
	
	if (isNaN(day)==false)||(isNaN(month)==false)||(isNaN(year)==false){
		return false;
	}
	
	return true;
}

/*Fonction permettant de valider la cr�ation d'un cr�neau*/
function validerCreneau(form,document){
  
  //R�cup�ration des heures et minutes de d�but de fin du cr�neau
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
		alert("Veuillez remplir tous les champs obligatoires");
		return false;
	}else{
		//Cr�ation de deux dates fictives pour comparer facilement le d�but et la fin du cr�neau
		var year   = 1970;
		var month  = 0;
		var day    = 0;
		var second = 0;
		
		var dateDebutCreneau = new Date ( year, month, day , heureDebutCreneau, minuteDebutCreneau, second );
		var dateFinCreneau = new Date ( year, month, day , heureFinCreneau, minuteFinCreneau, second );
		
		//On comparaison les deux dates en r�cup�rant le nombre de millisecondes �coul�s depuis le 1er janvier 1970 pour chacune des deux dates
		var difference = dateDebutCreneau.getTime() - dateFinCreneau.getTime();
		
		//Si la diff�rence est sup�rieure ou �gale � 0 c'est que l'heure de d�but est sup�rieure � l'heure de fin du cr�neau
		if(difference >= 0){
			document.getElementById("vheureDebutError").innerHTML ="L'heure de d�but doit �tre strictement inf�rieure � l'heure de fin.";
			document.getElementById("vheureFinError").innerHTML ="L'heure de fin doit �tre strictement sup�rieure � l'heure de d�but.";
			return false;
		}
		//Sinon, si la diff�rence est n�gative alors le cr�neau est valide. On met donc � jour les champs "hidden" du formulaire qui vont contenir les heures du d�but et de fin du cr�neau
		else{
			var separateur = "h";
			document.getElementById("idVheureDebutCreneau").value = heureDebutCreneau+separateur+minuteDebutCreneau; 	
			document.getElementById("idVheureFinCreneau").value = heureFinCreneau+separateur+minuteFinCreneau;		 
		}
	}
	//On retroune vrai si le cr�neau est valide
	return true;
}

/*Fonction permettant de valider la cr�ation d'un cr�neau*/
function validerMAJCreneau(form,document){
  
  //R�cup�ration des heures et minutes de d�but de fin du cr�neau
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
		alert("Veuillez remplir tous les champs obligatoires");
		return false;
	}else{
		//Cr�ation de deux dates fictives pour comparer facilement le d�but et la fin du cr�neau
		var year   = 1970;
		var month  = 0;
		var day    = 0;
		var second = 0;
		
		var dateDebutCreneau = new Date ( year, month, day , heureDebutCreneau, minuteDebutCreneau, second );
		var dateFinCreneau = new Date ( year, month, day , heureFinCreneau, minuteFinCreneau, second );
		
		//On comparaison les deux dates en r�cup�rant le nombre de millisecondes �coul�s depuis le 1er janvier 1970 pour chacune des deux dates
		var difference = dateDebutCreneau.getTime() - dateFinCreneau.getTime();
		
		//Si la diff�rence est sup�rieure ou �gale � 0 c'est que l'heure de d�but est sup�rieure � l'heure de fin du cr�neau
		if(difference >= 0){
			document.getElementById("vheureFinError").innerHTML ="L'heure de fin doit �tre strictement sup�rieure � l'heure de d�but.";
			return false;
		}
		//Sinon, si la diff�rence est n�gative alors le cr�neau est valide. On met donc � jour le champ "hidden" du formulaire qui va contenir l'heure de fin du cr�neau
		else{
			var separateur = "h";	
			document.getElementById("idVheureFinCreneau").value = heureFinCreneau+separateur+minuteFinCreneau;		 
		}
	}
	//On retroune vrai si le cr�neau est valide
	return true;
}