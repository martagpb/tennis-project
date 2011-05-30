  -- -----------------------------------------------------------------------------
--           Création de l'interface du package de gestion des personnes 
--                      Oracle Version 10g
--                        (18/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------


CREATE OR REPLACE PACKAGE PA_PERSONNE
AS
	PROCEDURE getStatutEmploye(numPersonne IN NUMBER, statut OUT VARCHAR2 );
	PROCEDURE getStatutJoueur(numPersonne IN NUMBER, statut OUT VARCHAR2 );
	PROCEDURE getNum(login IN VARCHAR, numPersonne OUT NUMBER);
	PROCEDURE createPersonne ( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,phone IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2) ;
END PA_PERSONNE;
/

