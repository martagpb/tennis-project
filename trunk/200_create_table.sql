-- -----------------------------------------------------------------------------
--            Génération des tables de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 04/06/2011
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : CRENEAU
-- -----------------------------------------------------------------------------

CREATE TABLE CRENEAU(
    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL
,   HEURE_FIN_CRENEAU CHAR(5)  NOT NULL  
);

-- -----------------------------------------------------------------------------
--       TABLE : TERRAIN
-- -----------------------------------------------------------------------------

CREATE TABLE TERRAIN(
    NUM_TERRAIN NUMBER(2)  NOT NULL
,   NATURE_SURFACE VARCHAR2(20)  NOT NULL
,   CODE_SURFACE CHAR(5)  NOT NULL
,   ACTIF NUMBER(1) DEFAULT 1 NOT NULL
);
   
-- -----------------------------------------------------------------------------
--       TABLE : MENSUALITE
-- -----------------------------------------------------------------------------

CREATE TABLE MENSUALITE(
    NUM_ABONNEMENT NUMBER(5)  NOT NULL
,   ANNEE_MOIS_MENSUALITE DATE  NOT NULL
,   NB_HEURES_MENSUALITE NUMBER(3)  DEFAULT 15 NOT NULL CHECK (NB_HEURES_MENSUALITE >= 0)
);
 
-- -----------------------------------------------------------------------------
--       TABLE : AVOIR_LIEU
-- -----------------------------------------------------------------------------

CREATE TABLE AVOIR_LIEU(
   NUM_JOUR NUMBER(1)  NOT NULL
,    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL
,   NUM_TERRAIN NUMBER(2)  NOT NULL
,   NUM_ENTRAINEMENT NUMBER(5)  NOT NULL
);
    
-- -----------------------------------------------------------------------------
--       TABLE : CODIFICATION
-- -----------------------------------------------------------------------------

CREATE TABLE CODIFICATION(
    NATURE VARCHAR2(20)  NOT NULL
,   CODE CHAR(5)  NOT NULL
,   LIBELLE VARCHAR2(50)  NOT NULL
);