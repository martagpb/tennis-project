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
	BEGIN
		pq_ui_commun.aff_header(0);
			htp.br;
			htp.br;
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
		pq_ui_commun.aff_footer;
	END login;
	
	PROCEDURE check_login ( login IN VARCHAR2, password IN VARCHAR2) IS 
		checkLog BOOLEAN;
		crypted_password VARCHAR2(255);
		decrypted_password VARCHAR(255);
	BEGIN 
	SELECT 
			MDP_PERSONNE INTO crypted_password  
		FROM
			PERSONNE
		WHERE
			LOGIN_PERSONNE=login;
		pq_ui_commun.aff_header(0);
		htp.br; 
		dbms_obfuscation_toolkit.desdecrypt(input_string => crypted_password, 
										key_string => 'tennispro', 
										decrypted_string  => decrypted_password );
		IF (decrypted_password=password) then
			htp.print('Redirection');
		ELSE
			pq_ui_login.login;
			htp.print('Mauvais mot de passe');
		END IF;
		pq_ui_commun.aff_footer;
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