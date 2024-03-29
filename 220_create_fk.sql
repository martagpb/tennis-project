     -- -----------------------------------------------------------------------------
--            Cr�ation des cl� �trang�res de la base de donn�es pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 10/5/2011
-- -----------------------------------------------------------------------------
 
 
 
 
 
 
-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE FACTURE ADD (
     CONSTRAINT FK_FACTURE_PERSONNE
          FOREIGN KEY (NUM_PERSONNE)
               REFERENCES PERSONNE (NUM_PERSONNE))   ;

ALTER TABLE TERRAIN ADD (
     CONSTRAINT FK_TERRAIN_CODIFICATION
          FOREIGN KEY (NATURE_SURFACE, CODE_SURFACE)
               REFERENCES CODIFICATION (NATURE, CODE))   ;

ALTER TABLE ENTRAINEMENT ADD (
     CONSTRAINT FK_ENTRAINEMENT_CODIFICATION
          FOREIGN KEY (NATURE_NIVEAU, CODE_NIVEAU)
               REFERENCES CODIFICATION (NATURE ,CODE))   ;
			   
ALTER TABLE ENTRAINEMENT ADD (
     CONSTRAINT FK_ENTRAINEMENT_PERSONNE
          FOREIGN KEY (NUM_ENTRAINEUR)
               REFERENCES PERSONNE (NUM_PERSONNE))   ;

ALTER TABLE MENSUALITE ADD (
     CONSTRAINT FK_MENSUALITE_ABONNEMENT
          FOREIGN KEY (NUM_ABONNEMENT)
               REFERENCES ABONNEMENT (NUM_ABONNEMENT))   ;

ALTER TABLE ABONNEMENT ADD (
     CONSTRAINT FK_ABONNEMENT_PERSONNE
          FOREIGN KEY (NUM_JOUEUR)
               REFERENCES PERSONNE (NUM_PERSONNE))   ;

ALTER TABLE ETRE_ASSOCIE ADD (
     CONSTRAINT FK_ETRE_ASSOCIE_PERSONNE
          FOREIGN KEY (NUM_PERSONNE)
               REFERENCES PERSONNE (NUM_PERSONNE))   ;

ALTER TABLE ETRE_ASSOCIE ADD (
     CONSTRAINT FK_ETRE_ASSOCIE_OCCUPER
          FOREIGN KEY (HEURE_DEBUT_CRENEAU, NUM_TERRAIN, DATE_OCCUPATION)
               REFERENCES OCCUPER (HEURE_DEBUT_CRENEAU, NUM_TERRAIN, DATE_OCCUPATION))   ;
			   
ALTER TABLE S_INSCRIRE ADD (
     CONSTRAINT FK_S_INSCRIRE_ENTRAINEMENT
          FOREIGN KEY (NUM_ENTRAINEMENT)
               REFERENCES ENTRAINEMENT (NUM_ENTRAINEMENT))   ;

ALTER TABLE S_INSCRIRE ADD (
     CONSTRAINT FK_S_INSCRIRE_PERSONNE
          FOREIGN KEY (NUM_PERSONNE)
               REFERENCES PERSONNE (NUM_PERSONNE))   ;

ALTER TABLE AVOIR_LIEU ADD (
     CONSTRAINT FK_AVOIR_LIEU_ENTRAINEMENT
          FOREIGN KEY (NUM_ENTRAINEMENT)
               REFERENCES ENTRAINEMENT (NUM_ENTRAINEMENT))   ;

ALTER TABLE AVOIR_LIEU ADD (
     CONSTRAINT FK_AVOIR_LIEU_CRENEAU
          FOREIGN KEY (HEURE_DEBUT_CRENEAU)
               REFERENCES CRENEAU (HEURE_DEBUT_CRENEAU))   ;

ALTER TABLE AVOIR_LIEU ADD (
     CONSTRAINT FK_AVOIR_LIEU_TERRAIN
          FOREIGN KEY (NUM_TERRAIN)
               REFERENCES TERRAIN (NUM_TERRAIN))   ;

ALTER TABLE OCCUPER ADD (
     CONSTRAINT FK_OCCUPER_CRENEAU
          FOREIGN KEY (HEURE_DEBUT_CRENEAU)
               REFERENCES CRENEAU (HEURE_DEBUT_CRENEAU))   ;

ALTER TABLE OCCUPER ADD (
     CONSTRAINT FK_OCCUPER_TERRAIN
          FOREIGN KEY (NUM_TERRAIN)
               REFERENCES TERRAIN (NUM_TERRAIN))   ;

ALTER TABLE OCCUPER ADD (
     CONSTRAINT FK_OCCUPER_FACTURE
          FOREIGN KEY (NUM_FACTURE)
               REFERENCES FACTURE (NUM_FACTURE))   ;

ALTER TABLE OCCUPER ADD (
     CONSTRAINT FK_OCCUPER_PERSONNE
          FOREIGN KEY (NUM_JOUEUR)
               REFERENCES PERSONNE (NUM_PERSONNE))   ;

ALTER TABLE OCCUPER ADD (
     CONSTRAINT FK_OCCUPER_ENTRAINEMENT
          FOREIGN KEY (NUM_ENTRAINEMENT)
               REFERENCES ENTRAINEMENT (NUM_ENTRAINEMENT))   ;

ALTER TABLE PERSONNE ADD (
     CONSTRAINT FK_PERSONNE_CODIFICATION
          FOREIGN KEY (NATURE_STATUT_EMPLOYE, CODE_STATUT_EMPLOYE)
               REFERENCES CODIFICATION (NATURE, CODE))   ;

ALTER TABLE PERSONNE ADD (
     CONSTRAINT FK_PERSONNE_CODIFICATION1
          FOREIGN KEY (NATURE_NIVEAU, CODE_NIVEAU)
               REFERENCES CODIFICATION (NATURE, CODE))   ;