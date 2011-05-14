-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_CRENEAU
IS
	--Permet d�afficher un cr�neau existant
	PROCEDURE DIS_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Ex�cute la proc�dure d'ajout d'un cr�neau et g�re les erreurs �ventuelles.
	PROCEDURE EXEC_ADD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Ex�cute la proc�dure de mise � jour d'un cr�neau et g�re les erreurs �ventuelles
	PROCEDURE EXEC_UPD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Ex�cute la proc�dure de suppression d'un cr�neau et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DEL_CRENEAU(
	  vheureDebutCreneau IN CHAR);
	  
	-- Ex�cute la proc�dure d�affichage des cr�neaux et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DIS_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Affiche le formulaire permettant la saisie d�un nouveau cr�neau
	PROCEDURE FORM_ADD_CRENEAU;
	
	-- Affiche le formulaire de saisie permettant la modification d�un cr�neau existant
	PROCEDURE FORM_UPD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
END UI_CRENEAU;
/