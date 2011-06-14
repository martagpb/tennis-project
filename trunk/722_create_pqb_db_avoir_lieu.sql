-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 04/06/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_avoir_lieu
IS
	--Permet d’ajouter une occurence
	PROCEDURE add_avoir_lieu(
	  vnumJour IN AVOIR_LIEU.NUM_JOUR%TYPE
	, vheureDebutCreneau IN AVOIR_LIEU.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN AVOIR_LIEU.NUM_TERRAIN%TYPE
	, vnumEntrainement IN AVOIR_LIEU.NUM_ENTRAINEMENT%TYPE
	, vexception IN OUT NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		INSERT INTO AVOIR_LIEU(NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN,NUM_ENTRAINEMENT)
		VALUES(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement);
		COMMIT;
		vexception:=0;
		--Il n'y a pas de commit ici car il s'effectue après l'ajout des occupations
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
			vexception:=1;
	END add_avoir_lieu;
	
	--Permet d'ajouter les occupations associées à une séance
	PROCEDURE add_occupation_seance(
	  vnumJour IN AVOIR_LIEU.NUM_JOUR%TYPE
	, vheureDebutCreneau IN AVOIR_LIEU.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN AVOIR_LIEU.NUM_TERRAIN%TYPE
	, vnumEntrainement IN AVOIR_LIEU.NUM_ENTRAINEMENT%TYPE
	, vexception IN OUT NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		vdateDebut ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE;
		vdateFin ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE;
		vincrementDate Date;
		vnumJourDebut NUMBER(1);
		vnumSeance NUMBER(3);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		select date_debut_entrainement into vdateDebut from entrainement where num_entrainement=vnumEntrainement;
		select date_fin_entrainement into vdateFin from entrainement where num_entrainement=vnumEntrainement;
		select to_char(vdateDebut,'D') into vnumJourDebut from entrainement where num_entrainement=vnumEntrainement;
			
		if(vnumjour>=vnumJourDebut)
		then
			vincrementDate:=vdateDebut+(vnumjour-vnumJourDebut);
		else
			vincrementDate:=vdateDebut+(7-vnumJourDebut+vnumJour);
		end if;
		WHILE trunc(vincrementDate) <= trunc(vdateFin)
		LOOP
			pq_db_occuper.add_seance(vheureDebutCreneau,vnumTerrain,vincrementDate,vnumEntrainement,vnumSeance);
			vincrementDate:=vincrementDate+7;
			vnumSeance:=vnumSeance+1;
		END LOOP;
		vexception:=0;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
			vexception:=1;
	END add_occupation_seance;
	
	--Permet de supprimer une occurence
	PROCEDURE del_avoir_lieu(
	  vnumJour IN AVOIR_LIEU.NUM_JOUR%TYPE
	, vheureDebutCreneau IN AVOIR_LIEU.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN AVOIR_LIEU.NUM_TERRAIN%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		DELETE FROM AVOIR_LIEU
		WHERE
			NUM_JOUR = vnumJour
			AND HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			ROLLBACK;
	END del_avoir_lieu;
	
END pq_db_avoir_lieu;
/