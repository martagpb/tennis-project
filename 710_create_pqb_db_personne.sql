  -- -----------------------------------------------------------------------------
--           Création de l'interface du package de gestion des personnes 
--                      Oracle Version 10g
--                        (18/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_personne
IS
	PROCEDURE getStatutEmploye(
		numPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	  , statut OUT CODIFICATION.LIBELLE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT 
			COD.LIBELLE INTO statut
		FROM
			CODIFICATION COD INNER JOIN PERSONNE PER
				ON COD.CODE=PER.CODE_STATUT_EMPLOYE
				AND COD.NATURE=PER.NATURE_STATUT_EMPLOYE
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
	
	PROCEDURE getStatutJoueur(
		numPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	  , statut OUT CODIFICATION.LIBELLE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT 
			PER.STATUT_JOUEUR INTO statut
		FROM
			PERSONNE PER
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;

	PROCEDURE getNum(
		login IN PERSONNE.LOGIN_PERSONNE%TYPE
	  , numPersonne OUT PERSONNE.NUM_PERSONNE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT 
			PER.NUM_PERSONNE INTO numPersonne
		FROM
			PERSONNE PER
		WHERE
			PER.LOGIN_PERSONNE=login;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
		
	PROCEDURE createPersonne( 
		lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  login IN PERSONNE.LOGIN_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE)
	IS
		crypted_password VARCHAR2(255);
	BEGIN 
		dbms_obfuscation_toolkit.DESEncrypt(input_string => password, 
										key_string => 'tennispro', 
										encrypted_string => crypted_password );
		INSERT INTO PERSONNE(NOM_PERSONNE,PRENOM_PERSONNE,LOGIN_PERSONNE,MDP_PERSONNE,TEL_PERSONNE,EMAIL_PERSONNE,NUM_RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE,NIVEAU_DROIT,ACTIF)
		VALUES (lastname,firstname,login,crypted_password,phone,mail,street,postal,city,1,1);
		COMMIT; 
	END; 
	
	PROCEDURE createPersonne( 	
		lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  login IN PERSONNE.LOGIN_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE
	 , 	codeStatutEmploye IN PERSONNE.CODE_STATUT_EMPLOYE%TYPE
	 ,	codeNiveau IN PERSONNE.CODE_NIVEAU%TYPE
	 ,	statutJoueur IN PERSONNE.STATUT_JOUEUR%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		crypted_password VARCHAR2(255);
		natureStatut PERSONNE.NATURE_STATUT_EMPLOYE%TYPE;
		natureNiveau PERSONNE.NATURE_NIVEAU%TYPE;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF; 
		SELECT 
			COD.NATURE INTO natureStatut
		FROM 
			CODIFICATION COD
		WHERE
			COD.CODE=codeStatutEmploye;
		SELECT 
			COD.NATURE INTO natureNiveau
		FROM 
			CODIFICATION COD
		WHERE
			COD.CODE=codeNiveau;
		dbms_obfuscation_toolkit.DESEncrypt(input_string => password, 
										key_string => 'tennispro', 
										encrypted_string => crypted_password );
		INSERT INTO PERSONNE(CODE_STATUT_EMPLOYE, NATURE_STATUT_EMPLOYE, CODE_NIVEAU, NATURE_NIVEAU, NOM_PERSONNE,PRENOM_PERSONNE,LOGIN_PERSONNE,MDP_PERSONNE,TEL_PERSONNE,EMAIL_PERSONNE,NUM_RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE,STATUT_JOUEUR,NIVEAU_DROIT)
		VALUES (codeStatutEmploye,natureStatut,codeNiveau,natureNiveau,lastname,firstname,login,crypted_password,phone,mail,street,postal,city,statutJoueur,1);
		COMMIT; 
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END; 
	
	 PROCEDURE updPersonne( 
		vnumPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	 ,  lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  login IN PERSONNE.LOGIN_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION; 
		crypted_password VARCHAR2(255);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF; 
		dbms_obfuscation_toolkit.DESEncrypt(input_string => password, 
										key_string => 'tennispro', 
										encrypted_string => crypted_password );
		UPDATE PERSONNE
		SET
				NOM_PERSONNE = lastname
		       ,PRENOM_PERSONNE = firstname
			   ,LOGIN_PERSONNE = login
			   ,MDP_PERSONNE = crypted_password
			   ,TEL_PERSONNE = phone
			   ,EMAIL_PERSONNE = mail
			   ,NUM_RUE_PERSONNE = street
			   ,CP_PERSONNE = postal
			   ,VILLE_PERSONNE = city
			   
		WHERE
				NUM_PERSONNE = vnumPersonne;
		COMMIT; 
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
	
	 PROCEDURE updPersonneFull( 
	 vnumPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	,	lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  login IN PERSONNE.LOGIN_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE
	 , 	codeStatutEmploye IN PERSONNE.CODE_STATUT_EMPLOYE%TYPE
	 ,	codeNiveau IN PERSONNE.CODE_NIVEAU%TYPE
	 ,	statutJoueur IN PERSONNE.STATUT_JOUEUR%TYPE
	 ,	niveauDroit IN PERSONNE.NIVEAU_DROIT%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION; 
		crypted_password VARCHAR2(255);
		natureStatut PERSONNE.NATURE_STATUT_EMPLOYE%TYPE;
		natureNiveau PERSONNE.NATURE_NIVEAU%TYPE;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT 
			COD.NATURE INTO natureStatut
		FROM 
			CODIFICATION COD
		WHERE
			COD.CODE=codeStatutEmploye;
		SELECT 
			COD.NATURE INTO natureNiveau
		FROM 
			CODIFICATION COD
		WHERE
			COD.CODE=codeNiveau;
		dbms_obfuscation_toolkit.DESEncrypt(input_string => password, 
										key_string => 'tennispro', 
										encrypted_string => crypted_password );
		UPDATE PERSONNE
		SET
				NOM_PERSONNE = lastname
		       ,PRENOM_PERSONNE = firstname
			   ,LOGIN_PERSONNE = login
			   ,MDP_PERSONNE = crypted_password
			   ,TEL_PERSONNE = phone
			   ,EMAIL_PERSONNE = mail
			   ,NUM_RUE_PERSONNE = street
			   ,CP_PERSONNE = postal
			   ,VILLE_PERSONNE = city
			   ,CODE_STATUT_EMPLOYE = codeStatutEmploye
			   ,NATURE_STATUT_EMPLOYE = natureStatut
			   ,CODE_NIVEAU = codeNiveau
			   ,NATURE_NIVEAU = natureNiveau
			   ,STATUT_JOUEUR = statutJoueur
			   ,NIVEAU_DROIT = niveauDroit
		WHERE
				NUM_PERSONNE = vnumPersonne;
		COMMIT; 
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
	
	PROCEDURE updPersonneAccount( 
	    vnumPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	 ,	lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE
	 ,	codeNiveau IN PERSONNE.CODE_NIVEAU%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		crypted_password VARCHAR2(255);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF; 
		dbms_obfuscation_toolkit.DESEncrypt(input_string => password, 
										key_string => 'tennispro', 
										encrypted_string => crypted_password );
		UPDATE PERSONNE
		SET
			   NOM_PERSONNE = lastname
		       ,PRENOM_PERSONNE = firstname
			   ,MDP_PERSONNE = crypted_password
			   ,TEL_PERSONNE = phone
			   ,EMAIL_PERSONNE = mail
			   ,NUM_RUE_PERSONNE = street
			   ,CP_PERSONNE = postal
			   ,VILLE_PERSONNE = city
			   ,CODE_NIVEAU = codeNiveau
		WHERE
				NUM_PERSONNE = vnumPersonne;
		COMMIT; 
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
	
	PROCEDURE delPersonne( vnumPersonne IN PERSONNE.NUM_PERSONNE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		UPDATE PERSONNE
		SET
			ACTIF=0
		WHERE
			NUM_PERSONNE=vnumPersonne;
		DELETE FROM ETRE_ASSOCIE
		WHERE
			NUM_PERSONNE=vnumPersonne
		AND
			DATE_OCCUPATION>SYSDATE;
		DELETE FROM S_INSCRIRE
		WHERE
			NUM_PERSONNE=vnumPersonne;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
	
	
END pq_db_personne;
/