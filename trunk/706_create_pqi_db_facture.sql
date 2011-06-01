-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table FACTURE
--                      Oracle Version 10g
--                        (25/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 25/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_facture
IS
	--Permet d’ajouter une facture
	PROCEDURE add_facture(
	  pdate IN FACTURE.DATE_FACTURE%TYPE
	, pmontant IN FACTURE.MONTANT_FACTURE%TYPE
	, pdatePaiement IN FACTURE.DATE_PAIEMENT%TYPE
	, pnumPersonne IN FACTURE.NUM_PERSONNE%TYPE);
	
	--Permet de modifier une facture existante
	PROCEDURE upd_facture(
	  pnumFacture IN FACTURE.NUM_FACTURE%TYPE
	, pdate IN FACTURE.DATE_FACTURE%TYPE
	, pmontant IN FACTURE.MONTANT_FACTURE%TYPE);
	
	--Permet de modifier le montant d'une facture existante
	PROCEDURE upd_facture(
	  pnumFacture IN FACTURE.NUM_FACTURE%TYPE
	, pmontant IN FACTURE.MONTANT_FACTURE%TYPE);
	
	--Permet de supprimer une facture existante
	PROCEDURE del_facture(
	  pnumFacture IN FACTURE.NUM_FACTURE%TYPE);
	
END pq_db_facture;
/