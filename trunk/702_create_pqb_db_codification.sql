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
IS
	--Permet d’ajouter une codification		
	PROCEDURE add_codification(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE
	, vlibelle IN CODIFICATION.LIBELLE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO CODIFICATION(CODE, NATURE, LIBELLE)
		VALUES(vcode,vnature,vlibelle);  
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END add_codification;     
        
	--Permet de modifier une codification existante
	PROCEDURE upd_codification(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE
	, vlibelle IN CODIFICATION.LIBELLE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		UPDATE CODIFICATION
		SET
			LIBELLE = vlibelle
		WHERE
			CODE   = vcode
		AND NATURE = vnature;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END upd_codification;
	
	--Permet de supprimer une codification existante
	PROCEDURE del_codification(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		DELETE FROM CODIFICATION
		WHERE 
			CODE   = vcode
		AND NATURE = vnature;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END del_codification;
	
	-- Fonction permettant de retourner le libellé d'une condification en indiquant le code et la nature de la codification
	FUNCTION get_libelle(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE)
	RETURN VARCHAR2
	IS
		libelle VARCHAR2(255) := 'indéterminé';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT 
			COD.LIBELLE INTO libelle
		FROM 
			CODIFICATION COD
		WHERE 
			UPPER(COD.CODE)   = UPPER(vcode) 
		AND UPPER(COD.NATURE) = UPPER(vnature);
		RETURN libelle;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END;
	
END pq_db_codification;
/