-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table S_INSCRIRE
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_s_inscrire
IS
	--Permet d’ajouter une inscription
	PROCEDURE add_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	
	--Permet de supprimer une inscription existante
	PROCEDURE del_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
		
END pq_db_s_inscrire;
/