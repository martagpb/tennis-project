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
IS
	PROCEDURE create_account ( 
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
END pq_pa_create_account;
/