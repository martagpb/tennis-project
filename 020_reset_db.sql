-- -----------------------------------------------------------------------------
--            Ré-initialisation de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 24/5/2011
-- -----------------------------------------------------------------------------


-- A exécuter en tant qu'administrateur !


-- -----------------------------------------------------------------------------
--       SUPPRESSION TABLESPACES (DONNEES, INDEX, TEMPORAIRE)
-- -----------------------------------------------------------------------------

DROP TABLESPACE TENNIS_DATA
	INCLUDING CONTENTS AND DATAFILES
  ;

DROP TABLESPACE TENNIS_IND
	INCLUDING CONTENTS AND DATAFILES
  ;
  
DROP TABLESPACE TENNIS_TEMP
	INCLUDING CONTENTS AND DATAFILES
  ;
  
-- -----------------------------------------------------------------------------
--       SUPPRESSION UTILISATEUR 
-- -----------------------------------------------------------------------------

DROP USER tennis cascade;

-- -----------------------------------------------------------------------------
--       SUPPRESSION DAD
-- -----------------------------------------------------------------------------

BEGIN
	DBMS_EPG.drop_dad(dad_name => 'tennis_dad');
END;
/