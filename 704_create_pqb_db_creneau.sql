-- -----------------------------------------------------------------------------
--           Cr�ation du corps du package d'acc�s � la base de donn�es 
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 04/06/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_creneau
IS
	--Permet d�ajouter un cr�neau	
	PROCEDURE add_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE
	, vheureFinCreneau IN CRENEAU.HEURE_FIN_CRENEAU%TYPE) 
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO CRENEAU(HEURE_DEBUT_CRENEAU, HEURE_FIN_CRENEAU)
		VALUES(vheureDebutCreneau,vheureFinCreneau);  
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END add_creneau;
	
	--Permet de modifier un cr�neau existant
	PROCEDURE upd_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE
	, vheureFinCreneau IN CRENEAU.HEURE_FIN_CRENEAU%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		UPDATE CRENEAU
		SET
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau
		  , HEURE_FIN_CRENEAU   = vheureFinCreneau
		WHERE
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END upd_creneau;
	
	--Permet de supprimer un cr�neau existant
	PROCEDURE del_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		DELETE FROM CRENEAU
		WHERE 
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau;
		COMMIT;
		EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END del_creneau;
	
END pq_db_creneau;
/