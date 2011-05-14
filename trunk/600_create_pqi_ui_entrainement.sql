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

CREATE OR REPLACE PACKAGE UI_ENTRAINEMENT
IS
	--Permet d�afficher un entrainement existant
	PROCEDURE DIS_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);
	
	-- Ex�cute la proc�dure d'ajout d'un entrainement et g�re les erreurs �ventuelles.
	PROCEDURE EXEC_ADD_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);
	
	-- Ex�cute la proc�dure de mise � jour d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE EXEC_UPD_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);

	-- Ex�cute la proc�dure de suppression d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DEL_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER);
	
	-- Ex�cute la proc�dure d�affichage des entrainements et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DIS_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);
	
	-- Affiche le formulaire permettant la saisie d�un nouvel entrainement
	PROCEDURE FORM_ADD_ENTRAINEMENT;
	
	-- Affiche le formulaire de saisie permettant la modification d�un entrainement existant	
	PROCEDURE FORM_UPD_ENTRAINEMENT(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER);
		
END UI_ENTRAINEMENT;
/