 -- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table S_INSCRIRE
--                      Oracle Version 10g
--                        (29/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 29/05/2011
-- -----------------------------------------------------------------------------


CREATE OR REPLACE PACKAGE BODY pq_db_s_inscrire
IS

	--Permet d’ajouter une inscription
	PROCEDURE add_inscription( 
		vnumEntrainement IN S_INSCRIRE.NUM_ENTRAINEMENT%TYPE
	  , vnumPersonne IN S_INSCRIRE.NUM_PERSONNE%TYPE)
	IS
		CURSOR listSeances IS
		SELECT
			 OCC.HEURE_DEBUT_CRENEAU
			,OCC.NUM_TERRAIN
			,OCC.DATE_OCCUPATION
		FROM
			OCCUPER OCC
		WHERE
			OCC.NUM_ENTRAINEMENT=vnumEntrainement
		AND
			OCC.DATE_OCCUPATION >= SYSDATE
		ORDER BY 1;
	BEGIN
	INSERT INTO S_INSCRIRE(NUM_ENTRAINEMENT,NUM_PERSONNE) VALUES (vnumEntrainement,vnumPersonne);
	for currentSeance in listSeances loop
		INSERT INTO ETRE_ASSOCIE (NUM_PERSONNE,HEURE_DEBUT_CRENEAU,NUM_TERRAIN,DATE_OCCUPATION) 
		VALUES (vnumPersonne,currentSeance.HEURE_DEBUT_CRENEAU,currentSeance.NUM_TERRAIN,currentSeance.DATE_OCCUPATION);
	END LOOP
	COMMIT;
	END add_inscription;
	

--Permet de supprimer une inscription existante
	PROCEDURE del_inscription( 
		vnumEntrainement IN S_INSCRIRE.NUM_ENTRAINEMENT%TYPE
	  , vnumPersonne IN S_INSCRIRE.NUM_PERSONNE%TYPE)
	IS
		CURSOR listSeances IS
		SELECT
			 OCC.HEURE_DEBUT_CRENEAU
			,OCC.NUM_TERRAIN
			,OCC.DATE_OCCUPATION
		FROM
			OCCUPER OCC
		WHERE
			OCC.NUM_ENTRAINEMENT=vnumEntrainement
		AND
			OCC.DATE_OCCUPATION >= SYSDATE
		ORDER BY 1;
	BEGIN
	DELETE FROM S_INSCRIRE 
	WHERE NUM_ENTRAINEMENT=vnumEntrainement 
	AND NUM_PERSONNE=vnumPersonne;
	for currentSeance in listSeances loop
		DELETE FROM ETRE_ASSOCIE 
		WHERE NUM_PERSONNE=vnumPersonne
		AND HEURE_DEBUT_CRENEAU=currentSeance.HEURE_DEBUT_CRENEAU
		AND NUM_TERRAIN=currentSeance.NUM_TERRAIN
		AND DATE_OCCUPATION=currentSeance.DATE_OCCUPATION;
	END LOOP
	COMMIT;
	END del_inscription;
	
	
END pq_db_s_inscrire;
/