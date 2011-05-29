         -- -----------------------------------------------------------------------------
--            Déclaration des triggers de la base de données pour
--                      Oracle Version 10g
--                        (11/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 11/5/2011
-- -----------------------------------------------------------------------------
 
 





-- ------------------------------------------------------------------------------- 
--   Table : PERSONNE
-- ------------------------------------------------------------------------------- 


-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_PERSONNE
after delete on PERSONNE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table ABONNEMENT.

     select count(*) into numrows
     from ABONNEMENT
     where
          ABONNEMENT.NUM_JOUEUR = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "ABONNEMENT" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table S_INSCRIRE.

     select count(*) into numrows
     from S_INSCRIRE
     where
          S_INSCRIRE.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "S_INSCRIRE" existent.');
     end if;
	 
     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table ENTRAINEMENT.

     select count(*) into numrows
     from ENTRAINEMENT
     where
          ENTRAINEMENT.NUM_ENTRAINEUR = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "ENTRAINEMENT" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table ETRE_ASSOCIE.

     select count(*) into numrows
     from ETRE_ASSOCIE
     where
          ETRE_ASSOCIE.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "ETRE_ASSOCIE" existent.');
     end if;
	 
     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table OCCUPER.

     select count(*) into numrows
     from OCCUPER
     where
          OCCUPER.NUM_JOUEUR = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "OCCUPER" existent.');
     end if;

end;
/


-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_PERSONNE
after update on PERSONNE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PERSONNE s'il n'existe pas d'occurrence correspondante de la 
     -- table CODIFICATION.

     if
		  :old.CODE_STATUT_EMPLOYE <> :new.CODE_STATUT_EMPLOYE and
		  :old.NATURE_STATUT_EMPLOYE <> :new.NATURE_STATUT_EMPLOYE
     then
          select count(*) into numrows
          from CODIFICATION
          where
               :new.CODE_STATUT_EMPLOYE = CODIFICATION.CODE and
               :new.NATURE_STATUT_EMPLOYE = CODIFICATION.NATURE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "PERSONNE" car "CODIFICATION" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PERSONNE s'il n'existe pas d'occurrence correspondante de la 
     -- table CODIFICATION.

     if
          :old.CODE_NIVEAU <> :new.CODE_NIVEAU and
		  :old.NATURE_NIVEAU <> :new.NATURE_NIVEAU
     then
          select count(*) into numrows
          from CODIFICATION
          where
               :new.CODE_NIVEAU = CODIFICATION.CODE and
               :new.NATURE_NIVEAU = CODIFICATION.NATURE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "PERSONNE" car "CODIFICATION" n''existe pas.');
          end if;
     end if;
	 
     -- Répercuter la modification de la clé primaire de PERSONNE sur les 
     -- occurrences correspondantes de la table ABONNEMENT.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          update ABONNEMENT
          set
               ABONNEMENT.NUM_JOUEUR = :new.NUM_PERSONNE
          where
               ABONNEMENT.NUM_JOUEUR = :old.NUM_PERSONNE;
     end if;
	 
     -- Répercuter la modification de la clé primaire de PERSONNE sur les 
     -- occurrences correspondantes de la table S_INSCRIRE.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
		  update S_INSCRIRE
          set
               S_INSCRIRE.NUM_PERSONNE = :new.NUM_PERSONNE
          where
               S_INSCRIRE.NUM_PERSONNE = :old.NUM_PERSONNE;
     end if;
	 
	 -- Répercuter la modification de la clé primaire de PERSONNE sur les 
     -- occurrences correspondantes de la table ENTRAINEMENT.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
		  update ENTRAINEMENT
          set
               ENTRAINEMENT.NUM_ENTRAINEUR = :new.NUM_PERSONNE
          where
               ENTRAINEMENT.NUM_ENTRAINEUR = :old.NUM_PERSONNE;
     end if;
	 

	 -- Répercuter la modification de la clé primaire de PERSONNE sur les 
     -- occurrences correspondantes de la table ETRE_ASSOCIE.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
		  update ETRE_ASSOCIE
          set
               ETRE_ASSOCIE.NUM_PERSONNE = :new.NUM_PERSONNE
          where
               ETRE_ASSOCIE.NUM_PERSONNE = :old.NUM_PERSONNE;
     end if;

	 -- Répercuter la modification de la clé primaire de PERSONNE sur les 
     -- occurrences correspondantes de la table OCCUPER.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
		  update OCCUPER
          set
               OCCUPER.NUM_JOUEUR = :new.NUM_PERSONNE
          where
               OCCUPER.NUM_JOUEUR = :old.NUM_PERSONNE;
     end if;
	
end;
/

-- Trigger d'insertion BEFORE----------------------------------------------
CREATE OR REPLACE TRIGGER TI_PERSONNE_BEFORE
	BEFORE INSERT ON PERSONNE
	REFERENCING OLD as OLD NEW as NEW
	FOR EACH ROW BEGIN
	IF inserting then 
		SELECT SEQ_PERSONNE.NEXTVAL
		INTO :NEW.NUM_PERSONNE
		FROM DUAL;
	END IF;
END;
/





-- ------------------------------------------------------------------------------- 
--   Table : FACTURE
-- ------------------------------------------------------------------------------- 


-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_FACTURE
after delete on FACTURE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de FACTURE s'il existe des
     -- occurrences correspondantes de la table OCCUPER.

     select count(*) into numrows
     from OCCUPER
     where
          OCCUPER.NUM_FACTURE = :old.NUM_FACTURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "FACTURE". Des occurrences de "OCCUPER" existent.');
     end if;

end;
/


-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_FACTURE
after update on FACTURE for each row
declare numrows INTEGER;
begin

     -- Ne pas modifier la clé primaire de la table FACTURE s'il existe des 
     -- occurrences correspondantes dans la table OCCUPER.

     if
          :old.NUM_FACTURE <> :new.NUM_FACTURE
     then
          select count(*) into numrows
          from OCCUPER
          where
               OCCUPER.NUM_FACTURE = :old.NUM_FACTURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "FACTURE" car "OCCUPER" existe.');
          end if;
     end if;

end;
/

-- Trigger d'insertion BEFORE----------------------------------------------
CREATE OR REPLACE TRIGGER TI_FACTURE_BEFORE
	BEFORE INSERT ON FACTURE
	REFERENCING OLD as OLD NEW as NEW
	FOR EACH ROW BEGIN
	IF inserting then 
		SELECT SEQ_FACTURE.NEXTVAL
		INTO :NEW.NUM_FACTURE
		FROM DUAL;
	END IF;
END;
/



-- ------------------------------------------------------------------------------- 
--   Table : CRENEAU
-- ------------------------------------------------------------------------------- 


-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_CRENEAU
after delete on CRENEAU for each row
declare numrows INTEGER;
begin
     -- Interdire la suppression d'une occurrence de CRENEAU s'il existe des
     -- occurrences correspondantes de la table ETRE_ASSOCIE
	 select count(*) into numrows
     from ETRE_ASSOCIE
     where
          ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CRENEAU". Des occurrences de "ETRE_ASSOCIE" existent.');
     end if;
	 
     -- Supprimer les occurrences correspondantes de la table AVOIR_LIEU.

     delete from AVOIR_LIEU
     where
          AVOIR_LIEU.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     -- Supprimer les occurrences correspondantes de la table OCCUPER.

     delete from OCCUPER
     where
          OCCUPER.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
end;
/


-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_CRENEAU
after update on CRENEAU for each row
declare numrows INTEGER;
begin
     -- Ne pas modifier la clé primaire de la table CRENEAU s'il existe des 
     -- occurrences correspondantes dans la table ETRE_ASSOCIE.
	     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU
     then
          select count(*) into numrows
          from ETRE_ASSOCIE
          where
               ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CRENEAU" car "ETRE_ASSOCIE" existe.');
          end if;
     end if;
	 
     -- Répercuter la modification de la clé primaire de CRENEAU sur les 
     -- occurrences correspondantes de la table AVOIR_LIEU.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU
     then
          update AVOIR_LIEU
          set
               AVOIR_LIEU.HEURE_DEBUT_CRENEAU = :new.HEURE_DEBUT_CRENEAU
          where
               AVOIR_LIEU.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     end if;
	 
     -- Répercuter la modification de la clé primaire de CRENEAU sur les 
     -- occurrences correspondantes de la table OCCUPER.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU
     then
          update OCCUPER
          set
               OCCUPER.HEURE_DEBUT_CRENEAU = :new.HEURE_DEBUT_CRENEAU
          where
               OCCUPER.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : TERRAIN
-- ------------------------------------------------------------------------------- 



-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_TERRAIN
after delete on TERRAIN for each row
declare numrows INTEGER;
begin
	 
	 -- Ne pas supprimer un terrain s'il existe des 
     -- occurrences correspondantes dans la table ETRE_ASSOCIE.
        select count(*) into numrows
        from ETRE_ASSOCIE
        where
             ETRE_ASSOCIE.NUM_TERRAIN = :old.NUM_TERRAIN;
        if (numrows > 0)
        then 
             raise_application_error(
                  -20001,
                  'Impossible de supprimer "TERRAIN" car "ETRE_ASSOCIE" existe.');
        end if;
	 
     -- Supprimer les occurrences correspondantes de la table AVOIR_LIEU.

     delete from AVOIR_LIEU
     where
          AVOIR_LIEU.NUM_TERRAIN = :old.NUM_TERRAIN;
     -- Supprimer les occurrences correspondantes de la table OCCUPER.

     delete from OCCUPER
     where
          OCCUPER.NUM_TERRAIN = :old.NUM_TERRAIN;

end;
/



-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_TERRAIN
after update on TERRAIN for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table TERRAIN s'il n'existe pas d'occurrence correspondante de la 
     -- table CODIFICATION.

     if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          select count(*) into numrows
          from CODIFICATION
          where
               :new.CODE_SURFACE = CODIFICATION.CODE and
               :new.NATURE_SURFACE = CODIFICATION.NATURE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "TERRAIN" car "CODIFICATION" n''existe pas.');
          end if;
     end if;
     
     -- Répercuter la modification de la clé primaire de TERRAIN sur les 
     -- occurrences correspondantes de la table AVOIR_LIEU.

     if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          update AVOIR_LIEU
          set
               AVOIR_LIEU.NUM_TERRAIN = :new.NUM_TERRAIN
          where
               AVOIR_LIEU.NUM_TERRAIN = :old.NUM_TERRAIN;
     end if;
     -- Répercuter la modification de la clé primaire de TERRAIN sur les 
     -- occurrences correspondantes de la table OCCUPER.

     if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          update OCCUPER
          set
               OCCUPER.NUM_TERRAIN = :new.NUM_TERRAIN
          where
               OCCUPER.NUM_TERRAIN = :old.NUM_TERRAIN;
     end if;
	 
	 -- Répercuter la modification de la clé primaire de TERRAIN sur les 
     -- occurrences correspondantes de la table ETRE_ASSOCIE.
	 if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          update ETRE_ASSOCIE
          set
               ETRE_ASSOCIE.NUM_TERRAIN = :new.NUM_TERRAIN
          where
               ETRE_ASSOCIE.NUM_TERRAIN = :old.NUM_TERRAIN;
     end if;

end;
/


-- Trigger d'insertion BEFORE----------------------------------------------
CREATE OR REPLACE TRIGGER TI_TERRAIN_BEFORE
	BEFORE INSERT ON TERRAIN
	REFERENCING OLD as OLD NEW as NEW
	FOR EACH ROW BEGIN
	IF inserting then 
		SELECT SEQ_TERRAIN.NEXTVAL
		INTO :NEW.NUM_TERRAIN
		FROM DUAL;
	END IF;
END;
/



-- Trigger d'insertion AFTER----------------------------------------------
CREATE OR REPLACE trigger TI_TERRAIN_AFTER
after insert on TERRAIN for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de TERRAIN 
     -- s'il n'existe pas d'occurrence correspondante dans la table CODIFICATION.

     select count(*) into numrows
     from CODIFICATION
     where
          :new.CODE_SURFACE = CODIFICATION.CODE and
          :new.NATURE_SURFACE = CODIFICATION.NATURE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "TERRAIN" car "CODIFICATION" n''existe pas.');
     end if;

end;
/







-- ------------------------------------------------------------------------------- 
--   Table : ENTRAINEMENT
-- ------------------------------------------------------------------------------- 


-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_ENTRAINEMENT
after delete on ENTRAINEMENT for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table S_INSCRIRE.

     delete from S_INSCRIRE
     where
          S_INSCRIRE.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     -- Supprimer les occurrences correspondantes de la table AVOIR_LIEU.

     delete from AVOIR_LIEU
     where
          AVOIR_LIEU.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     -- Interdire la suppression d'une occurrence de ENTRAINEMENT s'il existe des
     -- occurrences correspondantes de la table OCCUPER.

     select count(*) into numrows
     from OCCUPER
     where
          OCCUPER.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "ENTRAINEMENT". Des occurrences de "OCCUPER" existent.');
     end if;

end;
/



-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_ENTRAINEMENT
after update on ENTRAINEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ENTRAINEMENT s'il n'existe pas d'occurrence correspondante de la 
     -- table CODIFICATION.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          select count(*) into numrows
          from CODIFICATION
          where
               :new.CODE_NIVEAU = CODIFICATION.CODE and
               :new.NATURE_NIVEAU = CODIFICATION.NATURE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ENTRAINEMENT" car "CODIFICATION" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ENTRAINEMENT s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          select count(*) into numrows
          from PERSONNE
          where
               :new.NUM_ENTRAINEUR = PERSONNE.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ENTRAINEMENT" car "PERSONNE" n''existe pas.');
          end if;
     end if;
     
     -- Répercuter la modification de la clé primaire de ENTRAINEMENT sur les 
     -- occurrences correspondantes de la table S_INSCRIRE.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          update S_INSCRIRE
          set
               S_INSCRIRE.NUM_ENTRAINEMENT = :new.NUM_ENTRAINEMENT
          where
               S_INSCRIRE.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     end if;
     -- Répercuter la modification de la clé primaire de ENTRAINEMENT sur les 
     -- occurrences correspondantes de la table AVOIR_LIEU.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          update AVOIR_LIEU
          set
               AVOIR_LIEU.NUM_ENTRAINEMENT = :new.NUM_ENTRAINEMENT
          where
               AVOIR_LIEU.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     end if;
     -- Ne pas modifier la clé primaire de la table ENTRAINEMENT s'il existe des 
     -- occurrences correspondantes dans la table OCCUPER.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          select count(*) into numrows
          from OCCUPER
          where
               OCCUPER.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "ENTRAINEMENT" car "OCCUPER" existe.');
          end if;
     end if;

end;
/



-- Trigger d'insertion AFTER----------------------------------------------
CREATE OR REPLACE trigger TI_ENTRAINEMENT_AFTER
after insert on ENTRAINEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ENTRAINEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table CODIFICATION.

     select count(*) into numrows
     from CODIFICATION
     where
          :new.CODE_NIVEAU = CODIFICATION.CODE and
          :new.NATURE_NIVEAU = CODIFICATION.NATURE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ENTRAINEMENT" car "CODIFICATION" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ENTRAINEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          :new.NUM_ENTRAINEUR = PERSONNE.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ENTRAINEMENT" car "PERSONNE" n''existe pas.');
     end if;

end;
/


-- Trigger d'insertion BEFORE----------------------------------------------
CREATE OR REPLACE TRIGGER TI_ENTRAINEMENT_BEFORE
	BEFORE INSERT ON ENTRAINEMENT
	REFERENCING OLD as OLD NEW as NEW
	FOR EACH ROW BEGIN
	IF inserting then 
		SELECT SEQ_ENTRAINEMENT.NEXTVAL
		INTO :NEW.NUM_ENTRAINEMENT
		FROM DUAL;
	END IF;
END;
/



-- ------------------------------------------------------------------------------- 
--   Table : MENSUALITE
-- ------------------------------------------------------------------------------- 



-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_MENSUALITE
after update on MENSUALITE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- ABONNEMENT.

     if
          :old.NUM_ABONNEMENT <> :new.NUM_ABONNEMENT or 
          :old.ANNEE_MOIS_MENSUALITE <> :new.ANNEE_MOIS_MENSUALITE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "ABONNEMENT" interdite.');
     end if;

end;
/



-- Trigger d'insertion AFTER----------------------------------------------
CREATE OR REPLACE trigger TI_MENSUALITE_AFTER
after insert on MENSUALITE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de MENSUALITE 
     -- s'il n'existe pas d'occurrence correspondante dans la table ABONNEMENT.

     select count(*) into numrows
     from ABONNEMENT
     where
          :new.NUM_ABONNEMENT = ABONNEMENT.NUM_ABONNEMENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "MENSUALITE" car "ABONNEMENT" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ABONNEMENT
-- ------------------------------------------------------------------------------- 



-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_ABONNEMENT
after delete on ABONNEMENT for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de ABONNEMENT s'il existe des
     -- occurrences correspondantes de la table MENSUALITE.

     select count(*) into numrows
     from MENSUALITE
     where
          MENSUALITE.NUM_ABONNEMENT = :old.NUM_ABONNEMENT;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "ABONNEMENT". Des occurrences de "MENSUALITE" existent.');
     end if;

end;
/



-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_ABONNEMENT
after update on ABONNEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ABONNEMENT s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE.

     if
          :old.NUM_ABONNEMENT <> :new.NUM_ABONNEMENT
     then
          select count(*) into numrows
          from PERSONNE
          where
               :new.NUM_JOUEUR = PERSONNE.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ABONNEMENT" car "PERSONNE" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ABONNEMENT s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE.

     if
          :old.NUM_ABONNEMENT <> :new.NUM_ABONNEMENT
     then
          select count(*) into numrows
          from PERSONNE
          where
               :new.NUM_JOUEUR = PERSONNE.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ABONNEMENT" car "PERSONNE" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de ABONNEMENT sur les 
     -- occurrences correspondantes de la table MENSUALITE.

     if
          :old.NUM_ABONNEMENT <> :new.NUM_ABONNEMENT
     then
          update MENSUALITE
          set
               MENSUALITE.NUM_ABONNEMENT = :new.NUM_ABONNEMENT
          where
               MENSUALITE.NUM_ABONNEMENT = :old.NUM_ABONNEMENT;
     end if;

end;
/



-- Trigger d'insertion AFTER----------------------------------------------
CREATE OR REPLACE trigger TI_ABONNEMENT_AFTER
after insert on ABONNEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ABONNEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          :new.NUM_JOUEUR = PERSONNE.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ABONNEMENT" car "PERSONNE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ABONNEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          :new.NUM_JOUEUR = PERSONNE.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ABONNEMENT" car "PERSONNE" n''existe pas.');
     end if;

end;
/


-- Trigger d'insertion BEFORE----------------------------------------------
CREATE OR REPLACE TRIGGER TI_ABONNEMENT_BEFORE
	BEFORE INSERT ON ABONNEMENT
	REFERENCING OLD as OLD NEW as NEW
	FOR EACH ROW BEGIN
	IF inserting then 
		SELECT SEQ_ABONNEMENT.NEXTVAL
		INTO :NEW.NUM_ABONNEMENT
		FROM DUAL;
	END IF;
END;
/


-- ------------------------------------------------------------------------------- 
--   Table : ETRE_ASSOCIE
-- ------------------------------------------------------------------------------- 


-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_ETRE_ASSOCIE
after update on ETRE_ASSOCIE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETRE_ASSOCIE s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from PERSONNE
          where
               :new.NUM_PERSONNE = PERSONNE.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETRE_ASSOCIE" car "PERSONNE" n''existe pas.');
          end if;
     end if;
	 
	 -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETRE_ASSOCIE s'il n'existe pas d'occurrence correspondante de la 
     -- table CRENEAU.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU
     then
          select count(*) into numrows
          from CRENEAU
          where
               :new.HEURE_DEBUT_CRENEAU = CRENEAU.HEURE_DEBUT_CRENEAU;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETRE_ASSOCIE" car "CRENEAU" n''existe pas.');
          end if;
     end if;
	 
	 -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETRE_ASSOCIE s'il n'existe pas d'occurrence correspondante de la 
     -- table TERRAIN.

     if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          select count(*) into numrows
          from TERRAIN
          where
               :new.NUM_TERRAIN = TERRAIN.NUM_TERRAIN;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETRE_ASSOCIE" car "TERRAIN" n''existe pas.');
          end if;
     end if;
	 
	 -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETRE_ASSOCIE s'il n'existe pas d'occurrence correspondante de la 
     -- table OCCUPER.

     if
          :old.DATE_OCCUPATION <> :new.DATE_OCCUPATION
     then
          select count(*) into numrows
          from OCCUPER
          where
               :new.DATE_OCCUPATION = OCCUPER.DATE_OCCUPATION;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETRE_ASSOCIE" car "OCCUPER" n''existe pas.');
          end if;
     end if;

end;
/



-- Trigger d'insertion ----------------------------------------------
CREATE OR REPLACE trigger TI_ETRE_ASSOCIE
after insert on ETRE_ASSOCIE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_ASSOCIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table OCCUPER.

     select count(*) into numrows
     from OCCUPER
     where
          :new.DATE_OCCUPATION = OCCUPER.DATE_OCCUPATION;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETRE_ASSOCIE" car "OCCUPER" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_ASSOCIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          :new.NUM_PERSONNE = PERSONNE.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETRE_ASSOCIE" car "PERSONNE" n''existe pas.');
     end if;
	 
	 -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_ASSOCIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table CRENEAU.

     select count(*) into numrows
     from CRENEAU
     where
          :new.HEURE_DEBUT_CRENEAU = CRENEAU.HEURE_DEBUT_CRENEAU;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETRE_ASSOCIE" car "CRENEAU" n''existe pas.');
     end if;
	 
	 -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_ASSOCIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table TERRAIN.

     select count(*) into numrows
     from TERRAIN
     where
          :new.NUM_TERRAIN = TERRAIN.NUM_TERRAIN;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETRE_ASSOCIE" car "TERRAIN" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : S_INSCRIRE
-- ------------------------------------------------------------------------------- 



-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_S_INSCRIRE
after update on S_INSCRIRE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- ENTRAINEMENT.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT or 
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "ENTRAINEMENT" interdite.');
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table S_INSCRIRE s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT or 
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from PERSONNE
          where
               :new.NUM_PERSONNE = PERSONNE.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "S_INSCRIRE" car "PERSONNE" n''existe pas.');
          end if;
     end if;

end;
/


-- Trigger d'insertion ----------------------------------------------
CREATE OR REPLACE trigger TI_S_INSCRIRE
after insert on S_INSCRIRE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de S_INSCRIRE 
     -- s'il n'existe pas d'occurrence correspondante dans la table ENTRAINEMENT.

     select count(*) into numrows
     from ENTRAINEMENT
     where
          :new.NUM_ENTRAINEMENT = ENTRAINEMENT.NUM_ENTRAINEMENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "S_INSCRIRE" car "ENTRAINEMENT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de S_INSCRIRE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          :new.NUM_PERSONNE = PERSONNE.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "S_INSCRIRE" car "PERSONNE" n''existe pas.');
     end if;

end;
/


-- Trigger d'insertion BEFORE----------------------------------------------
CREATE OR REPLACE TRIGGER TI_S_INSCRIRE_BEFORE
	BEFORE INSERT ON S_INSCRIRE
	FOR EACH ROW
	DECLARE 
		PERSONNE_CODE_NIVEAU PERSONNE.CODE_NIVEAU%TYPE;
		ENTRAINEMENT_CODE_NIVEAU ENTRAINEMENT.CODE_NIVEAU%TYPE;
	BEGIN
	IF inserting then 
		SELECT
			PER.CODE_NIVEAU INTO PERSONNE_CODE_NIVEAU
		FROM
			PERSONNE PER
		WHERE
			PER.NUM_PERSONNE=:NEW.NUM_PERSONNE;
			
		SELECT
			ENT.CODE_NIVEAU INTO ENTRAINEMENT_CODE_NIVEAU
		FROM
			ENTRAINEMENT ENT
		WHERE
			ENT.NUM_ENTRAINEMENT=:NEW.NUM_ENTRAINEMENT;
			
		IF PERSONNE_CODE_NIVEAU <> ENTRAINEMENT_CODE_NIVEAU THEN
			 raise_application_error(
               -20002,
               'Impossible d''inscrire la personne car elle n''a pas le niveau requis pour cet entrainement');
		END IF;
	END IF;
END;
/



-- ------------------------------------------------------------------------------- 
--   Table : AVOIR_LIEU
-- ------------------------------------------------------------------------------- 


-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_AVOIR_LIEU
after update on AVOIR_LIEU for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table AVOIR_LIEU s'il n'existe pas d'occurrence correspondante de la 
     -- table ENTRAINEMENT.

     if
          :old.NUM_JOUR <> :new.NUM_JOUR or 
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          select count(*) into numrows
          from ENTRAINEMENT
          where
               :new.NUM_ENTRAINEMENT = ENTRAINEMENT.NUM_ENTRAINEMENT;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "AVOIR_LIEU" car "ENTRAINEMENT" n''existe pas.');
          end if;
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- CRENEAU.

     if
          :old.NUM_JOUR <> :new.NUM_JOUR or 
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CRENEAU" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- TERRAIN.

     if
          :old.NUM_JOUR <> :new.NUM_JOUR or 
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "TERRAIN" interdite.');
     end if;

end;
/


-- Trigger d'insertion ----------------------------------------------
CREATE OR REPLACE trigger TI_AVOIR_LIEU
after insert on AVOIR_LIEU for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de AVOIR_LIEU 
     -- s'il n'existe pas d'occurrence correspondante dans la table ENTRAINEMENT.

     select count(*) into numrows
     from ENTRAINEMENT
     where
          :new.NUM_ENTRAINEMENT = ENTRAINEMENT.NUM_ENTRAINEMENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "AVOIR_LIEU" car "ENTRAINEMENT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de AVOIR_LIEU 
     -- s'il n'existe pas d'occurrence correspondante dans la table CRENEAU.

     select count(*) into numrows
     from CRENEAU
     where
          :new.HEURE_DEBUT_CRENEAU = CRENEAU.HEURE_DEBUT_CRENEAU;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "AVOIR_LIEU" car "CRENEAU" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de AVOIR_LIEU 
     -- s'il n'existe pas d'occurrence correspondante dans la table TERRAIN.

     select count(*) into numrows
     from TERRAIN
     where
          :new.NUM_TERRAIN = TERRAIN.NUM_TERRAIN;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "AVOIR_LIEU" car "TERRAIN" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : OCCUPER
-- ------------------------------------------------------------------------------- 

-- Trigger de suppression -----------------------------------------------
CREATE OR REPLACE trigger TD_OCCUPER
after delete on OCCUPER for each row 
declare numrows INTEGER;
begin
     -- Interdire la suppression d'une occurrence de OCCUPER s'il existe des
     -- occurrences correspondantes de la table ETRE_ASSOCIE.

     select count(*) into numrows
     from ETRE_ASSOCIE
     where
          ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU and
		  ETRE_ASSOCIE.NUM_TERRAIN = :old.NUM_TERRAIN and
		  ETRE_ASSOCIE.DATE_OCCUPATION = :old.DATE_OCCUPATION;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "OCCUPER". Des occurrences de "ETRE_ASSOCIE" existent.');
     end if;
end;
/

-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_OCCUPER
after update on OCCUPER for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé primaire heure_debut_creneau si
     -- le creneau n'existe pas dans la table CRENEAU

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU 
     then
		  select count(*) into numrows
          from CRENEAU
          where
               :new.HEURE_DEBUT_CRENEAU = CRENEAU.HEURE_DEBUT_CRENEAU;
          if 
               (
               numrows = 0 
               )
		  then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CRENEAU" interdite.');
		 end if;
     end if;
	 
     -- Interdire la modification de la clé primaire terrain si
     -- le terrain n'existe pas dans la table TERRAIN

     if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN 
     then
		  select count(*) into numrows
          from TERRAIN
          where
               :new.NUM_TERRAIN = TERRAIN.NUM_TERRAIN;
          if 
               (
               numrows = 0 
               )
		  then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "TERRAIN" interdite.');
		 end if;
     end if;
	 
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPER s'il n'existe pas d'occurrence correspondante de la 
     -- table ENTRAINEMENT.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          select count(*) into numrows
          from ENTRAINEMENT
          where
               :new.NUM_ENTRAINEMENT = ENTRAINEMENT.NUM_ENTRAINEMENT;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "OCCUPER" car "ENTRAINEMENT" n''existe pas.');
          end if;
     end if;
	 
	      -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPER s'il n'existe pas d'occurrence correspondante de la 
     -- table FACTURE.

     if
          :old.NUM_FACTURE <> :new.NUM_FACTURE
     then
          select count(*) into numrows
          from FACTURE
          where
               :new.NUM_FACTURE = FACTURE.NUM_FACTURE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "OCCUPER" car "FACTURE" n''existe pas.');
          end if;
     end if;
	 
	 -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPER s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE.

     if
          :old.NUM_JOUEUR <> :new.NUM_JOUEUR
     then
          select count(*) into numrows
          from PERSONNE
          where
               :new.NUM_JOUEUR = PERSONNE.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "OCCUPER" car "PERSONNE" n''existe pas.');
          end if;
     end if;

end;
/


-- Trigger d'insertion ----------------------------------------------
CREATE OR REPLACE trigger TI_OCCUPER
after insert on OCCUPER for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPER 
     -- s'il n'existe pas d'occurrence correspondante dans la table CRENEAU.

     select count(*) into numrows
     from CRENEAU
     where
          :new.HEURE_DEBUT_CRENEAU = CRENEAU.HEURE_DEBUT_CRENEAU;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "OCCUPER" car "CRENEAU" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPER 
     -- s'il n'existe pas d'occurrence correspondante dans la table TERRAIN.

     select count(*) into numrows
     from TERRAIN
     where
          :new.NUM_TERRAIN = TERRAIN.NUM_TERRAIN;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "OCCUPER" car "TERRAIN" n''existe pas.');
     end if;
end;
/

-- ------------------------------------------------------------------------------- 
--   Table : CODIFICATION
-- ------------------------------------------------------------------------------- 


-- Trigger de suppression ----------------------------------------------
CREATE OR REPLACE trigger TD_CODIFICATION
after delete on CODIFICATION for each row
declare numrows INTEGER;
begin
	
	
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table TERRAIN.

     select count(*) into numrows
     from TERRAIN
     where
          TERRAIN.CODE_SURFACE = :old.CODE and
          TERRAIN.NATURE_SURFACE = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "TERRAIN" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          PERSONNE.CODE_STATUT_EMPLOYE = :old.CODE and
          PERSONNE.NATURE_STATUT_EMPLOYE = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "PERSONNE" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table PERSONNE.

     select count(*) into numrows
     from PERSONNE
     where
          PERSONNE.CODE_NIVEAU = :old.CODE and
          PERSONNE.NATURE_NIVEAU = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "PERSONNE" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table ENTRAINEMENT.

     select count(*) into numrows
     from ENTRAINEMENT
     where
          ENTRAINEMENT.CODE_NIVEAU = :old.CODE and
          ENTRAINEMENT.NATURE_NIVEAU = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "ENTRAINEMENT" existent.');
     end if;

end;
/


-- Trigger de modification ----------------------------------------------
CREATE OR REPLACE trigger TU_CODIFICATION
after update on CODIFICATION for each row
declare numrows INTEGER;
begin

     -- Ne pas modifier la clé primaire de la table CODIFICATION s'il existe des 
     -- occurrences correspondantes dans la table TERRAIN.

     if
          :old.CODE <> :new.CODE or 
          :old.NATURE <> :new.NATURE
     then
          select count(*) into numrows
          from TERRAIN
          where
               TERRAIN.CODE_SURFACE = :old.CODE and
               TERRAIN.NATURE_SURFACE = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "TERRAIN" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table CODIFICATION s'il existe des 
     -- occurrences correspondantes dans la table PERSONNE.

     if
          :old.CODE <> :new.CODE or 
          :old.NATURE <> :new.NATURE
     then
          select count(*) into numrows
          from PERSONNE
          where
               PERSONNE.CODE_STATUT_EMPLOYE = :old.CODE and
               PERSONNE.NATURE_STATUT_EMPLOYE = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "PERSONNE" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table CODIFICATION s'il existe des 
     -- occurrences correspondantes dans la table PERSONNE.

     if
          :old.CODE <> :new.CODE or 
          :old.NATURE <> :new.NATURE
     then
          select count(*) into numrows
          from PERSONNE
          where
               PERSONNE.CODE_NIVEAU = :old.CODE and
               PERSONNE.NATURE_NIVEAU = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "PERSONNE" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table CODIFICATION s'il existe des 
     -- occurrences correspondantes dans la table ENTRAINEMENT.

     if
          :old.CODE <> :new.CODE or 
          :old.NATURE <> :new.NATURE
     then
          select count(*) into numrows
          from ENTRAINEMENT
          where
               ENTRAINEMENT.CODE_NIVEAU = :old.CODE and
               ENTRAINEMENT.NATURE_NIVEAU = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "ENTRAINEMENT" existe.');
          end if;
     end if;

end;
/




