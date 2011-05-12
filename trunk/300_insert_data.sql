-- -----------------------------------------------------------------------------
--            Insertion des donn�es de la base de donn�es pour
--                      Oracle Version 10g
--                        (11/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 12/5/2011
-- -----------------------------------------------------------------------------
 
 
-- -----------------------------------------------------------------------------
--       TABLE : CODIFICATION
-- -----------------------------------------------------------------------------

--D�but des codifications des terrains de la table TERRAIN
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURRA','Rebound Ace','Rebound Ace est une surface dure et rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURDE','Decoturf','Decoturf est une surface dure et rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURBE','B�ton','Le b�ton est une surface dure et rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('DURQU','Quick','Quick est une surface dure et rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('TERBA','Terre battue','La terre battue est une surface lente.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZON','Gazon','Le Gazon est une surface ultra-rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNMO','Moquette','Surface synth�tique tr�s rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNGE','Gerflor','Surface synth�tique tr�s rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNTA','Taraflex','Surface synth�tique tr�s rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNGR','Greenset','Surface synth�tique tr�s rapide.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('SYNPA','Parquet','Surface synth�tique rarement utilis�.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Basic turf','Gazon synth�tique plus rapide que la terre battue.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Olympus','Gazon synth�tique plus rapide que la terre battue.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Melcbourne','Gazon synth�tique plus rapide que la terre battue.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('TERBS','Terre battue synth�.','Surface lente et jeu similaire la terre battue.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ACRYL','Acrylique','R�sine pigment�e. Type de surface de l''US Open.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ASPHA','Asphalte','Type de surface de Roland Garros.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('GAZSY','Gazon synth�tique','Surface synth�tique � l''apparence du gazon.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AUTBO','bois','La surface en bois est tr�s rarement utilis�e.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AUTTB','Toile sur bois','Surface en toile sur bois tr�s rarement utilis�e.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('AUTTM','Tuiles modulables','Surface tr�s rarement utilis�e.');
--Fin des codifications des terrains de la table TERRAIN

--D�but des codifications des niveaux pour les tables PERSONNE et ENTRAINEMENT
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('NC','Classement','Echelon de 4�me s�rie. Capital de 0 point.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('40','Classement','Echelon de 4�me s�rie. Capital de 2 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/5','Classement','Echelon de 4�me s�rie. Capital de 5 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/4','Classement','Echelon de 4�me s�rie. Capital de 10 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/3','Classement','Echelon de 4�me s�rie. Capital de 20 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/2','Classement','Echelon de 4�me s�rie. Capital de 30 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30/1','Classement','Echelon de 4�me s�rie. Capital de 50 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('30','Classement','Echelon de 3�me s�rie. Capital de 80 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/5','Classement','Echelon de 3�me s�rie. Capital de 120 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/4','Classement','Echelon de 3�me s�rie. Capital de 160 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/3','Classement','Echelon de 3�me s�rie. Capital de 200 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/2','Classement','Echelon de 3�me s�rie. Capital de 240 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15/1','Classement','Echelon de 3�me s�rie. Capital de 280 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('15','Classement','Echelon de 2�me s�rie. Capital de 330 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('5/6','Classement','Echelon de 2�me s�rie. Capital de 370 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('4/6','Classement','Echelon de 2�me s�rie. Capital de 410 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('3/6','Classement','Echelon de 2�me s�rie. Capital de 450 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('2/6','Classement','Echelon de 2�me s�rie. Capital de 490 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('1/6','Classement','Echelon de 2�me s�rie. Capital de 530 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('0','Classement','Echelon de 2�me s�rie. Capital de 570 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-2/6','Classement','Echelon de 2�me s�rie -. Capital de 620 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-4/6','Classement','Echelon de 2�me s�rie -. Capital de 660 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-15','Classement','Echelon de 2�me s�rie -. Capital de 700 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('-30','Classement','Echelon de 2�me s�rie -. Capital de 740 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('Promo','Classement','Echelon promotion. Capital de 780 points.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('1erSe','Classement','Echelon de 1�re s�rie. Capital de 840 points.');
--Fin des codifications des niveaux pour les tables PERSONNE et ENTRAINEMENT

--D�but des codifications des statuts pour la table PERSONNE
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Utilisateur','Englobe la plupart des utilisateurs du syst�me.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Joueur','Personne physique inscrite au club.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Visiteur','Paye � chaque r�servation. Aucun abonnement.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Adh�rent','Paye un abonnement. R�servations gratuites.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Employ�','Personne salari�e du club.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Entraineur','Dispense des entrainements aux adh�rents.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Agent d''accueil','Pr�sent dans les bureaux du club.');
INSERT INTO CODIFICATION(CODE,NATURE,LIBELLE)
VALUES('ROLE','Administrateur','Dispose de tous les droits sur le syst�me.');
--Fin des codifications des statuts pour la table PERSONNE

-- -----------------------------------------------------------------------------
--       TABLE : TERRAIN
-- -----------------------------------------------------------------------------

INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(1,'DURRA','Rebound Ace',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(2,'DURDE','Decoturf',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(3,'DURBE','B�ton',0);
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
VALUES(15,'TERBS','Terre battue synth�.',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(16,'ACRYL','Acrylique',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(17,'ASPHA','Asphalte',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(18,'GAZSY','Gazon synth�tique',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(19,'AUTBO','bois',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(20,'AUTTB','Toile sur bois',0);
INSERT INTO TERRAIN(NUM_TERRAIN,CODE_SURFACE,NATURE,ACTIF)
VALUES(21,'AUTTM','Tuiles modulables',0);	

--Validation des insertions des donn�es
COMMIT;	 
