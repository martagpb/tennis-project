          -- -----------------------------------------------------------------------------
--            Cr�ation du corps du package pq_ui_create_account de la base de donn�es pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/5/2011
-- -----------------------------------------------------------------------------
 
 
CREATE OR REPLACE PACKAGE BODY pq_ui_create_account
IS  
	PROCEDURE formCreate 
	IS
	BEGIN	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Cr�ation d''un nouveau compte');
		htp.print('</div>');			
		htp.br;
		htp.print('Les champs marqu�s d''une �toile sont obligatoires');
		htp.br;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_create_account.create_account', 'POST', cattributes => 'onSubmit="return valider(this,document)"');
			htp.tableOpen(cattributes => 'CELLSPACING=8');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableRowOpen;
					htp.tableData('Nom * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('lastname',20));
					htp.tableData('',cattributes => 'id="lastnameText" class="error"');
				htp.tableRowClose;	
				htp.tableRowOpen;
					htp.tableData('Pr�nom * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('firstname',20));
					htp.tableData('',cattributes => 'id="firstnameText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Identifiant * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('login',20));
					htp.tableData('',cattributes => 'id="identifiantText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Mot de passe * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formPassword('password',20));
					htp.tableData('',cattributes => 'id="passwordText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse mail * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('mail',20));
					htp.tableData('',cattributes => 'id="mailText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('T�l�phone :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('phone',20));
					htp.tableData('',cattributes => 'id="phoneText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('street',20));
					htp.tableData('');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Code postal :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('postal',20));
					htp.tableData('',cattributes => 'id="postalText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Ville :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('city',20));
					htp.tableData('',cattributes => 'id="cityText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
			htp.tableClose();
		htp.formClose;
		htp.br;		
	END;
	
	PROCEDURE create_account ( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,phone IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2)
	IS
	BEGIN
		pq_ui_commun.header;
		htp.div(cattributes => 'id="corps"');
			htp.br; 
			pq_db_personne.createPersonne(lastname,firstname,login,password,mail,phone,street,postal,city); 
			htp.print('<div class="success"> ');
				htp.print('Compte cr�� avec succ�s.');
			htp.print('</div>');
			htp.br;
			--On affiche les formulaires de connexion et de cr�ation de compte
			pq_ui_login.aff_login;
	pq_ui_commun.aff_footer;
	EXCEPTION 
		WHEN DUP_VAL_ON_INDEX THEN
				pq_ui_commun.dis_error_custom('Le compte n''a pas �t� cr��','Un compte existe d�j� avec le login '|| login ||'.','Merci de choisir une autre valeur pour le login.','pq_ui_login.login','Retour vers la cr�ation d''un nouveau compte');
		WHEN OTHERS THEN
			IF (SQLCODE=-28232) THEN
				pq_ui_commun.dis_error_custom('Le compte n''a pas �t� cr��','La taille du mot de passe n''est pas correcte.','Merci de choisir un mot de passe qui se compose de 8 caract�res ou d''un multiple de 8.','pq_ui_login.login','Retour vers la cr�ation d''un nouveau compte');
			ELSE
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Cr�ation d''un compte');
			END IF;
	END; 
END pq_ui_create_account;
/