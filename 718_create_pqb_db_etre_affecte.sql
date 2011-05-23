-- -----------------------------------------------------------------------------
--           Création du corps du package d'accès à la base de données 
--           pour la table ETRE_AFFECTE
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_etre_affecte
AS
	--Permet d’ajouter une affectation
	PROCEDURE add_etre_affecte(
	  vnumEntrainement IN NUMBER
	, vnumTerrain IN NUMBER)
	IS
	BEGIN
		INSERT INTO ETRE_AFFECTE(NUM_ENTRAINEMENT,NUM_TERRAIN)
		VALUES(vnumEntrainement,vnumTerrain);
		COMMIT;
	END add_etre_affecte;
	
	--Permet de supprimer les affectations relatives à un entrainement
	PROCEDURE del_etre_affecte_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
	BEGIN
		DELETE FROM ETRE_AFFECTE
		WHERE
			NUM_ENTRAINEMENT=vnumEntrainement;
		COMMIT;
	END del_etre_affecte_entrainement;
	
	--Permet de supprimer une affectation relatives à un terrain
	PROCEDURE del_etre_affecte_terrain(
	  vnumEntrainement IN NUMBER
	, vnumTerrain IN NUMBER)
	IS
	BEGIN
		DELETE FROM ETRE_AFFECTE
		WHERE
			NUM_TERRAIN = vnumTerrain
			AND NUM_ENTRAINEMENT = vnumEntrainement;
		COMMIT;
	END del_etre_affecte_terrain;
	 
	
END pq_db_etre_affecte;
/