-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_CRENEAU
IS
	--Permet d�ajouter un cr�neau
	PROCEDURE ADD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	--Permet de modifier un cr�neau existant
	PROCEDURE UPD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	--Permet de supprimer un cr�neau existant
	PROCEDURE DEL_CRENEAU(
	  vheureDebutCreneau IN CHAR);
	
END DB_CRENEAU;
/