        -- -----------------------------------------------------------------------------
--            Création ddu corps du package pq_ui_login de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/5/2011
-- -----------------------------------------------------------------------------
 
 
 
 
CREATE OR REPLACE PACKAGE BODY pq_ui_login
AS 
	PROCEDURE login IS 
		rep_css VARCHAR2(255) := '/public/css/';
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen();
			htp.br;
			htp.br;
			htp.div(cattributes => 'id="login"');
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_login.check_login', 'POST');
				htp.tableOpen();
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
				htp.tableClose();
			htp.formClose;
			htp.br;
			htp.br;
			htp.anchor('pq_ui_create_account.formCreate', 'Création de compte');
			htp.bodyClose;
		htp.htmlClose;
	END login;
	
	PROCEDURE check_login ( login IN VARCHAR2, password IN VARCHAR2) IS 
		checkLog BOOLEAN;
		crypted_password VARCHAR2(255);
		decrypted_password VARCHAR(255);
		rep_css VARCHAR2(255) := '/public/css/';
	BEGIN 
	SELECT 
			MDP_PERSONNE INTO crypted_password  
		FROM
			PERSONNE
		WHERE
			LOGIN_PERSONNE=login;
		htp.htmlOpen; 
		htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
		htp.bodyOpen(); 
		htp.br; 
		dbms_obfuscation_toolkit.desdecrypt(input_string => crypted_password, 
										key_string => 'tennispro', 
										decrypted_string  => decrypted_password );
		IF (decrypted_password=password) then
			htp.print('Redirection');
		ELSE
			pq_ui_login.login();
			htp.print('Mauvais mot de passe');
		END IF;
		htp.bodyClose; 
		htp.htmlclose; 
		EXCEPTION 
			when others then 
			htp.htmlOpen; 
		htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
		htp.bodyOpen(); 
			  htp.br; 
			  htp.br; 
			  IF (SQLCODE=100) THEN
			  htp.print('Compte inconnu');
			  htp.br;
				pq_ui_login.login();
			  ELSE
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Connexion à l''application');				
			END IF;
		htp.bodyClose; 
		htp.htmlclose;
	END check_login; 
END pq_ui_login;
/