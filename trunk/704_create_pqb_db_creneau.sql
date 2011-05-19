-- -----------------------------------------------------------------------------
--           Création du corps du package d'accès à la base de données 
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_creneau
AS
	--Permet d’ajouter un créneau	
	PROCEDURE add_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR) 
	IS
	BEGIN
		INSERT INTO CRENEAU(HEURE_DEBUT_CRENEAU, HEURE_FIN_CRENEAU)
		VALUES(vheureDebutCreneau,vheureFinCreneau);  
		COMMIT;
	END add_creneau;
	
	--Permet de modifier un créneau existant
	PROCEDURE upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau   IN CHAR) 
	IS
	BEGIN
		UPDATE CRENEAU
		SET
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau
		  , HEURE_FIN_CRENEAU   = vheureFinCreneau
		WHERE
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau;
		COMMIT;
	END upd_creneau;
	
	--Permet de supprimer un créneau existant
	PROCEDURE del_creneau(
	  vheureDebutCreneau IN CHAR)
	IS
	BEGIN
		DELETE FROM CRENEAU
		WHERE 
			HEURE_DEBUT_CRENEAU = vheureDebutCreneau;
		COMMIT;
	END del_creneau;
	
END pq_db_creneau;
/