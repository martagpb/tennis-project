-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table FACTURE
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 30/05/2011
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
	
	-- Ex�cute la proc�dure d'ajout d'une facture et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_facture(
	  pdate IN VARCHAR2
	, pmontant IN VARCHAR2
	, pdatePaiement IN VARCHAR2
	, pnumPersonne IN VARCHAR2);
	
	-- Affiche le formulaire de modification d�une facture existante
	PROCEDURE form_upd_facture(
	  pnumFacture IN VARCHAR2);
	
	-- Ex�cute la proc�dure de mise � jour d'une facture et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_facture(
	  pnumFacture IN VARCHAR2
	, pdate IN VARCHAR2
	, pmontant IN VARCHAR2);
	
	-- Ex�cute la proc�dure de suppression d'une facture et g�re les erreurs �ventuelles
	PROCEDURE exec_del_facture(
	  pnumFacture IN VARCHAR2);
	  
END pq_ui_facture;
/