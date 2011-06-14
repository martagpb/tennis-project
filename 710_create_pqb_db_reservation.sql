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

CREATE OR REPLACE PACKAGE BODY pq_db_reservation
IS
	--Permet d�ajouter une r�servation
	PROCEDURE add_reservation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vnumFacture IN OCCUPER.NUM_FACTURE%TYPE
	, vnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE)
	IS 
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO OCCUPER(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION,NUM_FACTURE,NUM_JOUEUR)
		VALUES(vheureDebutCreneau,vnumTerrain,vdateOccupation,vnumFacture,vnumJoueur);
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
	END add_reservation;

	--Ajouter une personne invit�e � une r�servation
	PROCEDURE add_etre_associe(
	  vheureDebutCreneau IN ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN ETRE_ASSOCIE.NUM_TERRAIN%TYPE
	, vdateOccupation IN ETRE_ASSOCIE.DATE_OCCUPATION%TYPE
	, vnumPersonne IN ETRE_ASSOCIE.NUM_PERSONNE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO ETRE_ASSOCIE(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION,NUM_PERSONNE)
		VALUES(vheureDebutCreneau,vnumTerrain,vdateOccupation,vnumPersonne);
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
	END add_etre_associe;
	
	--Permet de supprimer une reservation existante
	PROCEDURE del_reservation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
	  	DELETE FROM OCCUPER
		WHERE
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain
			AND DATE_OCCUPATION = vdateOccupation;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
	END del_reservation;	

	--Permet de supprimer une personne invit�e � une r�servation
	PROCEDURE del_etre_associe(
	  vheureDebutCreneau IN ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN ETRE_ASSOCIE.NUM_TERRAIN%TYPE
	, vdateOccupation IN ETRE_ASSOCIE.DATE_OCCUPATION%TYPE
	, vnumPersonne IN ETRE_ASSOCIE.NUM_PERSONNE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
	  	DELETE FROM ETRE_ASSOCIE
		WHERE
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain
			AND DATE_OCCUPATION = vdateOccupation
			AND NUM_PERSONNE = vnumPersonne;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
	END del_etre_associe;		
	  
END pq_db_reservation;
/