-- -----------------------------------------------------------------------------
--  Génération des tables IOT (Index Organized Table) de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 04/06/2011
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : ETRE_ASSOCIE
-- -----------------------------------------------------------------------------

CREATE TABLE ETRE_ASSOCIE(
    NUM_PERSONNE NUMBER(5)  NOT NULL
,   HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL
,   NUM_TERRAIN NUMBER(2)  NOT NULL
,   DATE_OCCUPATION DATE  NOT NULL
, 	CONSTRAINT PK_ETRE_ASSOCIE PRIMARY KEY 
		(HEURE_DEBUT_CRENEAU, NUM_TERRAIN, DATE_OCCUPATION, NUM_PERSONNE)  
)ORGANIZATION INDEX TABLESPACE TENNIS_IND;
   
-- -----------------------------------------------------------------------------
--       TABLE : S_INSCRIRE
-- -----------------------------------------------------------------------------

CREATE TABLE S_INSCRIRE(
    NUM_ENTRAINEMENT NUMBER(5)  NOT NULL
,   NUM_PERSONNE NUMBER(5)  NOT NULL
,	CONSTRAINT PK_S_INSCRIRE PRIMARY KEY
		(NUM_ENTRAINEMENT,NUM_PERSONNE)	
)ORGANIZATION INDEX TABLESPACE TENNIS_IND;