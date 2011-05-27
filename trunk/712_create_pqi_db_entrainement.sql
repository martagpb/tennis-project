-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_entrainement
IS
	--Permet d’ajouter un entrainement
	PROCEDURE add_entrainement(
	  vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE);
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnbPlaces IN NUMBER);
	
	--Permet de supprimer un entrainement existant
	PROCEDURE del_entrainement(
	  vnumEntrainement IN NUMBER);
		
END pq_db_entrainement;
/