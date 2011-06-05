          -- -----------------------------------------------------------------------------
--            Création de l'interface du package pq_pa_create_account de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/5/2011
-- -----------------------------------------------------------------------------
 
 
 
CREATE OR REPLACE PACKAGE pq_pa_create_account
AS 
	PROCEDURE create_account ( 
		lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  login IN PERSONNE.LOGIN_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE);
	
	
END pq_pa_create_account;
/