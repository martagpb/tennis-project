-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 21/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_codification
AS
	--Permet d’ajouter une codification		
	PROCEDURE add_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
	BEGIN
		INSERT INTO CODIFICATION(CODE, NATURE, LIBELLE)
		VALUES(vcode,vnature,vlibelle);  
		COMMIT;
	END add_codification;     
        
	--Permet de modifier une codification existante
	PROCEDURE upd_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
	BEGIN
		UPDATE CODIFICATION
		SET
			LIBELLE = vnature
		WHERE
			CODE   = vcode
		AND NATURE = vnature;
		COMMIT;
	END upd_codification;
	
	--Permet de supprimer une codification existante
	PROCEDURE del_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2)
	IS
	BEGIN
		DELETE FROM CODIFICATION
		WHERE 
			CODE   = vcode
		AND NATURE = vnature;
		COMMIT;
	END del_codification;
	
	-- Fonction permettant de retourner le libellé d'une condification en indiquant le code et la nature de la codification
	FUNCTION get_libelle(
	  vcode IN CHAR
	, vnature IN VARCHAR2)
	RETURN VARCHAR2
	IS
		libelle VARCHAR2(255) := 'indéterminé';
	BEGIN
		SELECT 
			COD.LIBELLE INTO libelle
		FROM 
			CODIFICATION COD
		WHERE 
			UPPER(COD.CODE)   = UPPER(vcode) 
		AND UPPER(COD.NATURE) = UPPER(vnature);
		RETURN libelle;
	END;
	
END pq_db_codification;
/