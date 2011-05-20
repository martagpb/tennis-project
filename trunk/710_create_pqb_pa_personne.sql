  -- -----------------------------------------------------------------------------
--           Création de l'interface du package de gestion des personnes 
--                      Oracle Version 10g
--                        (18/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------

	
CREATE OR REPLACE PACKAGE BODY PA_PERSONNE
AS
	PROCEDURE getStatutEmploye(numPersonne IN NUMBER, statut OUT VARCHAR2 )
	IS
	BEGIN
		SELECT 
			COD.LIBELLE INTO statut
		FROM
			CODIFICATION COD INNER JOIN PERSONNE PER
				ON COD.CODE=PER.CODE_STATUT_EMPLOYE
				AND COD.NATURE=PER.NATURE_STATUT_EMPLOYE
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	END;
	
	PROCEDURE getStatutJoueur(numPersonne IN NUMBER, statut OUT VARCHAR2 )
	IS
	BEGIN
		SELECT 
			PER.STATUT_JOUEUR INTO statut
		FROM
			PERSONNE PER
		WHERE
			PER.NUM_PERSONNE=numPersonne;
	END;
	
	PROCEDURE getNum(login IN VARCHAR, numPersonne OUT NUMBER)
	IS
	BEGIN
		SELECT 
			PER.NUM_PERSONNE INTO numPersonne
		FROM
			PERSONNE PER
		WHERE
			PER.LOGIN_PERSONNE=login;
	END;
END PA_PERSONNE;
/