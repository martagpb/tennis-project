-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_entrainement
IS
	--Permet d'afficher tous les entrainement existant 
	PROCEDURE manage_entrainement;
	
	--Permet d'afficher tous les entrainement inactifs (historique)
	PROCEDURE manage_historique_entrainement;
	
	-- Ex�cute la proc�dure d�affichage des entrainements et g�re les erreurs �ventuelles
	PROCEDURE exec_dis_entrainement(
	  vnumEntrainement IN NUMBER);
	
	-- Ex�cute la proc�dure d'ajout d'un entrainement et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_entrainement(
	  vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnbPlaces IN NUMBER
	, vdateDebut IN VARCHAR2
	, vdateFin IN VARCHAR2);
	
	-- Ex�cute la proc�dure de mise � jour d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnbPlaces IN NUMBER);
	
	-- Ex�cute la proc�dure de suppression d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_del_entrainement(
	  vnumEntrainement IN NUMBER);
	  
	--Permet d�afficher un entrainement existant
	PROCEDURE dis_entrainement(
	  vnumEntrainement IN NUMBER);
	
	-- Affiche le formulaire permettant la saisie d�un nouvel entrainement
	PROCEDURE form_add_entrainement;
	
	-- Affiche le formulaire de saisie permettant la modification d�un entrainement existant	
	PROCEDURE form_upd_entrainement(
	  vnumEntrainement IN NUMBER);
		
END pq_ui_entrainement;
/