-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_CODIFICATION
IS
	--Permet d�afficher une codification existante
	PROCEDURE DIS_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Ex�cute la proc�dure d'ajout d'une codification et g�re les erreurs �ventuelles
	PROCEDURE EXEC_ADD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);
	
	-- Ex�cute la proc�dure de mise � jour d'une codification et g�re les erreurs �ventuelles
	PROCEDURE EXEC_UPD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);
	
	-- Ex�cute la proc�dure de suppression d'une codification et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DEL_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Ex�cute la proc�dure d�affichage des codifications et g�re les erreurs
	PROCEDURE EXEC_DIS_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Affiche le formulaire permettant la saisie d�une nouvelle codification
	PROCEDURE FORM_ADD_CODIFICATION;
	
	-- Affiche le formulaire de saisie permettant la modification d�une codification
	PROCEDURE FORM_UPD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);

END UI_CODIFICATION;
/