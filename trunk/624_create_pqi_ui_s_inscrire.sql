-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table S_INSCRIRE
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_s_inscrire
IS
	--affiche la liste des entrainements
	PROCEDURE manage_entrainement;
	
	--Permet d�afficher les inscriptions d'un entrainement avec le menu
	PROCEDURE manage_inscriptions(vnumEntrainement IN NUMBER);
	  
	--Permet d�afficher les inscriptions d'un entrainement
	PROCEDURE dis_inscriptions(
	  vnumEntrainement IN NUMBER);
	  
	  	-- Ex�cute la proc�dure de suppression d'une inscription et g�re les erreurs �ventuelles
	PROCEDURE exec_del_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
		
	-- Affiche le formulaire permettant la saisie d�une nouvelle inscription
	PROCEDURE form_add_inscription(
		vnumEntrainement IN NUMBER);
	
	-- Ex�cute la proc�dure d'ajout d'une inscription et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
				
END pq_ui_s_inscrire;
/