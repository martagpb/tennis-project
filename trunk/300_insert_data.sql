-- -----------------------------------------------------------------------------
--            Insertion des données de la base de données pour
--                      Oracle Version 10g
--                        (11/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 12/5/2011
-- -----------------------------------------------------------------------------
 
 
-- -----------------------------------------------------------------------------
--       TABLE : CODIFICATION
-- -----------------------------------------------------------------------------

--Début des codifications des terrains de la table TERRAIN
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURRA','Surface','Rebound Ace');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURDE','Surface','Decoturf');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURBE','Surface','Béton');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURQU','v','Quick');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('TERBA','Surface','Terre battue');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZON','Surface','Gazon');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNMO','Surface','Moquette');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNGE','Surface','Gerflor');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNTA','Surface','Taraflex');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNGR','Surface','Greenset');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNPA','Surface','Parquet');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Surface','Basic turf');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Surface','Olympus');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Surface','Melcbourne');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('TERBS','Surface','Terre battue synthé.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ACRYL','Surface','Acrylique');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ASPHA','Surface','Asphalte');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Surface','Gazon synthétique');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AUTBO','Surface','Bois');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AUTTB','Surface','Toile sur bois');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AUTTM','Surface','Tuiles modulables');
--Fin des codifications des terrains de la table TERRAIN

--Début des codifications des niveaux pour les tables PERSONNE et ENTRAINEMENT
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('NC','Classement','Echelon de 4ème série. Capital de 0 point.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('40','Classement','Echelon de 4ème série. Capital de 2 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/5','Classement','Echelon de 4ème série. Capital de 5 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/4','Classement','Echelon de 4ème série. Capital de 10 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/3','Classement','Echelon de 4ème série. Capital de 20 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/2','Classement','Echelon de 4ème série. Capital de 30 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/1','Classement','Echelon de 4ème série. Capital de 50 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30','Classement','Echelon de 3ème série. Capital de 80 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/5','Classement','Echelon de 3ème série. Capital de 120 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/4','Classement','Echelon de 3ème série. Capital de 160 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/3','Classement','Echelon de 3ème série. Capital de 200 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/2','Classement','Echelon de 3ème série. Capital de 240 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/1','Classement','Echelon de 3ème série. Capital de 280 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15','Classement','Echelon de 2ème série. Capital de 330 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('5/6','Classement','Echelon de 2ème série. Capital de 370 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('4/6','Classement','Echelon de 2ème série. Capital de 410 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('3/6','Classement','Echelon de 2ème série. Capital de 450 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('2/6','Classement','Echelon de 2ème série. Capital de 490 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('1/6','Classement','Echelon de 2ème série. Capital de 530 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('0','Classement','Echelon de 2ème série. Capital de 570 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-2/6','Classement','Echelon de 2ème série -. Capital de 620 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-4/6','Classement','Echelon de 2ème série -. Capital de 660 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-15','Classement','Echelon de 2ème série -. Capital de 700 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-30','Classement','Echelon de 2ème série -. Capital de 740 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('Promo','Classement','Echelon promotion. Capital de 780 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('1erSe','Classement','Echelon de 1ère série. Capital de 840 points.');
--Fin des codifications des niveaux pour les tables PERSONNE et ENTRAINEMENT

--Début des codifications des statuts pour la table PERSONNE
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('U','ROLE','','Utilisateur','');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('J','ROLE','Joueur');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('V','ROLE','Visiteur');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AD','ROLE','Adhérent');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('EMP','ROLE','Employé');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ENT','ROLE','Entraineur');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AG','ROLE','Agent d''accueil');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ADMIN','ROLE','Administrateur');
--Fin des codifications des statuts pour la table PERSONNE

-- -----------------------------------------------------------------------------
--       TABLE : TERRAIN
-- -----------------------------------------------------------------------------

INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(1,'DURRA','Rebound Ace',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(2,'DURDE','Decoturf',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(3,'DURBE','Béton',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(4,'DURQU','Quick',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(5,'TERBA','Terre battue',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(6,'GAZON','Gazon',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(7,'SYNMO','Moquette',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(8,'SYNGE','Gerflor',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(9,'SYNTA','Taraflex',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(10,'SYNGR','Greenset',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(11,'SYNPA','Parquet',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(12,'GAZSY','Basic turf',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(13,'GAZSY','Olympus',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(14,'GAZSY','Melcbourne',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(15,'TERBS','Terre battue synthé.',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(16,'ACRYL','Acrylique',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(17,'ASPHA','Asphalte',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(18,'GAZSY','Gazon synthétique',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(19,'AUTBO','Bois',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(20,'AUTTB','Toile sur bois',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(21,'AUTTM','Tuiles modulables',0);	

--Validation des insertions des données
COMMIT;	 
