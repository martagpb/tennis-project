-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_account
IS		
	--Exécute la procédure d'affichage d'un compte et traite les erreurs
	PROCEDURE exec_dis_account;

	-- Exécute la procédure de mise à jour d'un compte et traite les erreurs
	PROCEDURE exec_upd_account(
	  lastname IN VARCHAR2
	, firstname IN VARCHAR2
	, login IN VARCHAR2
	, password IN VARCHAR2
	, mail IN VARCHAR2
	, tel IN VARCHAR2
	, adresse IN VARCHAR2
	, cp IN VARCHAR2
	, ville IN VARCHAR2);
	  
	--affiche les informations sur mon compte
	PROCEDURE dis_account;
		
	-- Affiche le formulaire permettant la mise à jour d'un compte
	PROCEDURE form_upd_account;
		
END pq_ui_account;
/