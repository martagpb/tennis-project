-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table ETRE_AFFECTE
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_etre_affecte
IS
	--Permet d�ajouter une affectation
	PROCEDURE add_etre_affecte(
	  vnumEntrainement IN NUMBER
	, vnumTerrain IN NUMBER);
	
	--Permet de supprimer les affectations relatives � un entrainement
	PROCEDURE del_etre_affecte_entrainement(
	  vnumEntrainement IN NUMBER);
	
	--Permet de supprimer une affectation relatives � un terrain
	PROCEDURE del_etre_affecte_terrain(
	  vnumEntrainement IN NUMBER
	, vnumTerrain IN NUMBER);
	
END pq_db_etre_affecte;
/