-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table ABONNEMENT
--                      Oracle Version 10g
--                        (25/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 25/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_abonnement
IS
	--Permet d’ajouter un abonnement
	PROCEDURE add_abonnement(
	  pnumJoueur IN ABONNEMENT.NUM_JOUEUR%TYPE
	, pdateDebut IN ABONNEMENT.DATE_DEBUT_ABONNEMENT%TYPE
	, pduree IN ABONNEMENT.DUREE_ABONNEMENT%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		vnumAbonnement ABONNEMENT.NUM_ABONNEMENT%TYPE;
		vcptMensualite ABONNEMENT.DUREE_ABONNEMENT%TYPE;
		vdateMensualite DATE;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO ABONNEMENT(NUM_JOUEUR, DATE_DEBUT_ABONNEMENT, DUREE_ABONNEMENT)
		VALUES(pnumJoueur,pdateDebut,pduree); 
		
		SELECT SEQ_ABONNEMENT.currval INTO vnumAbonnement FROM DUAL;
		
		vcptMensualite := 0;
		
		WHILE vcptMensualite < pduree
		LOOP
			vdateMensualite := ADD_MONTHS(pdateDebut, vcptMensualite);
			INSERT INTO MENSUALITE(NUM_ABONNEMENT, ANNEE_MOIS_MENSUALITE)
			VALUES(vnumAbonnement, vdateMensualite);
			vcptMensualite := vcptMensualite +1;
		END LOOP;
		
		COMMIT;
		
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Erreur ajout abonnement');
	END add_abonnement;
	
	--Permet de modifier un abonnement existant
	PROCEDURE upd_abonnement(
	  pnumAbonnement IN ABONNEMENT.NUM_ABONNEMENT%TYPE
	, pnumJoueur IN ABONNEMENT.NUM_JOUEUR%TYPE
	, pdateDebut IN ABONNEMENT.DATE_DEBUT_ABONNEMENT%TYPE
	, pduree IN ABONNEMENT.DUREE_ABONNEMENT%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		var number(5);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		UPDATE ABONNEMENT
		SET
		    NUM_JOUEUR   			= pnumJoueur
		  , DATE_DEBUT_ABONNEMENT 	= pdateDebut
		  , DUREE_ABONNEMENT        = pduree
		WHERE
			NUM_ABONNEMENT = pnumAbonnement;
		COMMIT;
	END upd_abonnement;
	
	--Permet de supprimer un abonnement existant
	PROCEDURE del_abonnement(
	  pnumAbonnement IN ABONNEMENT.NUM_ABONNEMENT%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		DELETE FROM ABONNEMENT
		WHERE 
			NUM_ABONNEMENT = pnumAbonnement;
		COMMIT;
	END del_abonnement;
	
END pq_db_abonnement;
/