-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_ENTRAINEMENT
IS
	--Permet d�ajouter un entrainement
	PROCEDURE ADD_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);
	
	--Permet de modifier un entrainement existant
	PROCEDURE UPD_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);
	
	--Permet de supprimer un entrainement existant
	PROCEDURE DEL_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER);
		
END DB_ENTRAINEMENT;
/