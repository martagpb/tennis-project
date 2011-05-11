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

drop trigger TD_PERSONNE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_PERSONNE
after delete on PERSONNE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table ABONNEMENT.

     select count(*) into numrows
     from ABONNEMENT
     where
          ABONNEMENT.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "ABONNEMENT" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE s'il existe des
     -- occurrences correspondantes de la table ABONNEMENT.

     select count(*) into numrows
     from ABONNEMENT
     where
          ABONNEMENT.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE". Des occurrences de "ABONNEMENT" existent.');
     end if;

end;
/

drop trigger TU_PERSONNE;

-- Trigger de modification ----------------------------------------------
create trigger TU_PERSONNE
after update on PERSONNE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de PERSONNE sur les 
     -- occurrences correspondantes de la table ABONNEMENT.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          update ABONNEMENT
          set
               ABONNEMENT.NUM_PERSONNE = :new.NUM_PERSONNE
          where
               ABONNEMENT.NUM_PERSONNE = :old.NUM_PERSONNE;
     end if;
     -- Ne pas modifier la clé primaire de la table PERSONNE s'il existe des 
     -- occurrences correspondantes dans la table ABONNEMENT.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from ABONNEMENT
          where
               ABONNEMENT.NUM_PERSONNE = :old.NUM_PERSONNE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "PERSONNE" car "ABONNEMENT" existe.');
          end if;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : FACTURE
-- ------------------------------------------------------------------------------- 

drop trigger TD_FACTURE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_FACTURE
after delete on FACTURE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de FACTURE s'il existe des
     -- occurrences correspondantes de la table OCCUPATION.

     select count(*) into numrows
     from OCCUPATION
     where
          OCCUPATION.NUM_FACTURE = :old.NUM_FACTURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "FACTURE". Des occurrences de "OCCUPATION" existent.');
     end if;

end;
/

drop trigger TU_FACTURE;

-- Trigger de modification ----------------------------------------------
create trigger TU_FACTURE
after update on FACTURE for each row
declare numrows INTEGER;
begin

     -- Ne pas modifier la clé primaire de la table FACTURE s'il existe des 
     -- occurrences correspondantes dans la table OCCUPATION.

     if
          :old.NUM_FACTURE <> :new.NUM_FACTURE
     then
          select count(*) into numrows
          from OCCUPATION
          where
               OCCUPATION.NUM_FACTURE = :old.NUM_FACTURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "FACTURE" car "OCCUPATION" existe.');
          end if;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CRENEAU
-- ------------------------------------------------------------------------------- 

drop trigger TD_CRENEAU;

-- Trigger de suppression ----------------------------------------------
create trigger TD_CRENEAU
after delete on CRENEAU for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table AVOIR_LIEU.

     delete from AVOIR_LIEU
     where
          AVOIR_LIEU.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     -- Supprimer les occurrences correspondantes de la table OCCUPER.

     delete from OCCUPER
     where
          OCCUPER.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     -- Interdire la suppression d'une occurrence de CRENEAU s'il existe des
     -- occurrences correspondantes de la table OCCUPATION.

     select count(*) into numrows
     from OCCUPATION
     where
          OCCUPATION.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CRENEAU". Des occurrences de "OCCUPATION" existent.');
     end if;

end;
/

drop trigger TU_CRENEAU;

-- Trigger de modification ----------------------------------------------
create trigger TU_CRENEAU
after update on CRENEAU for each row
declare numrows INTEGER;
begin

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
     -- Ne pas modifier la clé primaire de la table CRENEAU s'il existe des 
     -- occurrences correspondantes dans la table OCCUPATION.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU
     then
          select count(*) into numrows
          from OCCUPATION
          where
               OCCUPATION.HEURE_DEBUT_CRENEAU = :old.HEURE_DEBUT_CRENEAU;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CRENEAU" car "OCCUPATION" existe.');
          end if;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : TERRAIN
-- ------------------------------------------------------------------------------- 

drop trigger TD_TERRAIN;

-- Trigger de suppression ----------------------------------------------
create trigger TD_TERRAIN
after delete on TERRAIN for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table ETRE_AFFECTE.

     delete from ETRE_AFFECTE
     where
          ETRE_AFFECTE.NUM_TERRAIN = :old.NUM_TERRAIN;
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

drop trigger TU_TERRAIN;

-- Trigger de modification ----------------------------------------------
create trigger TU_TERRAIN
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
               :new.NATURE = CODIFICATION.NATURE;
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
     -- occurrences correspondantes de la table ETRE_AFFECTE.

     if
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
          update ETRE_AFFECTE
          set
               ETRE_AFFECTE.NUM_TERRAIN = :new.NUM_TERRAIN
          where
               ETRE_AFFECTE.NUM_TERRAIN = :old.NUM_TERRAIN;
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

end;
/

drop trigger TI_TERRAIN;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_TERRAIN
after insert on TERRAIN for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de TERRAIN 
     -- s'il n'existe pas d'occurrence correspondante dans la table CODIFICATION.

     select count(*) into numrows
     from CODIFICATION
     where
          :new.CODE_SURFACE = CODIFICATION.CODE and
          :new.NATURE = CODIFICATION.NATURE;
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

drop trigger TD_ENTRAINEMENT;

-- Trigger de suppression ----------------------------------------------
create trigger TD_ENTRAINEMENT
after delete on ENTRAINEMENT for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table ETRE_AFFECTE.

     delete from ETRE_AFFECTE
     where
          ETRE_AFFECTE.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     -- Supprimer les occurrences correspondantes de la table S_INSCRIRE.

     delete from S_INSCRIRE
     where
          S_INSCRIRE.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     -- Supprimer les occurrences correspondantes de la table AVOIR_LIEU.

     delete from AVOIR_LIEU
     where
          AVOIR_LIEU.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     -- Interdire la suppression d'une occurrence de ENTRAINEMENT s'il existe des
     -- occurrences correspondantes de la table OCCUPATION.

     select count(*) into numrows
     from OCCUPATION
     where
          OCCUPATION.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "ENTRAINEMENT". Des occurrences de "OCCUPATION" existent.');
     end if;

end;
/

drop trigger TU_ENTRAINEMENT;

-- Trigger de modification ----------------------------------------------
create trigger TU_ENTRAINEMENT
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
               :new.NATURE = CODIFICATION.NATURE;
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
     -- table PERSONNE1.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          select count(*) into numrows
          from PERSONNE1
          where
               :new.NUM_EMPLOYE = PERSONNE1.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ENTRAINEMENT" car "PERSONNE1" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de ENTRAINEMENT sur les 
     -- occurrences correspondantes de la table ETRE_AFFECTE.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          update ETRE_AFFECTE
          set
               ETRE_AFFECTE.NUM_ENTRAINEMENT = :new.NUM_ENTRAINEMENT
          where
               ETRE_AFFECTE.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
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
     -- occurrences correspondantes dans la table OCCUPATION.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT
     then
          select count(*) into numrows
          from OCCUPATION
          where
               OCCUPATION.NUM_ENTRAINEMENT = :old.NUM_ENTRAINEMENT;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "ENTRAINEMENT" car "OCCUPATION" existe.');
          end if;
     end if;

end;
/

drop trigger TI_ENTRAINEMENT;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ENTRAINEMENT
after insert on ENTRAINEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ENTRAINEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table CODIFICATION.

     select count(*) into numrows
     from CODIFICATION
     where
          :new.CODE_NIVEAU = CODIFICATION.CODE and
          :new.NATURE = CODIFICATION.NATURE;
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
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          :new.NUM_EMPLOYE = PERSONNE1.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ENTRAINEMENT" car "PERSONNE1" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : MENSUALITE
-- ------------------------------------------------------------------------------- 

drop trigger TU_MENSUALITE;

-- Trigger de modification ----------------------------------------------
create trigger TU_MENSUALITE
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

drop trigger TI_MENSUALITE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_MENSUALITE
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
--   Table : OCCUPATION
-- ------------------------------------------------------------------------------- 

drop trigger TD_OCCUPATION;

-- Trigger de suppression ----------------------------------------------
create trigger TD_OCCUPATION
after delete on OCCUPATION for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table OCCUPER.

     delete from OCCUPER
     where
          OCCUPER.NUM_OCCUPATION = :old.NUM_OCCUPATION;
     -- Interdire la suppression d'une occurrence de OCCUPATION s'il existe des
     -- occurrences correspondantes de la table ETRE_ASSOCIE.

     select count(*) into numrows
     from ETRE_ASSOCIE
     where
          ETRE_ASSOCIE.NUM_OCCUPATION = :old.NUM_OCCUPATION;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "OCCUPATION". Des occurrences de "ETRE_ASSOCIE" existent.');
     end if;

end;
/

drop trigger TU_OCCUPATION;

-- Trigger de modification ----------------------------------------------
create trigger TU_OCCUPATION
after update on OCCUPATION for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPATION s'il n'existe pas d'occurrence correspondante de la 
     -- table FACTURE.

     if
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
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
               'Impossible de mettre à jour "OCCUPATION" car "FACTURE" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPATION s'il n'existe pas d'occurrence correspondante de la 
     -- table CRENEAU.

     if
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
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
               'Impossible de mettre à jour "OCCUPATION" car "CRENEAU" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPATION s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE1.

     if
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
     then
          select count(*) into numrows
          from PERSONNE1
          where
               :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "OCCUPATION" car "PERSONNE1" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPATION s'il n'existe pas d'occurrence correspondante de la 
     -- table ENTRAINEMENT.

     if
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
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
               'Impossible de mettre à jour "OCCUPATION" car "ENTRAINEMENT" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de OCCUPATION sur les 
     -- occurrences correspondantes de la table OCCUPER.

     if
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
     then
          update OCCUPER
          set
               OCCUPER.NUM_OCCUPATION = :new.NUM_OCCUPATION
          where
               OCCUPER.NUM_OCCUPATION = :old.NUM_OCCUPATION;
     end if;
     -- Ne pas modifier la clé primaire de la table OCCUPATION s'il existe des 
     -- occurrences correspondantes dans la table ETRE_ASSOCIE.

     if
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
     then
          select count(*) into numrows
          from ETRE_ASSOCIE
          where
               ETRE_ASSOCIE.NUM_OCCUPATION = :old.NUM_OCCUPATION;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "OCCUPATION" car "ETRE_ASSOCIE" existe.');
          end if;
     end if;

end;
/

drop trigger TI_OCCUPATION;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_OCCUPATION
after insert on OCCUPATION for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPATION 
     -- s'il n'existe pas d'occurrence correspondante dans la table FACTURE.

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
               -20002,
               'Impossible d''ajouter "OCCUPATION" car "FACTURE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPATION 
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
               'Impossible d''ajouter "OCCUPATION" car "CRENEAU" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPATION 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "OCCUPATION" car "PERSONNE1" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPATION 
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
               'Impossible d''ajouter "OCCUPATION" car "ENTRAINEMENT" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ABONNEMENT
-- ------------------------------------------------------------------------------- 

drop trigger TD_ABONNEMENT;

-- Trigger de suppression ----------------------------------------------
create trigger TD_ABONNEMENT
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

drop trigger TU_ABONNEMENT;

-- Trigger de modification ----------------------------------------------
create trigger TU_ABONNEMENT
after update on ABONNEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ABONNEMENT s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE1.

     if
          :old.NUM_ABONNEMENT <> :new.NUM_ABONNEMENT
     then
          select count(*) into numrows
          from PERSONNE1
          where
               :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ABONNEMENT" car "PERSONNE1" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ABONNEMENT s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE1.

     if
          :old.NUM_ABONNEMENT <> :new.NUM_ABONNEMENT
     then
          select count(*) into numrows
          from PERSONNE1
          where
               :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ABONNEMENT" car "PERSONNE1" n''existe pas.');
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

drop trigger TI_ABONNEMENT;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ABONNEMENT
after insert on ABONNEMENT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ABONNEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ABONNEMENT" car "PERSONNE1" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ABONNEMENT 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ABONNEMENT" car "PERSONNE1" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ETRE_AFFECTE
-- ------------------------------------------------------------------------------- 

drop trigger TU_ETRE_AFFECTE;

-- Trigger de modification ----------------------------------------------
create trigger TU_ETRE_AFFECTE
after update on ETRE_AFFECTE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- ENTRAINEMENT.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "ENTRAINEMENT" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- TERRAIN.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "TERRAIN" interdite.');
     end if;

end;
/

drop trigger TI_ETRE_AFFECTE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ETRE_AFFECTE
after insert on ETRE_AFFECTE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_AFFECTE 
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
               'Impossible d''ajouter "ETRE_AFFECTE" car "ENTRAINEMENT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_AFFECTE 
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
               'Impossible d''ajouter "ETRE_AFFECTE" car "TERRAIN" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ETRE_ASSOCIE
-- ------------------------------------------------------------------------------- 

drop trigger TU_ETRE_ASSOCIE;

-- Trigger de modification ----------------------------------------------
create trigger TU_ETRE_ASSOCIE
after update on ETRE_ASSOCIE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETRE_ASSOCIE s'il n'existe pas d'occurrence correspondante de la 
     -- table OCCUPATION.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE or 
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
     then
          select count(*) into numrows
          from OCCUPATION
          where
               :new.NUM_OCCUPATION = OCCUPATION.NUM_OCCUPATION;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETRE_ASSOCIE" car "OCCUPATION" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETRE_ASSOCIE s'il n'existe pas d'occurrence correspondante de la 
     -- table PERSONNE1.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE or 
          :old.NUM_OCCUPATION <> :new.NUM_OCCUPATION
     then
          select count(*) into numrows
          from PERSONNE1
          where
               :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETRE_ASSOCIE" car "PERSONNE1" n''existe pas.');
          end if;
     end if;

end;
/

drop trigger TI_ETRE_ASSOCIE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ETRE_ASSOCIE
after insert on ETRE_ASSOCIE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_ASSOCIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table OCCUPATION.

     select count(*) into numrows
     from OCCUPATION
     where
          :new.NUM_OCCUPATION = OCCUPATION.NUM_OCCUPATION;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETRE_ASSOCIE" car "OCCUPATION" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETRE_ASSOCIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETRE_ASSOCIE" car "PERSONNE1" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : S_INSCRIRE
-- ------------------------------------------------------------------------------- 

drop trigger TU_S_INSCRIRE;

-- Trigger de modification ----------------------------------------------
create trigger TU_S_INSCRIRE
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
     -- table PERSONNE1.

     if
          :old.NUM_ENTRAINEMENT <> :new.NUM_ENTRAINEMENT or 
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from PERSONNE1
          where
               :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "S_INSCRIRE" car "PERSONNE1" n''existe pas.');
          end if;
     end if;

end;
/

drop trigger TI_S_INSCRIRE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_S_INSCRIRE
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
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          :new.NUM_PERSONNE = PERSONNE1.NUM_PERSONNE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "S_INSCRIRE" car "PERSONNE1" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : AVOIR_LIEU
-- ------------------------------------------------------------------------------- 

drop trigger TU_AVOIR_LIEU;

-- Trigger de modification ----------------------------------------------
create trigger TU_AVOIR_LIEU
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

drop trigger TI_AVOIR_LIEU;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_AVOIR_LIEU
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

drop trigger TU_OCCUPER;

-- Trigger de modification ----------------------------------------------
create trigger TU_OCCUPER
after update on OCCUPER for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- CRENEAU.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN or 
          :old.DATE_OCCUPATION <> :new.DATE_OCCUPATION
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CRENEAU" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- TERRAIN.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN or 
          :old.DATE_OCCUPATION <> :new.DATE_OCCUPATION
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "TERRAIN" interdite.');
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table OCCUPER s'il n'existe pas d'occurrence correspondante de la 
     -- table OCCUPATION.

     if
          :old.HEURE_DEBUT_CRENEAU <> :new.HEURE_DEBUT_CRENEAU or 
          :old.NUM_TERRAIN <> :new.NUM_TERRAIN or 
          :old.DATE_OCCUPATION <> :new.DATE_OCCUPATION
     then
          select count(*) into numrows
          from OCCUPATION
          where
               :new.NUM_OCCUPATION = OCCUPATION.NUM_OCCUPATION;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "OCCUPER" car "OCCUPATION" n''existe pas.');
          end if;
     end if;

end;
/

drop trigger TI_OCCUPER;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_OCCUPER
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
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de OCCUPER 
     -- s'il n'existe pas d'occurrence correspondante dans la table OCCUPATION.

     select count(*) into numrows
     from OCCUPATION
     where
          :new.NUM_OCCUPATION = OCCUPATION.NUM_OCCUPATION;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "OCCUPER" car "OCCUPATION" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PERSONNE1
-- ------------------------------------------------------------------------------- 

drop trigger TD_PERSONNE1;

-- Trigger de suppression ----------------------------------------------
create trigger TD_PERSONNE1
after delete on PERSONNE1 for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de PERSONNE1 s'il existe des
     -- occurrences correspondantes de la table ABONNEMENT.

     select count(*) into numrows
     from ABONNEMENT
     where
          ABONNEMENT.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE1". Des occurrences de "ABONNEMENT" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE1 s'il existe des
     -- occurrences correspondantes de la table S_INSCRIRE.

     select count(*) into numrows
     from S_INSCRIRE
     where
          S_INSCRIRE.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE1". Des occurrences de "S_INSCRIRE" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE1 s'il existe des
     -- occurrences correspondantes de la table ENTRAINEMENT.

     select count(*) into numrows
     from ENTRAINEMENT
     where
          ENTRAINEMENT.NUM_EMPLOYE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE1". Des occurrences de "ENTRAINEMENT" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE1 s'il existe des
     -- occurrences correspondantes de la table ETRE_ASSOCIE.

     select count(*) into numrows
     from ETRE_ASSOCIE
     where
          ETRE_ASSOCIE.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE1". Des occurrences de "ETRE_ASSOCIE" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PERSONNE1 s'il existe des
     -- occurrences correspondantes de la table OCCUPATION.

     select count(*) into numrows
     from OCCUPATION
     where
          OCCUPATION.NUM_PERSONNE = :old.NUM_PERSONNE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PERSONNE1". Des occurrences de "OCCUPATION" existent.');
     end if;

end;
/

drop trigger TU_PERSONNE1;

-- Trigger de modification ----------------------------------------------
create trigger TU_PERSONNE1
after update on PERSONNE1 for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PERSONNE1 s'il n'existe pas d'occurrence correspondante de la 
     -- table CODIFICATION.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
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
               'Impossible de mettre à jour "PERSONNE1" car "CODIFICATION" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PERSONNE1 s'il n'existe pas d'occurrence correspondante de la 
     -- table CODIFICATION.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
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
               'Impossible de mettre à jour "PERSONNE1" car "CODIFICATION" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de PERSONNE1 sur les 
     -- occurrences correspondantes de la table ABONNEMENT.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          update ABONNEMENT
          set
               ABONNEMENT.NUM_PERSONNE = :new.NUM_PERSONNE
          where
               ABONNEMENT.NUM_PERSONNE = :old.NUM_PERSONNE;
     end if;
     -- Ne pas modifier la clé primaire de la table PERSONNE1 s'il existe des 
     -- occurrences correspondantes dans la table S_INSCRIRE.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from S_INSCRIRE
          where
               S_INSCRIRE.NUM_PERSONNE = :old.NUM_PERSONNE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "PERSONNE1" car "S_INSCRIRE" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table PERSONNE1 s'il existe des 
     -- occurrences correspondantes dans la table ENTRAINEMENT.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from ENTRAINEMENT
          where
               ENTRAINEMENT.NUM_EMPLOYE = :old.NUM_PERSONNE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "PERSONNE1" car "ENTRAINEMENT" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table PERSONNE1 s'il existe des 
     -- occurrences correspondantes dans la table ETRE_ASSOCIE.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from ETRE_ASSOCIE
          where
               ETRE_ASSOCIE.NUM_PERSONNE = :old.NUM_PERSONNE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "PERSONNE1" car "ETRE_ASSOCIE" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table PERSONNE1 s'il existe des 
     -- occurrences correspondantes dans la table OCCUPATION.

     if
          :old.NUM_PERSONNE <> :new.NUM_PERSONNE
     then
          select count(*) into numrows
          from OCCUPATION
          where
               OCCUPATION.NUM_PERSONNE = :old.NUM_PERSONNE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "PERSONNE1" car "OCCUPATION" existe.');
          end if;
     end if;

end;
/

drop trigger TI_PERSONNE1;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_PERSONNE1
after insert on PERSONNE1 for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PERSONNE1 
     -- s'il n'existe pas d'occurrence correspondante dans la table CODIFICATION.

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
               -20002,
               'Impossible d''ajouter "PERSONNE1" car "CODIFICATION" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PERSONNE1 
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
               'Impossible d''ajouter "PERSONNE1" car "CODIFICATION" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CODIFICATION
-- ------------------------------------------------------------------------------- 

drop trigger TD_CODIFICATION;

-- Trigger de suppression ----------------------------------------------
create trigger TD_CODIFICATION
after delete on CODIFICATION for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table TERRAIN.

     select count(*) into numrows
     from TERRAIN
     where
          TERRAIN.CODE_SURFACE = :old.CODE and
          TERRAIN.NATURE = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "TERRAIN" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          PERSONNE1.CODE_STATUT_EMPLOYE = :old.CODE and
          PERSONNE1.NATURE_STATUT_EMPLOYE = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "PERSONNE1" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table PERSONNE1.

     select count(*) into numrows
     from PERSONNE1
     where
          PERSONNE1.CODE_NIVEAU = :old.CODE and
          PERSONNE1.NATURE_NIVEAU = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "PERSONNE1" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de CODIFICATION s'il existe des
     -- occurrences correspondantes de la table ENTRAINEMENT.

     select count(*) into numrows
     from ENTRAINEMENT
     where
          ENTRAINEMENT.CODE_NIVEAU = :old.CODE and
          ENTRAINEMENT.NATURE = :old.NATURE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CODIFICATION". Des occurrences de "ENTRAINEMENT" existent.');
     end if;

end;
/

drop trigger TU_CODIFICATION;

-- Trigger de modification ----------------------------------------------
create trigger TU_CODIFICATION
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
               TERRAIN.NATURE = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "TERRAIN" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table CODIFICATION s'il existe des 
     -- occurrences correspondantes dans la table PERSONNE1.

     if
          :old.CODE <> :new.CODE or 
          :old.NATURE <> :new.NATURE
     then
          select count(*) into numrows
          from PERSONNE1
          where
               PERSONNE1.CODE_STATUT_EMPLOYE = :old.CODE and
               PERSONNE1.NATURE_STATUT_EMPLOYE = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "PERSONNE1" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table CODIFICATION s'il existe des 
     -- occurrences correspondantes dans la table PERSONNE1.

     if
          :old.CODE <> :new.CODE or 
          :old.NATURE <> :new.NATURE
     then
          select count(*) into numrows
          from PERSONNE1
          where
               PERSONNE1.CODE_NIVEAU = :old.CODE and
               PERSONNE1.NATURE_NIVEAU = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "PERSONNE1" existe.');
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
               ENTRAINEMENT.NATURE = :old.NATURE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "CODIFICATION" car "ENTRAINEMENT" existe.');
          end if;
     end if;

end;
/



