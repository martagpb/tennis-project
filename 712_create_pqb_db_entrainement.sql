-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_entrainement
IS
	--Permet d’ajouter un entrainement
	PROCEDURE add_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE)
	IS
	BEGIN
		INSERT INTO ENTRAINEMENT (NUM_ENTRAINEMENT,NUM_ENTRAINEUR,CODE_NIVEAU,NATURE_NIVEAU,NB_PLACE_ENTRAINEMENT,
								  DATE_DEBUT_ENTRAINEMENT,DATE_FIN_ENTRAINEMENT)
		VALUES (vnumEntrainement,vnumEntraineur,vcodeNiveau,vnatureNiveau,vnbPlaces,vdateDebut,vdateFin);
		COMMIT;
	END add_entrainement;
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER)
	IS
	BEGIN
		UPDATE ENTRAINEMENT
		SET
				NUM_ENTRAINEUR = vnumEntraineur
			   ,CODE_NIVEAU = vcodeNiveau
			   ,NATURE_NIVEAU = vnatureNiveau
			   ,NB_PLACE_ENTRAINEMENT = vnbPlaces
		WHERE
				NUM_ENTRAINEMENT = vnumEntrainement;
		COMMIT;
	END upd_entrainement;
	
	--Permet de supprimer un entrainement existant
	PROCEDURE del_entrainement(
	  vnumEntrainement IN NUMBER)
	 IS
	 BEGIN
	  	DELETE FROM ENTRAINEMENT 
		WHERE
			NUM_ENTRAINEMENT = vnumEntrainement;
		COMMIT;
	END del_entrainement;
	
		
END pq_db_entrainement;
/