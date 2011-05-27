-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_avoir_lieu
IS
	--Permet d’ajouter une occurence
	PROCEDURE add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER
	, vexception IN OUT NUMBER)
	IS
	BEGIN
		INSERT INTO AVOIR_LIEU(NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN,NUM_ENTRAINEMENT)
		VALUES(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement);
		vexception:=0;
		--pas de commit ici, commit après l'ajout des occupations
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			vexception:=1;
	END add_avoir_lieu;
	
	--Permet de supprimer une occurence
	PROCEDURE del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER)
	IS
	BEGIN
		DELETE FROM AVOIR_LIEU
		WHERE
			NUM_JOUR = vnumJour
			AND HEURE_DEBUT_CRENEAU = vheureDebutCreneau
			AND NUM_TERRAIN = vnumTerrain;
		COMMIT;
	END del_avoir_lieu;
	
	--Permet d'ajouter les occupations associées à une séance
	PROCEDURE add_occupation_seance(
		  vnumJour IN NUMBER
		, vheureDebutCreneau IN CHAR 
		, vnumTerrain IN NUMBER
		, vnumEntrainement IN NUMBER
		, vexception IN OUT NUMBER)
	IS
		vdateDebut Date;
		vdateFin Date;
		vincrementDate Date;
		vnumJourDebut NUMBER(1);
		vnumSeance NUMBER(3);
	BEGIN
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
		WHEN OTHERS THEN
			ROLLBACK;
			vexception:=1;
	END add_occupation_seance;
	
END pq_db_avoir_lieu;
/







