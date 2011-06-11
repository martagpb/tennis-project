-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table FACTURE
--                      Oracle Version 10g
--                        (27/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 27/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_facture
IS
	--Permet d’ajouter une facture
	PROCEDURE add_facture(
	  pdate IN FACTURE.DATE_FACTURE%TYPE
	, pmontant IN FACTURE.MONTANT_FACTURE%TYPE
	, pdatePaiement IN FACTURE.DATE_PAIEMENT%TYPE
	, pnumPersonne IN FACTURE.NUM_PERSONNE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO FACTURE(DATE_FACTURE, MONTANT_FACTURE, DATE_PAIEMENT, NUM_PERSONNE)
		VALUES(pdate, pmontant, pdatePaiement, pnumPersonne); 
		COMMIT;
	END add_facture;
	
	--Permet de modifier une facture existante
	PROCEDURE upd_facture(
	  pnumFacture IN FACTURE.NUM_FACTURE%TYPE
	, pdate IN FACTURE.DATE_FACTURE%TYPE
	, pmontant IN FACTURE.MONTANT_FACTURE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		var number(5);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		UPDATE FACTURE
		SET
		    NUM_FACTURE   	= pnumFacture
		  , DATE_FACTURE 	= pdate
		  , MONTANT_FACTURE = pmontant
		WHERE
			NUM_FACTURE = pnumFacture;
		COMMIT;
	END upd_facture;
	
	--Permet de modifier le montant d'une facture existante
	PROCEDURE upd_facture(
	  pnumFacture IN FACTURE.NUM_FACTURE%TYPE
	, pmontant IN FACTURE.MONTANT_FACTURE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		var number(5);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		UPDATE FACTURE
		SET
		    NUM_FACTURE   	= pnumFacture
		  , MONTANT_FACTURE = pmontant
		WHERE
			NUM_FACTURE = pnumFacture;
		COMMIT;
	END upd_facture;
	
	--Permet de supprimer une facture existante
	PROCEDURE del_facture(
	  pnumFacture IN FACTURE.NUM_FACTURE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		DELETE FROM FACTURE
		WHERE 
			NUM_FACTURE = pnumFacture;
		COMMIT;
	END del_facture;
	
END pq_db_facture;
/