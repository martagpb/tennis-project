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

CREATE OR REPLACE PACKAGE BODY pq_db_avoir_lieu
IS
	--Permet d�ajouter une occurence
	PROCEDURE add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
	BEGIN
		INSERT INTO AVOIR_LIEU(NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN,NUM_ENTRAINEMENT)
		VALUES(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement);
		COMMIT;
	END add_avoir_lieu;
	
	--Permet de supprimer une occurence
	PROCEDURE del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER)
	IS
	BEGIN
		DELETE FROM AVOIR_LIEU
		WHERE
			NUM_JOUR = vnumJour
			AND HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain;
		COMMIT;
	END del_avoir_lieu;
	
	--Permet de modifier une occurence existante
	PROCEDURE upd_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
	BEGIN
		UPDATE AVOIR_LIEU
		SET
			NUM_ENTRAINEMENT = vnumEntrainement
		WHERE
			NUM_JOUR = vnumJour
			AND HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain;
		COMMIT;
	END upd_avoir_lieu;
	
END pq_db_avoir_lieu;
/







