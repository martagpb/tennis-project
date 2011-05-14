

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
   
