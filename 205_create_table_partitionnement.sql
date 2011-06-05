-- -----------------------------------------------------------------------------
--       Génération des tables partitionnées de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 04/06/2011
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : PERSONNE
-- -----------------------------------------------------------------------------

CREATE TABLE PERSONNE(
    NUM_PERSONNE NUMBER(5)  NOT NULL
,   NATURE_STATUT_EMPLOYE VARCHAR2(20)  NULL
,   CODE_STATUT_EMPLOYE CHAR(5)  NULL
,   NATURE_NIVEAU VARCHAR2(20)  NULL
,   CODE_NIVEAU CHAR(5)  NULL
,   STATUT_JOUEUR VARCHAR2(1) DEFAULT 'V' NOT NULL   CHECK (STATUT_JOUEUR IN ('A', 'V'))
,   NOM_PERSONNE VARCHAR2(40)  NOT NULL
,   PRENOM_PERSONNE VARCHAR2(40)  NOT NULL
,   LOGIN_PERSONNE VARCHAR2(40)  NOT NULL
,   MDP_PERSONNE VARCHAR2(40)  NOT NULL
,	NIVEAU_DROIT NUMBER(1) DEFAULT 0
,   TEL_PERSONNE VARCHAR2(12)  NULL
,   EMAIL_PERSONNE VARCHAR2(150)  NULL
,   NUM_RUE_PERSONNE VARCHAR2(75)  NULL
,   CP_PERSONNE VARCHAR2(6)  NULL
,   VILLE_PERSONNE VARCHAR2(75)  NULL
   ) 
   PARTITION BY LIST(STATUT_JOUEUR)(
		PARTITION adherents VALUES('A')
	,   PARTITION visiteurs VALUES('V')
	);

-- -----------------------------------------------------------------------------
--       TABLE : FACTURE
-- -----------------------------------------------------------------------------

CREATE TABLE FACTURE(
    NUM_FACTURE NUMBER(5)  NOT NULL
,   NUM_PERSONNE NUMBER(5) NOT NULL
,   DATE_FACTURE DATE  NOT NULL
,   MONTANT_FACTURE NUMBER(5,2)  NOT NULL
,   DATE_PAIEMENT DATE  
   )
   PARTITION BY RANGE(DATE_FACTURE)(
		PARTITION factures_2010 VALUES LESS THAN(TO_DATE('01/01/2011','DD/MM/YYYY'))
	,	PARTITION factures_2011 VALUES LESS THAN(TO_DATE('01/01/2012','DD/MM/YYYY'))
	,	PARTITION factures_2012 VALUES LESS THAN(TO_DATE('01/01/2013','DD/MM/YYYY'))
	,	PARTITION factures_2013 VALUES LESS THAN(TO_DATE('01/01/2014','DD/MM/YYYY'))
	,	PARTITION factures_2014 VALUES LESS THAN(TO_DATE('01/01/2015','DD/MM/YYYY'))
	,	PARTITION factures_2015 VALUES LESS THAN(TO_DATE('01/01/2016','DD/MM/YYYY'))
	,	PARTITION factures_2016 VALUES LESS THAN(TO_DATE('01/01/2017','DD/MM/YYYY'))
	,	PARTITION factures_2017 VALUES LESS THAN(TO_DATE('01/01/2018','DD/MM/YYYY'))
	,	PARTITION factures_2018 VALUES LESS THAN(TO_DATE('01/01/2019','DD/MM/YYYY'))
	,	PARTITION factures_2019 VALUES LESS THAN(TO_DATE('01/01/2020','DD/MM/YYYY'))
	,	PARTITION factures_2020 VALUES LESS THAN(TO_DATE('01/01/2021','DD/MM/YYYY'))
	);
  
-- -----------------------------------------------------------------------------
--       TABLE : ENTRAINEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE ENTRAINEMENT(
    NUM_ENTRAINEMENT NUMBER(5)  NOT NULL
,   NUM_ENTRAINEUR NUMBER(5)  NOT NULL
,   NATURE_NIVEAU VARCHAR2(20)  NOT NULL
,   CODE_NIVEAU CHAR(5)  NOT NULL
,   LIB_ENTRAINEMENT VARCHAR2(50)  NOT NULL
,   NB_PLACE_ENTRAINEMENT NUMBER(2)  NOT NULL
,   DATE_DEBUT_ENTRAINEMENT DATE  NOT NULL
,   DATE_FIN_ENTRAINEMENT DATE  NOT NULL
   ) 
   PARTITION BY RANGE(DATE_FIN_ENTRAINEMENT) (
		PARTITION entrainements_2010 VALUES LESS THAN(TO_DATE('01/01/2011','DD/MM/YYYY'))
	,  	PARTITION entrainements_2011 VALUES LESS THAN(TO_DATE('01/01/2012','DD/MM/YYYY'))
	,  	PARTITION entrainements_2012 VALUES LESS THAN(TO_DATE('01/01/2013','DD/MM/YYYY'))
	,  	PARTITION entrainements_2013 VALUES LESS THAN(TO_DATE('01/01/2014','DD/MM/YYYY'))
	,  	PARTITION entrainements_2014 VALUES LESS THAN(TO_DATE('01/01/2015','DD/MM/YYYY'))
	,  	PARTITION entrainements_2015 VALUES LESS THAN(TO_DATE('01/01/2016','DD/MM/YYYY'))
	,  	PARTITION entrainements_2016 VALUES LESS THAN(TO_DATE('01/01/2017','DD/MM/YYYY'))
	,  	PARTITION entrainements_2017 VALUES LESS THAN(TO_DATE('01/01/2018','DD/MM/YYYY'))
	,  	PARTITION entrainements_2018 VALUES LESS THAN(TO_DATE('01/01/2019','DD/MM/YYYY'))
	,  	PARTITION entrainements_2019 VALUES LESS THAN(TO_DATE('01/01/2020','DD/MM/YYYY'))
	,  	PARTITION entrainements_2020 VALUES LESS THAN(TO_DATE('01/01/2021','DD/MM/YYYY'))
	);
   
-- -----------------------------------------------------------------------------
--       TABLE : ABONNEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE ABONNEMENT(
    NUM_ABONNEMENT NUMBER(5)  NOT NULL
,   NUM_JOUEUR NUMBER(5)  NOT NULL
,   DATE_DEBUT_ABONNEMENT DATE  NOT NULL
,   DUREE_ABONNEMENT NUMBER(2) DEFAULT 12 NOT NULL CHECK (DUREE_ABONNEMENT >= 0)
   )
   PARTITION BY RANGE(DATE_DEBUT_ABONNEMENT) (
		PARTITION abonnements_2010 VALUES LESS THAN(TO_DATE('01/01/2011','DD/MM/YYYY'))
	,	PARTITION abonnements_2011 VALUES LESS THAN(TO_DATE('01/01/2012','DD/MM/YYYY'))
	,	PARTITION abonnements_2012 VALUES LESS THAN(TO_DATE('01/01/2013','DD/MM/YYYY'))
	,	PARTITION abonnements_2013 VALUES LESS THAN(TO_DATE('01/01/2014','DD/MM/YYYY'))
	,	PARTITION abonnements_2014 VALUES LESS THAN(TO_DATE('01/01/2015','DD/MM/YYYY'))
	,	PARTITION abonnements_2015 VALUES LESS THAN(TO_DATE('01/01/2016','DD/MM/YYYY'))
	,	PARTITION abonnements_2016 VALUES LESS THAN(TO_DATE('01/01/2017','DD/MM/YYYY'))
	,	PARTITION abonnements_2017 VALUES LESS THAN(TO_DATE('01/01/2018','DD/MM/YYYY'))
	,	PARTITION abonnements_2018 VALUES LESS THAN(TO_DATE('01/01/2019','DD/MM/YYYY'))
	,	PARTITION abonnements_2019 VALUES LESS THAN(TO_DATE('01/01/2020','DD/MM/YYYY'))
	,	PARTITION abonnements_2020 VALUES LESS THAN(TO_DATE('01/01/2021','DD/MM/YYYY'))
	);
      
-- -----------------------------------------------------------------------------
--       TABLE : OCCUPER
-- -----------------------------------------------------------------------------

CREATE TABLE OCCUPER(
    HEURE_DEBUT_CRENEAU CHAR(5)  NOT NULL
,   NUM_TERRAIN NUMBER(2)  NOT NULL
,   DATE_OCCUPATION DATE  NOT NULL
,   NUM_FACTURE NUMBER(5) NULL
,   NUM_JOUEUR NUMBER(5)  NULL
,   NUM_ENTRAINEMENT NUMBER(5)  NULL
,   NUM_SEANCE NUMBER(3)  NULL
   ) 
   PARTITION BY RANGE(DATE_OCCUPATION)(
		PARTITION occupations_2010 VALUES LESS THAN(TO_DATE('01/01/2011','DD/MM/YYYY'))
	,	PARTITION occupations_2011 VALUES LESS THAN(TO_DATE('01/01/2012','DD/MM/YYYY'))
	,	PARTITION occupations_2012 VALUES LESS THAN(TO_DATE('01/01/2013','DD/MM/YYYY'))
	,	PARTITION occupations_2013 VALUES LESS THAN(TO_DATE('01/01/2014','DD/MM/YYYY'))
	,	PARTITION occupations_2014 VALUES LESS THAN(TO_DATE('01/01/2015','DD/MM/YYYY'))
	,	PARTITION occupations_2015 VALUES LESS THAN(TO_DATE('01/01/2016','DD/MM/YYYY'))
	,	PARTITION occupations_2016 VALUES LESS THAN(TO_DATE('01/01/2017','DD/MM/YYYY'))
	,	PARTITION occupations_2017 VALUES LESS THAN(TO_DATE('01/01/2018','DD/MM/YYYY'))
	,	PARTITION occupations_2018 VALUES LESS THAN(TO_DATE('01/01/2019','DD/MM/YYYY'))
	,	PARTITION occupations_2019 VALUES LESS THAN(TO_DATE('01/01/2020','DD/MM/YYYY'))
	,	PARTITION occupations_2020 VALUES LESS THAN(TO_DATE('01/01/2021','DD/MM/YYYY'))
	);