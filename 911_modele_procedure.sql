	--	Modèle de procédure pour afficher une nouvelle page
	--	> on affiche le header
	--	> on ouvre un bloc anonyme
	--		> on teste l'authentification
	--		> on effectue les traitements/affichages de la page
	--		> on capte les erreurs de droits et de traitement
	--	> on ferme le bloc anonyme
	--	> on affiche le footer
	
	PROCEDURE maProcedure
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			--	do something...
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Nom de la page');
		END;
		
		pq_ui_commun.aff_footer;
	END maProcedure;