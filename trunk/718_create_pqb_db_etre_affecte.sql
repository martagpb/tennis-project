-- -----------------------------------------------------------------------------
--           Cr�ation du corps du package d'acc�s � la base de donn�es 
--           pour la table ETRE_AFFECTE
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 18/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_etre_affecte
AS
	--Permet d�ajouter une affectation
	PROCEDURE add_etre_affecte(
	  vnumEntrainement IN NUMBER
	, vnumTerrain IN NUMBER)
	IS
	BEGIN
		INSERT INTO ETRE_AFFECTE(NUM_ENTRAINEMENT,NUM_TERRAIN)
		VALUES(vnumEntrainement,vnumTerrain);
		COMMIT;
	END add_etre_affecte;
	
	--Permet de supprimer une affectation
	PROCEDURE del_etre_affecte(
	  vnumEntrainement IN NUMBER
	, vnumTerrain IN NUMBER)
	IS
	BEGIN
		DELETE FROM ETRE_AFFECTE
		WHERE
			NUM_ENTRAINEMENT=vnumEntrainement
			AND NUM_TERRAIN=vnumTerrain;
		COMMIT;
	END del_etre_affecte;
	
END pq_db_etre_affecte;
/