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
	BEGIN
		SELECT 
			COD.LIBELLE INTO statut
		FROM
			CODIFICATION COD INNER JOIN PERSONNE PER
				ON COD.CODE=PER.CODE_STATUT_EMPLOYE
				AND COD.NATURE=PER.NATURE_STATUT_EMPLOYE
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	END;
	
	PROCEDURE getStatutJoueur(
		numPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	  , statut OUT CODIFICATION.LIBELLE%TYPE)
	IS
	BEGIN
		SELECT 
			PER.STATUT_JOUEUR INTO statut
		FROM
			PERSONNE PER
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	END;

	PROCEDURE getNum(
		login IN PERSONNE.LOGIN_PERSONNE%TYPE
	  , numPersonne OUT PERSONNE.NUM_PERSONNE%TYPE)
	IS
	BEGIN
		SELECT 
			PER.NUM_PERSONNE INTO numPersonne
		FROM
			PERSONNE PER
		WHERE
			PER.LOGIN_PERSONNE=login;
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
		INSERT INTO PERSONNE(NOM_PERSONNE,PRENOM_PERSONNE,LOGIN_PERSONNE,MDP_PERSONNE,TEL_PERSONNE,EMAIL_PERSONNE,NUM_RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE,NIVEAU_DROIT)
		VALUES (lastname,firstname,login,crypted_password,phone,mail,street,postal,city,1);
		COMMIT; 
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
		crypted_password VARCHAR2(255);
	BEGIN 
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
	END;
	
	
END pq_db_personne;
/