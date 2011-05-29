-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table OCCUPER
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_occuper
IS
	--Permet d�ajouter une r�servation
	PROCEDURE add_reservation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumFacture IN NUMBER
	, vnumJoueur IN NUMBER)
	IS 
	BEGIN
		INSERT INTO OCCUPER(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION,NUM_FACTURE,NUM_JOUEUR)
		VALUES(vheureDebutCreneau,vnumTerrain,vdateOccupation,vnumFacture,vnumJoueur);
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END add_reservation;
	
	--Permet d�ajouter une s�ance
	PROCEDURE add_seance(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumEntrainement IN NUMBER
	, vnumSeance IN NUMBER)
	IS 
	BEGIN
		INSERT INTO OCCUPER(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION,NUM_ENTRAINEMENT,NUM_SEANCE)
		VALUES(vheureDebutCreneau,vnumTerrain,vdateOccupation,vnumEntrainement,vnumSeance);
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END add_seance;
	
	--Permet d�ajouter une occupation simple (exemple : un entretien)
	PROCEDURE add_occupation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE)
	IS 
	BEGIN
		INSERT INTO OCCUPER(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION)
		VALUES(vheureDebutCreneau,vnumTerrain,vdateOccupation);
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END add_occupation;
	
	--Permet de modifier une occupation existante
	PROCEDURE upd_occupation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumFacture IN NUMBER
	, vnumJoueur IN NUMBER
	, vnumEntrainement IN NUMBER
	, vnumSeance IN NUMBER)
	IS 
	BEGIN
				UPDATE OCCUPER
		SET
				NUM_FACTURE = vnumFacture
		       ,NUM_JOUEUR = vnumJoueur  
			   ,NUM_ENTRAINEMENT = vnumEntrainement
			   ,NUM_SEANCE = vnumSeance 
		WHERE
				HEURE_DEBUT_CRENEAU = vheureDebutCreneau
				AND NUM_TERRAIN = vnumTerrain
				AND DATE_OCCUPATION = vdateOccupation;
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END upd_occupation;
	
	--Permet de supprimer une occupation existante
	PROCEDURE del_occupation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE)
	IS
	BEGIN
	  	DELETE FROM OCCUPER
		WHERE
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain
			AND DATE_OCCUPATION = vdateOccupation;
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END del_occupation;
	
	--Permet de supprimer une s�ance au dessus d'une date date donn�e
	PROCEDURE del_seance(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumEntrainement IN NUMBER)
	IS
	BEGIN
		DELETE FROM OCCUPER
		WHERE
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain
			AND DATE_OCCUPATION > vdateOccupation
			AND NUM_ENTRAINEMENT = vnumEntrainement;
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END del_seance;			
	  
END pq_db_occuper;
/