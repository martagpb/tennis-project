-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_avoir_lieu
IS
	--Permet d�ajouter une occurence
	PROCEDURE add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER
	, vexception IN OUT NUMBER);
	
	--Permet de supprimer une occurence
	PROCEDURE del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER);
		
	--Permet d'ajouter les occupations associ�es � une s�ance
	PROCEDURE add_occupation_seance(
		  vnumJour IN NUMBER
		, vheureDebutCreneau IN CHAR 
		, vnumTerrain IN NUMBER
		, vnumEntrainement IN NUMBER
		, vexception IN OUT NUMBER);
	
END pq_db_avoir_lieu;
/