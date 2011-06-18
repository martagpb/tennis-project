-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table OCCUPER
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_reservation
IS

	--Permet d’ajouter une réservation
	PROCEDURE add_reservation(
	  pnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, pdate IN OCCUPER.DATE_OCCUPATION%TYPE
	, pheure IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, pnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE)
	IS 
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		EXEC_EXCEPTION EXCEPTION;
		
		vstatutJoueur PERSONNE.STATUT_JOUEUR%TYPE;
		vnumFacture FACTURE.NUM_FACTURE%TYPE;
		
		vnumAbonnement MENSUALITE.NUM_ABONNEMENT%TYPE;
		vnbHeures MENSUALITE.NB_HEURES_MENSUALITE%TYPE;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		SELECT P.STATUT_JOUEUR
		INTO vstatutJoueur
		FROM PERSONNE P
		WHERE P.NUM_PERSONNE = pnumJoueur;
		
		IF vstatutJoueur = 'A' THEN
			SELECT M.NB_HEURES_MENSUALITE, M.NUM_ABONNEMENT
			INTO vnbHeures, vnumAbonnement
			FROM MENSUALITE M INNER JOIN ABONNEMENT A ON M.NUM_ABONNEMENT = A.NUM_ABONNEMENT
			WHERE 
				to_char(M.ANNEE_MOIS_MENSUALITE,'MM/YYYY') = to_char(pdate,'MM/YYYY')
				AND A.NUM_JOUEUR = pnumJoueur;
			
			IF vnbHeures > 0 THEN
				UPDATE MENSUALITE SET NB_HEURES_MENSUALITE = vnbHeures - 1
				WHERE NUM_ABONNEMENT = vnumAbonnement AND to_char(ANNEE_MOIS_MENSUALITE,'MM/YYYY') = to_char(pdate,'MM/YYYY');
				
				INSERT INTO OCCUPER(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION,NUM_JOUEUR)
				VALUES(pheure, pnumTerrain, pdate, pnumJoueur);
			END IF;
		ELSE
			INSERT INTO FACTURE(NUM_PERSONNE, DATE_FACTURE) VALUES(pnumJoueur, sysdate);
			SELECT SEQ_FACTURE.currval INTO vnumFacture FROM DUAL;
			INSERT INTO OCCUPER(HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION,NUM_JOUEUR, NUM_FACTURE)
				VALUES(pheure, pnumTerrain, pdate, pnumJoueur, vnumFacture);
		END IF;
		
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
			--pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Erreur ajout abonnement');
			RAISE EXEC_EXCEPTION;
	END add_reservation;

	--	Met à jour une réservation
	PROCEDURE upd_reservation(
	  pnumTerrainOld IN OCCUPER.NUM_TERRAIN%TYPE
	, pdateOld IN OCCUPER.DATE_OCCUPATION%TYPE
	, pheureOld IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, pnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, pdate IN OCCUPER.DATE_OCCUPATION%TYPE
	, pheure IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, pnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE)
	IS 
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		EXEC_EXCEPTION EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		UPDATE OCCUPER
		SET NUM_TERRAIN = pnumTerrain, DATE_OCCUPATION = pdate, HEURE_DEBUT_CRENEAU = pheure, NUM_JOUEUR = pnumJoueur
		WHERE NUM_TERRAIN = pnumTerrainOld AND DATE_OCCUPATION = pdateOld AND HEURE_DEBUT_CRENEAU = pheureOld;
		COMMIT;
		
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE EXEC_EXCEPTION;
	END upd_reservation;
	
	--Permet de supprimer une reservation existante
	PROCEDURE del_reservation(
	  vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE)
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

	--Ajouter une personne invitée à une réservation
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

	--Permet de supprimer une personne invitée à une réservation
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