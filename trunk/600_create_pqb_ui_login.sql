-- -----------------------------------------------------------------------------
--            Création ddu corps du package pq_ui_login de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/5/2011
-- -----------------------------------------------------------------------------
  
 
CREATE OR REPLACE PACKAGE BODY pq_ui_login
AS 
	PROCEDURE login IS 
	rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	rep_img VARCHAR2(255) := pq_ui_param_commun.get_rep_img;
	BEGIN
			htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />');
			htp.headClose;
			htp.bodyOpen;
			--logo
			htp.print('<img title="Système de réservation" alt="Logo" src="' || rep_img || 'logo.jpg">');
			htp.div(cattributes => 'id="corps"');
			htp.div(cattributes => 'id="login"');
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_login.check_login', 'POST');
				htp.tableOpen;
				htp.tableheader('');
				htp.tableheader('');
				htp.tableRowOpen;
					htp.tableData('Identifiant :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('login',20));
				htp.tableRowClose;	
				htp.tableRowOpen;
					htp.tableData('Mot de passe :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formPassword('password',20));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.br;
			htp.anchor('pq_ui_create_account.formCreate', 'Création de compte');
			htp.print('</div>');
		htp.div(cattributes => 'id="footer"');
			htp.print('Système de réservation d''un centre de tennis');
		htp.print('</div>');
		htp.bodyClose;
		htp.htmlClose;
	END login;
	
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
			OWA_COOKIE.remove('numpersonne',NULL);
			pq_ui_login.login;
			htp.print('Mauvais mot de passe');
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