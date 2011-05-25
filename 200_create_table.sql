-- -----------------------------------------------------------------------------
--            Génération des tables de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 10/5/2011
-- -----------------------------------------------------------------------------



-- -----------------------------------------------------------------------------
--       TABLE : PERSONNE
-- -----------------------------------------------------------------------------

CREATE TABLE PERSONNE
   (
    NUM_PERSONNE NUMBER(5)  NOT NULL,
    CODE_STATUT_EMPLOYE CHAR(5)  NULL,
    NATURE_STATUT_EMPLOYE VARCHAR2(20)  NULL,
    CODE_NIVEAU CHAR(5)  NULL,
    NATURE_NIVEAU VARCHAR2(20)  NULL,
    NOM_PERSONNE VARCHAR2(40)  NOT NULL,
    PRENOM_PERSONNE VARCHAR2(40)  NOT NULL,
    LOGIN_PERSONNE VARCHAR2(40)  NOT NULL,
    MDP_PERSONNE VARCHAR2(40)  NOT NULL,
    TEL_PERSONNE VARCHAR2(12)  NULL,
    EMAIL_PERSONNE VARCHAR2(150)  NULL,
    NUM_RUE_PERSONNE VARCHAR2(75)  NULL,
    CP_PERSONNE VARCHAR2(6)  NULL,
    VILLE_PERSONNE VARCHAR2(75)  NULL,
    STATUT_JOUEUR VARCHAR2(1)  NULL   CHECK (STATUT_JOUEUR IN ('A', 'V')),
	NIVEAU_DROIT NUMBER(1) DEFAULT 0
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : FACTURE
-- -----------------------------------------------------------------------------

CREATE TABLE FACTURE
   (
    NUM_FACTURE NUMBER(5)  NOT NULL,
    DATE_FACTURE DATE  NOT NULL,
    MONTANT_FACTURE NUMBER(5,2)  NOT NULL 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : CRENEAU
-- -----------------------------------------------------------------------------

CREATE TABLE CRENEAU
   (
    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL,
    HEURE_FIN_CRENEAU CHAR(5)  NOT NULL  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : TERRAIN
-- -----------------------------------------------------------------------------

CREATE TABLE TERRAIN
   (
    NUM_TERRAIN NUMBER(2)  NOT NULL,
    CODE_SURFACE CHAR(5)  NOT NULL,
    NATURE_SURFACE VARCHAR2(20)  NOT NULL,
    ACTIF NUMBER(1) 
      DEFAULT 1 NOT NULL
   ) ;

   
   
-- -----------------------------------------------------------------------------
--       TABLE : ENTRAINEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE ENTRAINEMENT
   (
    NUM_ENTRAINEMENT NUMBER(5)  NOT NULL,
    NUM_ENTRAINEUR NUMBER(5)  NOT NULL,
    CODE_NIVEAU CHAR(5)  NOT NULL,
    NATURE_NIVEAU VARCHAR2(20)  NOT NULL,
    NB_PLACE_ENTRAINEMENT NUMBER(2)  NOT NULL,
    DATE_DEBUT_ENTRAINEMENT DATE  NOT NULL,
    DATE_FIN_ENTRAINEMENT DATE  NOT NULL,
    EST_RECURENT_ENTRAINEMENT NUMBER(1)  NOT NULL,
	EST_ACTIF_ENTRAINEMENT NUMBER(1)  NOT NULL
   ) ;

   
   
-- -----------------------------------------------------------------------------
--       TABLE : MENSUALITE
-- -----------------------------------------------------------------------------

CREATE TABLE MENSUALITE
   (
    NUM_ABONNEMENT NUMBER(5)  NOT NULL,
    ANNEE_MOIS_MENSUALITE DATE  NOT NULL,
    NB_HEURES_MENSUALITE NUMBER(3) 
      DEFAULT 15 NOT NULL    CHECK (NB_HEURES_MENSUALITE >= 0)
   ) ;
   
   
-- -----------------------------------------------------------------------------
--       TABLE : ABONNEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE ABONNEMENT
   (
    NUM_ABONNEMENT NUMBER(5)  NOT NULL,
    NUM_JOUEUR NUMBER(5)  NOT NULL,
    DATE_DEBUT_ABONNEMENT DATE  NOT NULL,
    DUREE_ABONNEMENT NUMBER(2)  NOT NULL 
   ) ;
   
   
-- -----------------------------------------------------------------------------
--       TABLE : ETRE_AFFECTE
-- -----------------------------------------------------------------------------

CREATE TABLE ETRE_AFFECTE
   (
    NUM_ENTRAINEMENT NUMBER(5)  NOT NULL,
    NUM_TERRAIN NUMBER(2)  NOT NULL,
	CONSTRAINT PK_ETRE_AFFECTE PRIMARY KEY
		(NUM_ENTRAINEMENT,NUM_TERRAIN)
   ) ORGANIZATION INDEX;

-- -----------------------------------------------------------------------------
--       TABLE : ETRE_ASSOCIE
-- -----------------------------------------------------------------------------

CREATE TABLE ETRE_ASSOCIE
   (
    NUM_PERSONNE NUMBER(5)  NOT NULL,
    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL,
    NUM_TERRAIN NUMBER(2)  NOT NULL,
    DATE_OCCUPATION DATE  NOT NULL, 
	CONSTRAINT PK_ETRE_ASSOCIE PRIMARY KEY 
		(HEURE_DEBUT_CRENEAU, NUM_TERRAIN, DATE_OCCUPATION, NUM_PERSONNE)  
   ) ORGANIZATION INDEX;
   
-- -----------------------------------------------------------------------------
--       TABLE : S_INSCRIRE
-- -----------------------------------------------------------------------------

CREATE TABLE S_INSCRIRE
   (
    NUM_ENTRAINEMENT NUMBER(5)  NOT NULL,
    NUM_PERSONNE NUMBER(5)  NOT NULL,
	CONSTRAINT PK_S_INSCRIRE PRIMARY KEY
		(NUM_ENTRAINEMENT,NUM_PERSONNE)	
   ) ORGANIZATION INDEX;

-- -----------------------------------------------------------------------------
--       TABLE : AVOIR_LIEU
-- -----------------------------------------------------------------------------

CREATE TABLE AVOIR_LIEU
   (
    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL,
    NUM_TERRAIN NUMBER(2)  NOT NULL,
    NUM_JOUR NUMBER(1)  NOT NULL,
    NUM_ENTRAINEMENT NUMBER(5)  NOT NULL
   ) ;
   
   
   
-- -----------------------------------------------------------------------------
--       TABLE : OCCUPER
-- -----------------------------------------------------------------------------

CREATE TABLE OCCUPER
   (
    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL,
    NUM_TERRAIN NUMBER(2)  NOT NULL,
    DATE_OCCUPATION DATE  NOT NULL,
    NUM_FACTURE NUMBER(5)  NULL,
    NUM_JOUEUR NUMBER(5)  NULL,
    NUM_ENTRAINEMENT NUMBER(5)  NULL,
    NUM_SEANCE NUMBER(3)  NULL
   ) ;
   

-- -----------------------------------------------------------------------------
--       TABLE : CODIFICATION
-- -----------------------------------------------------------------------------

CREATE TABLE CODIFICATION
   (
    CODE CHAR(5)  NOT NULL,
    NATURE VARCHAR2(20)  NOT NULL,
    LIBELLE VARCHAR2(50)  NOT NULL
   ) ;


 -- -----------------------------------------------------------------------------
--       TABLE TEMPORAIRE DE STOCKAGE DE SESSION
-- -----------------------------------------------------------------------------
  
   
CREATE GLOBAL TEMPORARY TABLE temp_session
(
	num_session	VARCHAR2(50),
	num_personne NUMBER(5),	
	droit		NUMBER(1)
) ON COMMIT PRESERVE ROWS ;
