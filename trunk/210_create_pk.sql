     -- -----------------------------------------------------------------------------
--            Création des clé primaires de la base de données pour
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

ALTER TABLE PERSONNE
ADD CONSTRAINT PK_PERSONNE PRIMARY KEY (NUM_PERSONNE) ;

-- -----------------------------------------------------------------------------
--       TABLE : FACTURE
-- -----------------------------------------------------------------------------

ALTER TABLE FACTURE
ADD CONSTRAINT PK_FACTURE PRIMARY KEY (NUM_FACTURE) ;

-- -----------------------------------------------------------------------------
--       TABLE : CRENEAU
-- -----------------------------------------------------------------------------

ALTER TABLE CRENEAU
ADD CONSTRAINT PK_CRENEAU PRIMARY KEY (HEURE_DEBUT_CRENEAU)  ;
 
-- -----------------------------------------------------------------------------
--       TABLE : TERRAIN
-- -----------------------------------------------------------------------------

ALTER TABLE TERRAIN
ADD CONSTRAINT PK_TERRAIN PRIMARY KEY (NUM_TERRAIN) ; 


-- -----------------------------------------------------------------------------
--       TABLE : ENTRAINEMENT
-- -----------------------------------------------------------------------------

ALTER TABLE ENTRAINEMENT
ADD CONSTRAINT PK_ENTRAINEMENT PRIMARY KEY (NUM_ENTRAINEMENT)  ;


  
-- -----------------------------------------------------------------------------
--       TABLE : MENSUALITE
-- -----------------------------------------------------------------------------

ALTER TABLE MENSUALITE
ADD CONSTRAINT PK_MENSUALITE PRIMARY KEY (NUM_ABONNEMENT, ANNEE_MOIS_MENSUALITE) ; 


--- -----------------------------------------------------------------------------
--       TABLE : ABONNEMENT
-- -----------------------------------------------------------------------------

ALTER TABLE ABONNEMENT
ADD CONSTRAINT PK_ABONNEMENT PRIMARY KEY (NUM_ABONNEMENT)  ;


-- -----------------------------------------------------------------------------
--       TABLE : AVOIR_LIEU
-- -----------------------------------------------------------------------------

ALTER TABLE  AVOIR_LIEU
ADD CONSTRAINT PK_AVOIR_LIEU PRIMARY KEY (NUM_JOUR, HEURE_DEBUT_CRENEAU, NUM_TERRAIN);


-- -----------------------------------------------------------------------------
--       TABLE : OCCUPER
-- -----------------------------------------------------------------------------

ALTER TABLE  OCCUPER
ADD CONSTRAINT PK_OCCUPER PRIMARY KEY (HEURE_DEBUT_CRENEAU, NUM_TERRAIN, DATE_OCCUPATION);    

-- -----------------------------------------------------------------------------
--       TABLE : CODIFICATION
-- -----------------------------------------------------------------------------

ALTER TABLE  CODIFICATION
ADD CONSTRAINT PK_CODIFICATION PRIMARY KEY (CODE, NATURE)  ;
