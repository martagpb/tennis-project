-- -----------------------------------------------------------------------------
--            Création des index de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 24/05/2011
-- -----------------------------------------------------------------------------
 
 
-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PERSONNE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PERSONNE_CODIFICATION
     ON PERSONNE (NATURE_STATUT_EMPLOYE ASC, CODE_STATUT_EMPLOYE ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE  INDEX I_FK_PERSONNE_CODIFICATION2
     ON PERSONNE (NATURE_NIVEAU ASC, CODE_NIVEAU ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE UNIQUE INDEX I_FK_PERSONNE_LOGIN
     ON PERSONNE (LOGIN_PERSONNE ASC) 
	 TABLESPACE TENNIS_IND
     ;

	 
-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TERRAIN
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TERRAIN_CODIFICATION
     ON TERRAIN (NATURE_SURFACE ASC, CODE_SURFACE ASC)
	 TABLESPACE TENNIS_IND
    ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ENTRAINEMENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ENTRAINEMENT_CODIFICATION
     ON ENTRAINEMENT (NATURE_NIVEAU ASC, CODE_NIVEAU ASC)
	 TABLESPACE TENNIS_IND
    ;

CREATE  INDEX I_FK_ENTRAINEMENT_PERSONNE
     ON ENTRAINEMENT (NUM_ENTRAINEUR ASC)
	 TABLESPACE TENNIS_IND
    ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE MENSUALITE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_MENSUALITE_ABONNEMENT
     ON MENSUALITE (NUM_ABONNEMENT ASC)
	 TABLESPACE TENNIS_IND
    ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ABONNEMENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ABONNEMENT_PERSONNE
     ON ABONNEMENT (NUM_JOUEUR ASC)
	 TABLESPACE TENNIS_IND
    ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE AVOIR_LIEU
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_AVOIR_LIEU_ENTRAINEMENT
     ON AVOIR_LIEU (NUM_ENTRAINEMENT ASC)
	 TABLESPACE TENNIS_IND
    ;

CREATE  INDEX I_FK_AVOIR_LIEU_CRENEAU
     ON AVOIR_LIEU (HEURE_DEBUT_CRENEAU ASC)
	 TABLESPACE TENNIS_IND
    ;

CREATE  INDEX I_FK_AVOIR_LIEU_TERRAIN
     ON AVOIR_LIEU (NUM_TERRAIN ASC)
	 TABLESPACE TENNIS_IND
    ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE OCCUPER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_OCCUPER_CRENEAU
     ON OCCUPER (HEURE_DEBUT_CRENEAU ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE  INDEX I_FK_OCCUPER_TERRAIN
     ON OCCUPER (NUM_TERRAIN ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE  INDEX I_FK_OCCUPER_FACTURE
     ON OCCUPER (NUM_FACTURE ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE  INDEX I_FK_OCCUPER_PERSONNE
     ON OCCUPER (NUM_JOUEUR ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE  INDEX I_FK_OCCUPER_ENTRAINEMENT
     ON OCCUPER (NUM_ENTRAINEMENT ASC)
	 TABLESPACE TENNIS_IND
    ;
-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ETRE_ASSOCIE
-- -----------------------------------------------------------------------------
CREATE  INDEX I_FK_ETRE_ASSOCIE_PERSONNE
     ON ETRE_ASSOCIE (NUM_PERSONNE ASC)
	 TABLESPACE TENNIS_IND
     ;

CREATE  INDEX I_FK_ETRE_ASSOCIE_OCCUPER
     ON ETRE_ASSOCIE (HEURE_DEBUT_CRENEAU ASC, NUM_TERRAIN ASC, DATE_OCCUPATION ASC)
	 TABLESPACE TENNIS_IND
    ;
	

