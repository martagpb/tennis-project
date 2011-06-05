-- -----------------------------------------------------------------------------
--  Création du corps du package pq_ui_login de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/5/2011
-- -----------------------------------------------------------------------------
  
 
CREATE OR REPLACE PACKAGE BODY pq_ui_login
IS 

	--Procédure permettant d'affiche le header simplifié (sans le menu) ainsi que les formulaires de connexion et de création de compte
	PROCEDURE login IS 
	BEGIN
		pq_ui_commun.header;
			htp.div(cattributes => 'id="corps"');
			pq_ui_login.aff_login;
		pq_ui_commun.aff_footer;
	END login;

	--Procédure permettant simplement d'affiche le formulaire de connexion d'un compte existant ainsi que le formulaire de création d'un nouveau compte
	PROCEDURE aff_login IS 
	BEGIN		
		htp.br;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Connexion avec un compte existant');
		htp.print('</div>');		
		htp.br;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_login.check_login', 'POST', cattributes => 'onSubmit="return validerConnexionCompteExistant(this,document)"');
			htp.tableOpen;
			htp.tableheader('');
			htp.tableheader('');
			htp.tableheader('');
			htp.tableRowOpen;
				htp.tableData('Identifiant* :', cattributes => 'class="enteteFormulaire"');			
				htp.print('<td>');
					htp.formText('login',20,cattributes => 'maxlength="20" id="vlogin"');
				htp.print('</td>');
				htp.tableData('',cattributes => 'id="vloginError" class="error"');
			htp.tableRowClose;	
			htp.tableRowOpen;
				htp.tableData('Mot de passe* :', cattributes => 'class="enteteFormulaire"');		
				htp.print('<td>');					
					htp.formPassword('password',20,cattributes => 'maxlength="20" id="vpassword"');
				htp.print('</td>');
				htp.tableData('',cattributes => 'id="vpasswordError" class="error"');
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('');
				htp.tableData(htf.formSubmit(NULL,'Validation'));
			htp.tableRowClose;
			htp.tableClose;
		htp.formClose;
		htp.br;
		htp.br;
		--Affichage du formulaire de création d'un nouveau compte
		pq_ui_create_account.formCreate;
	END aff_login;
	
	PROCEDURE check_login ( login IN VARCHAR2, password IN VARCHAR2) IS 
		checkLog BOOLEAN;
		numPer NUMBER;
		crypted_password VARCHAR2(255);
		decrypted_password VARCHAR(255);
	BEGIN 
	SELECT 
			MDP_PERSONNE INTO crypted_password  
		FROM
			PERSONNE
		WHERE
			LOGIN_PERSONNE=login;
	SELECT 
		NUM_PERSONNE INTO numPer  
	FROM
		PERSONNE
	WHERE
		LOGIN_PERSONNE=login;
		--Obligation de créer le cookie ici, dans l'entête HTTP. Suppression après vérification si mauvaise indentification
		OWA_UTIL.mime_header ('text/html', FALSE);
		OWA_COOKIE.send ('numpersonne', TO_CHAR(numPer),SYSDATE+1);
		OWA_UTIL.http_header_close;  -- Now close the header
		htp.br; 
		dbms_obfuscation_toolkit.desdecrypt(input_string => crypted_password, 
										key_string => 'tennispro', 
										decrypted_string  => decrypted_password );
		IF (decrypted_password=password) then
			--redirect accueil
			pq_ui_commun.aff_accueil;
		ELSE			
			pq_ui_commun.header;
				htp.br; 
				htp.div(cattributes => 'id="corps"');
				htp.print('<div class="error">');
					htp.print('Le mot de passe indiqué est incorrect.');
				htp.print('</div>');
				pq_ui_login.aff_login;	
			pq_ui_commun.aff_footer;	
			--OWA_COOKIE.remove('numpersonne',NULL);			
		END IF;
		EXCEPTION 			
			when others then 
			  IF (SQLCODE=100) THEN
			  htp.print('Compte inconnu');
				pq_ui_login.login;
			  ELSE
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Connexion à l''application');				
			END IF;
	END check_login; 
	
END pq_ui_login;
/