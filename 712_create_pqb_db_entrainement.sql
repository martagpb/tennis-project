-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 04/06/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_entrainement
IS
	--Permet d�ajouter un entrainement
	PROCEDURE add_entrainement(
	  vnumEntraineur IN ENTRAINEMENT.NUM_ENTRAINEUR%TYPE
	, vcodeNiveau IN ENTRAINEMENT.CODE_NIVEAU%TYPE
	, vnatureNiveau IN ENTRAINEMENT.NATURE_NIVEAU%TYPE
	, vlibEntrainement IN ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE
	, vnbPlaces IN ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE
	, vdateDebut IN ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE
	, vdateFin IN ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE)
	IS
	BEGIN
		INSERT INTO ENTRAINEMENT (NUM_ENTRAINEUR,CODE_NIVEAU,NATURE_NIVEAU,LIB_ENTRAINEMENT,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,DATE_FIN_ENTRAINEMENT)
		VALUES (vnumEntraineur,vcodeNiveau,vnatureNiveau,vlibEntrainement,vnbPlaces,vdateDebut,vdateFin);
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END add_entrainement;
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_entrainement(
	  vnumEntrainement IN ENTRAINEMENT.NUM_ENTRAINEMENT%TYPE
	, vnumEntraineur IN ENTRAINEMENT.NUM_ENTRAINEUR%TYPE
	, vcodeNiveau IN ENTRAINEMENT.CODE_NIVEAU%TYPE
	, vnatureNiveau IN ENTRAINEMENT.NATURE_NIVEAU%TYPE
	, vlibEntrainement IN ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE
	, vnbPlaces IN ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE)
	IS
	BEGIN
		UPDATE ENTRAINEMENT
		SET
				NUM_ENTRAINEUR = vnumEntraineur
			  , CODE_NIVEAU = vcodeNiveau
			  , NATURE_NIVEAU = vnatureNiveau
			  , NB_PLACE_ENTRAINEMENT = vnbPlaces
			  , LIB_ENTRAINEMENT = vlibEntrainement
		WHERE
				NUM_ENTRAINEMENT = vnumEntrainement;
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END upd_entrainement;
	
	--Permet de supprimer un entrainement existant
	PROCEDURE del_entrainement(
	  vnumEntrainement IN ENTRAINEMENT.NUM_ENTRAINEMENT%TYPE)
	 IS
		vdateDebut Date;
	 BEGIN
	 SELECT DATE_DEBUT_ENTRAINEMENT INTO vdateDebut FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
	 IF(vdateDebut<SYSDATE)
	 THEN
	  	UPDATE ENTRAINEMENT 
		SET 
			DATE_FIN_ENTRAINEMENT=SYSDATE
		WHERE
			NUM_ENTRAINEMENT = vnumEntrainement;
		--supprimer toutes les occupations � venir
		DELETE FROM OCCUPER
		WHERE
			trunc(DATE_OCCUPATION) > trunc(sysdate)
			AND NUM_ENTRAINEMENT = vnumEntrainement;
	 ELSE
		--supprimer toutes les enregistrements de la table avoir lieu
		DELETE FROM AVOIR_LIEU
		WHERE
			NUM_ENTRAINEMENT = vnumEntrainement;
		--supprimer toutes les occupations � venir
		DELETE FROM OCCUPER
		WHERE
			trunc(DATE_OCCUPATION) > trunc(sysdate)
			AND NUM_ENTRAINEMENT = vnumEntrainement;
		--Supprime l'entrainement	
		DELETE FROM ENTRAINEMENT
		WHERE
			NUM_ENTRAINEMENT = vnumEntrainement;
	 END IF;
	COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
	END del_entrainement;
	
		
END pq_db_entrainement;
/