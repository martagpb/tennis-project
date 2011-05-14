          -- -----------------------------------------------------------------------------
--            Création du corps du package pq_pa_create_account de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/5/2011
-- -----------------------------------------------------------------------------
  
 
 
CREATE OR REPLACE PACKAGE BODY pq_pa_create_account
AS 
	PROCEDURE create_account ( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,phone IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2)
	IS 
		crypted_password VARCHAR2(255);
	BEGIN 
		dbms_obfuscation_toolkit.DESEncrypt(input_string => password, 
										key_string => 'tennispro', 
										encrypted_string => crypted_password );
		INSERT INTO PERSONNE(NOM_PERSONNE,PRENOM_PERSONNE,LOGIN_PERSONNE,MDP_PERSONNE,TEL_PERSONNE,EMAIL_PERSONNE,NUM_RUE_PERSONNE,CP_PERSONNE,VILLE_PERSONNE)
		VALUES (lastname,firstname,login,crypted_password,phone,mail,street,postal,city);
		COMMIT; 
	END; 
END pq_pa_create_account;
/