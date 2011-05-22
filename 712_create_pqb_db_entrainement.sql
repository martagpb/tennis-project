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
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
	BEGIN
		INSERT INTO ENTRAINEMENT (NUM_ENTRAINEMENT,NUM_ENTRAINEUR,CODE_NIVEAU,NATURE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,DATE_FIN_ENTRAINEMENT,EST_RECURENT_ENTRAINEMENT)
		VALUES (vnumEntrainement,vnumEmploye,vcodeNiveau,vnbPlaces,vdateDebut,vdateFin,VestRecurent);
		COMMIT;
	END add_entrainement;
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
	BEGIN
		UPDATE ENTRAINEMENT
		SET
				NUM_ENTRAINEUR = vnumEmploye
			   ,CODE_NIVEAU = vcodeNiveau
			   ,NATURE_NIVEAU = vnatureNiveau
			   ,NB_PLACE_ENTRAINEMENT = vnbPlaces
			   ,DATE_DEBUT_ENTRAINEMENT = vdateDebut
			   ,DATE_FIN_ENTRAINEMENT = vdateFin
			   ,EST_RECURENT_ENTRAINEMENT = vestRecurent
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