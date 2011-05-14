       -- -----------------------------------------------------------------------------
--            Suppression des tables de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 10/5/2011
-- -----------------------------------------------------------------------------
 
 
 

DROP TABLE FACTURE CASCADE CONSTRAINTS;

DROP TABLE CRENEAU CASCADE CONSTRAINTS;

DROP TABLE TERRAIN CASCADE CONSTRAINTS;

DROP TABLE ENTRAINEMENT CASCADE CONSTRAINTS;

DROP TABLE MENSUALITE CASCADE CONSTRAINTS;

DROP TABLE ABONNEMENT CASCADE CONSTRAINTS;

DROP TABLE ETRE_AFFECTE CASCADE CONSTRAINTS;

DROP TABLE ETRE_ASSOCIE CASCADE CONSTRAINTS;

DROP TABLE S_INSCRIRE CASCADE CONSTRAINTS;

DROP TABLE AVOIR_LIEU CASCADE CONSTRAINTS;

DROP TABLE OCCUPER CASCADE CONSTRAINTS;

DROP TABLE PERSONNE CASCADE CONSTRAINTS;

DROP TABLE CODIFICATION CASCADE CONSTRAINTS;