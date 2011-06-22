-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table PERSONNE
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 22/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_personne
IS
	--Permet d'afficher toutes les personnes et les actions possibles de gestion avec le menu
	PROCEDURE manage_personnes;
	
	--Permet d'afficher tous les personnes et les actions possibles de gestion (sans le menu)
	PROCEDURE dis_personnes;
	
	--Permet d�afficher une personne existante
	PROCEDURE dis_personne(
	  vNumPersonne IN NUMBER);
	
	-- Ex�cute la proc�dure d'ajout d'une personne et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_personne ( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2,phone IN VARCHAR2,level IN VARCHAR2, statutJoueur IN VARCHAR2, statutEmploye IN VARCHAR2);
	
	-- Ex�cute la proc�dure de mise � jour d'une personne et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_personne(num IN NUMBER, lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2,phone IN VARCHAR2,level IN VARCHAR2, statutJoueur IN VARCHAR2, statutEmploye IN VARCHAR2);
	
	
	-- Ex�cute la proc�dure de suppression d'une personne et g�re les erreurs �ventuelles
	PROCEDURE exec_del_personne(
	  vnumPersonne IN NUMBER);

	
	-- Affiche le formulaire permettant la saisie d�une nouvelle personne
	PROCEDURE form_add_personne;
	
	-- Affiche le formulaire de saisie permettant la modification d�une personne existante
	PROCEDURE form_upd_personne(
	  vnumPersonne IN NUMBER);
	  
	 -- Affiche le formulaire permettant de rechercher une personne
	PROCEDURE form_search_personnes;
	
	-- Affiche une liste de personnes en fonction des crit�res de recherche
	PROCEDURE dis_search_personnes(login IN VARCHAR2, nom IN VARCHAR2, prenom IN VARCHAR2);
	
END pq_ui_personne;
/