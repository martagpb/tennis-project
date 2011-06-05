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


CREATE OR REPLACE PACKAGE pq_db_personne
AS
	
	PROCEDURE getStatutEmploye(		
		numPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	  , statut OUT CODIFICATION.LIBELLE%TYPE);
	  
	PROCEDURE getStatutJoueur(
		numPersonne IN PERSONNE.NUM_PERSONNE%TYPE
	  , statut OUT CODIFICATION.LIBELLE%TYPE);
	  
	PROCEDURE getNum(
		login IN PERSONNE.LOGIN_PERSONNE%TYPE
	  , numPersonne OUT PERSONNE.NUM_PERSONNE%TYPE);
	  
	PROCEDURE createPersonne( 
		lastname IN PERSONNE.NOM_PERSONNE%TYPE
	 ,  firstname IN PERSONNE.PRENOM_PERSONNE%TYPE
	 ,  login IN PERSONNE.LOGIN_PERSONNE%TYPE
	 ,  password IN PERSONNE.MDP_PERSONNE%TYPE
	 ,  mail IN PERSONNE.EMAIL_PERSONNE%TYPE
	 ,  phone IN PERSONNE.TEL_PERSONNE%TYPE
	 ,  street IN PERSONNE.NUM_RUE_PERSONNE%TYPE
	 ,  postal IN PERSONNE.CP_PERSONNE%TYPE
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE);
	 
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
	 ,  city IN PERSONNE.VILLE_PERSONNE%TYPE);
	 
END pq_db_personne;
/