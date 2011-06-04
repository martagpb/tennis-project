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

	
CREATE OR REPLACE PACKAGE BODY PA_PERSONNE
AS
	PROCEDURE getStatutEmploye(numPersonne IN NUMBER, statut OUT VARCHAR2 )
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
	
	PROCEDURE getStatutJoueur(numPersonne IN NUMBER, statut OUT VARCHAR2 )
	IS
	BEGIN
		SELECT 
			PER.STATUT_JOUEUR INTO statut
		FROM
			PERSONNE PER
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	END;
	
	PROCEDURE getNum(login IN VARCHAR, numPersonne OUT NUMBER)
	IS
	BEGIN
		SELECT 
			PER.NUM_PERSONNE INTO numPersonne
		FROM
			PERSONNE PER
		WHERE
			PER.LOGIN_PERSONNE=login;
	END;
	
	PROCEDURE createPersonne( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,phone IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2)
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
		vnumPersonne IN NUMBER, 
		lastname IN VARCHAR2,  
		firstname IN VARCHAR2,
		login IN VARCHAR2,
		password IN VARCHAR2,
		mail IN VARCHAR2,
		phone IN VARCHAR2,
		street IN VARCHAR2,
		postal IN VARCHAR2,
		city IN VARCHAR2)
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
	
END PA_PERSONNE;
/