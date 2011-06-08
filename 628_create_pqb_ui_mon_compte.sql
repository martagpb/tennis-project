-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_account
IS	
	--Exécute la procédure d'affichage d'un compte et traite les erreurs
	PROCEDURE exec_dis_account
	IS		
		PERMISSION_DENIED EXCEPTION;
		perm BOOLEAN;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		htp.br;				
		pq_ui_account.dis_account;	
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage des informations de votre compte en cours...');
	END exec_dis_account;
		
	--affiche les informations sur mon compte
	PROCEDURE dis_account
	IS
		vnomPersonne PERSONNE.NOM_PERSONNE%TYPE;
		vprenomPersonne PERSONNE.PRENOM_PERSONNE%TYPE;
		vlogin PERSONNE.LOGIN_PERSONNE%TYPE;
		vMDP PERSONNE.MDP_PERSONNE%TYPE;
		vemail PERSONNE.EMAIL_PERSONNE%TYPE;
		vtel PERSONNE.TEL_PERSONNE%TYPE;
		vadresse PERSONNE.NUM_RUE_PERSONNE%TYPE;
		vcp PERSONNE.CP_PERSONNE%TYPE;
		vville PERSONNE.VILLE_PERSONNE%TYPE;
		vniveau PERSONNE.CODE_NIVEAU%TYPE;
		
		vpassword VARCHAR(200);
		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumPersonne NUMBER(5);
	BEGIN		
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumPersonne:=TO_NUMBER(target_cookie.vals(1));

		SELECT NOM_PERSONNE,PRENOM_PERSONNE,LOGIN_PERSONNE,MDP_PERSONNE,CODE_NIVEAU,EMAIL_PERSONNE,TEL_PERSONNE,NUM_RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE 
		INTO vnomPersonne,vprenomPersonne,vlogin,vMDP,vniveau,vemail,vtel,vadresse,vcp,vville
		FROM PERSONNE WHERE NUM_PERSONNE = vnumPersonne;
		
		dbms_obfuscation_toolkit.desdecrypt(input_string => vMDP, 
										key_string => 'tennispro', 
										decrypted_string  => vpassword );

		htp.br;	
		htp.print('Information de votre compte : ');
		htp.br;
		htp.br;				
		htp.tableOpen(cattributes => 'CELLSPACING=8');
			htp.tableheader('');
			htp.tableheader('');
			htp.tableRowOpen;
				htp.tableData('Nom :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vnomPersonne);
			htp.tableRowClose;	
			htp.tableRowOpen;
				htp.tableData('Prénom :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vprenomPersonne);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Identifiant :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vlogin);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Mot de passe :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vpassword);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Niveau :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vniveau);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Adresse mail :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vemail);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Téléphone :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vtel);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Adresse :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vadresse);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Code postal :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vcp);
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('Ville :', cattributes => 'class="enteteFormulaire"');
				htp.tableData(vville);
			htp.tableRowClose;
		htp.tableClose();	
		htp.br;
		htp.br;
		htp.anchor('pq_ui_account.form_upd_account', 'Modifier votre compte');	
		htp.br;
		htp.br;
		htp.anchor('pq_ui_login.login', 'Retourner à l''accueil');
		htp.br;
		htp.br;
	END  dis_account;
	
	-- Exécute la procédure de mise à jour d'un compte.
	PROCEDURE exec_upd_account(
	  lastname IN VARCHAR2
	, firstname IN VARCHAR2
	, login IN VARCHAR2
	, password IN VARCHAR2
	, mail IN VARCHAR2
	, tel IN VARCHAR2
	, adresse IN VARCHAR2
	, cp IN VARCHAR2
	, ville IN VARCHAR2
	, vniveau IN VARCHAR2)
	IS		
		PERMISSION_DENIED EXCEPTION;
		perm BOOLEAN;
		target_cookie OWA_COOKIE.cookie;
		vnumPersonne NUMBER(5);
	BEGIN		
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumPersonne:=TO_NUMBER(target_cookie.vals(1));
		
        pq_ui_commun.aff_header;
		htp.br;		
		--pq_db_personne.updPersonneAccount(vnumPersonne,lastname,firstname,login,password,mail,tel,adresse,cp,ville,vniveau);
		htp.br;		
		pq_ui_account.dis_account;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
	END exec_upd_account;
	  
	-- Affiche le formulaire permettant la mise à jour d'un compte
	PROCEDURE form_upd_account
	IS		
		--On stocke les informations de nature et de code des niveaux dans le curseur niveauList		
		CURSOR niveaulist 
		IS 
		SELECT 
		    C.CODE
		   ,C.LIBELLE
		FROM 
			CODIFICATION C
		WHERE 
			C.NATURE = 'Classement';
			
		vnomPersonne PERSONNE.NOM_PERSONNE%TYPE;
		vprenomPersonne PERSONNE.PRENOM_PERSONNE%TYPE;
		vlogin PERSONNE.LOGIN_PERSONNE%TYPE;
		vMDP PERSONNE.MDP_PERSONNE%TYPE;
		vemail PERSONNE.EMAIL_PERSONNE%TYPE;
		vtel PERSONNE.TEL_PERSONNE%TYPE;
		vadresse PERSONNE.NUM_RUE_PERSONNE%TYPE;
		vcp PERSONNE.CP_PERSONNE%TYPE;
		vville PERSONNE.VILLE_PERSONNE%TYPE;
		vniveau PERSONNE.CODE_NIVEAU%TYPE;
		
		PERMISSION_DENIED EXCEPTION;
		perm BOOLEAN;
		target_cookie OWA_COOKIE.cookie;
		vnumPersonne NUMBER(5);
		vpassword VARCHAR(200);
	BEGIN	
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumPersonne:=TO_NUMBER(target_cookie.vals(1));	
	 
		SELECT NOM_PERSONNE,PRENOM_PERSONNE,LOGIN_PERSONNE,MDP_PERSONNE,CODE_NIVEAU,EMAIL_PERSONNE,TEL_PERSONNE,NUM_RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE 
		INTO vnomPersonne,vprenomPersonne,vlogin,vMDP,vniveau,vemail,vtel,vadresse,vcp,vville
		FROM PERSONNE WHERE NUM_PERSONNE = vnumPersonne;
		
		pq_ui_commun.aff_header;
		
		dbms_obfuscation_toolkit.desdecrypt(input_string => vMDP, 
								key_string => 'tennispro', 
								decrypted_string  => vpassword );
										
		htp.br;
		htp.print('Mise à jour de votre compte');
		htp.br;
		htp.print('Les champs marqués d''une étoile sont obligatoires');
		htp.br;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_account.exec_upd_account', 'GET', cattributes => 'onSubmit="return valider(this,document)"');
			htp.tableOpen(cattributes => 'CELLSPACING=8');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableRowOpen;
					htp.tableRowOpen;
						htp.tableData('Nom * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData('<INPUT TYPE="text" id="lastname" name="lastname" maxlength="40" value="'||vnomPersonne||'"> ');
						htp.tableData('',cattributes => 'id="lastnameText" class="error"');
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Prénom * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData('<INPUT TYPE="text" id="firstname" name="firstname" maxlength="40" value="'||vprenomPersonne||'"> ');
						htp.tableData('',cattributes => 'id="firstnameText" class="error"');
					htp.tableRowClose;
					htp.tableRowOpen;
					htp.tableData('Identifiant * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" id="login" name="login" maxlength="40" value="'||vlogin||'"> ');
					htp.tableData('',cattributes => 'id="identifiantText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Mot de passe * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" id="password" name="password" maxlength="40" value="'||vpassword||'"> ');
					htp.tableData('',cattributes => 'id="passwordText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
				htp.tableData('Niveau * :');
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select id="vniveau" name="vniveau">');						
					for currentNiveau in niveaulist loop		
						if(currentNiveau.CODE=vniveau)
						then
							htp.print('<option selected value="'||vniveau||'">'||currentNiveau.LIBELLE||'</option>');	
						else
							htp.print('<option value="'||vniveau||'">'||currentNiveau.LIBELLE||'</option>');	
						end if;							
					end loop;
					htp.print('</select>');										
					htp.print('</td>');	
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse mail * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" id="mail" name="mail" maxlength="150" value="'||vemail||'"> ');
					htp.tableData('',cattributes => 'id="mailText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Téléphone :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" name="tel" maxlength="12" value="'||vtel||'"> ');
					htp.tableData('',cattributes => 'id="phoneText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" id="adresse" name="adresse" maxlength="75" value="'||vadresse||'"> ');
					htp.tableData('');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Code postal :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" id="cp" name="cp" maxlength="6" value="'||vcp||'"> ');
					htp.tableData('',cattributes => 'id="postalText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Ville :', cattributes => 'class="enteteFormulaire"');
					htp.tableData('<INPUT TYPE="text" id="ville" name="ville" maxlength="75" value="'||vville||'"> ');
					htp.tableData('',cattributes => 'id="cityText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
			htp.tableClose();
		htp.formClose;
		htp.br;
		htp.br;
		htp.anchor('pq_ui_account.exec_dis_account', 'Page précédente');		
		htp.br;
		htp.br;
		htp.anchor('pq_ui_login.login', 'Retourner à l''accueil');
		htp.br;
		htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
	END form_upd_account;
	
END pq_ui_account;
/