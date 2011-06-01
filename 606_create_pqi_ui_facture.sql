-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table FACTURE
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 30/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_facture
IS
	--Affiche le panneau de gestion des factures
	PROCEDURE manage_factures;

	--Affiche une facture existante
	PROCEDURE dis_facture(
	  pnumFacture IN VARCHAR2);
	
	-- Affiche le formulaire de saisie d'une nouvelle facture
	PROCEDURE form_add_facture;
	
	-- Exécute la procédure d'ajout d'une facture et gère les erreurs éventuelles.
	PROCEDURE exec_add_facture(
	  pdate IN VARCHAR2
	, pmontant IN VARCHAR2
	, pdatePaiement IN VARCHAR2
	, pnumPersonne IN VARCHAR2);
	
	-- Affiche le formulaire de modification d’une facture existante
	PROCEDURE form_upd_facture(
	  pnumFacture IN VARCHAR2);
	
	-- Exécute la procédure de mise à jour d'une facture et gère les erreurs éventuelles
	PROCEDURE exec_upd_facture(
	  pnumFacture IN VARCHAR2
	, pdate IN VARCHAR2
	, pmontant IN VARCHAR2);
	
	-- Exécute la procédure de suppression d'une facture et gère les erreurs éventuelles
	PROCEDURE exec_del_facture(
	  pnumFacture IN VARCHAR2);
	  
END pq_ui_facture;
/