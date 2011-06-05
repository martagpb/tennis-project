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
	  vnumEntraineur IN ENTRAINEMENT.NUM_ENTRAINEUR%TYPE
	, vcodeNiveau IN ENTRAINEMENT.CODE_NIVEAU%TYPE
	, vnatureNiveau IN ENTRAINEMENT.NATURE_NIVEAU%TYPE
	, vlibEntrainement IN ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE
	, vnbPlaces IN ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE
	, vdateDebut IN ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE
	, vdateFin IN ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE);
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_entrainement(
	  vnumEntrainement IN ENTRAINEMENT.NUM_ENTRAINEMENT%TYPE
	, vnumEntraineur IN ENTRAINEMENT.NUM_ENTRAINEUR%TYPE
	, vcodeNiveau IN ENTRAINEMENT.CODE_NIVEAU%TYPE
	, vnatureNiveau IN ENTRAINEMENT.NATURE_NIVEAU%TYPE
	, vlibEntrainement IN ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE
	, vnbPlaces IN ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE);
	
	--Permet de supprimer un entrainement existant
	PROCEDURE del_entrainement(
	  vnumEntrainement IN ENTRAINEMENT.NUM_ENTRAINEMENT%TYPE);
		
END pq_db_entrainement;
/