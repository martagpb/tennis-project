-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_avoir_lieu
IS
	--Permet d’ajouter une occurence
	PROCEDURE add_avoir_lieu(
	  vnumJour IN AVOIR_LIEU.NUM_JOUR%TYPE
	, vheureDebutCreneau IN AVOIR_LIEU.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN AVOIR_LIEU.NUM_TERRAIN%TYPE
	, vnumEntrainement IN AVOIR_LIEU.NUM_ENTRAINEMENT%TYPE
	, vexception IN OUT NUMBER);
				
	--Permet d'ajouter les occupations associées à une séance
	PROCEDURE add_occupation_seance(
	  vnumJour IN AVOIR_LIEU.NUM_JOUR%TYPE
	, vheureDebutCreneau IN AVOIR_LIEU.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN AVOIR_LIEU.NUM_TERRAIN%TYPE
	, vnumEntrainement IN AVOIR_LIEU.NUM_ENTRAINEMENT%TYPE
	, vexception IN OUT NUMBER);
	
	--Permet de supprimer une occurence
	PROCEDURE del_avoir_lieu(
	  vnumJour IN AVOIR_LIEU.NUM_JOUR%TYPE
	, vheureDebutCreneau IN AVOIR_LIEU.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN AVOIR_LIEU.NUM_TERRAIN%TYPE);
	
END pq_db_avoir_lieu;
/