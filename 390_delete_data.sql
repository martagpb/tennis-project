-- -------------------------------------------------------------------------------            Suppression des donn�es de la base de donn�es pour--                      Oracle Version 10g--                        (11/05/2011)-- -------------------------------------------------------------------------------      Nom de la base : Tennis--      Projet : Tennis_V1.24--      Auteur : Gonzalves / Invernizzi / Joly / Leviste--      Date de derni�re modification : 18/05/2011-- ----------------------------------------------------------------------------- -- -------------------------------------------------------------------------------       TABLE : TERRAIN-- -----------------------------------------------------------------------------DELETE FROM TERRAIN;-- -------------------------------------------------------------------------------       TABLE : ENTRAINEMENT-- -----------------------------------------------------------------------------DELETE FROM ENTRAINEMENT;-- -------------------------------------------------------------------------------       TABLE : PERSONNE-- -----------------------------------------------------------------------------DELETE FROM PERSONNE;-- -------------------------------------------------------------------------------       TABLE : CODIFICATION-- -----------------------------------------------------------------------------DELETE FROM CODIFICATION;--Validation de la suppression des donn�esCOMMIT;	 