-- -----------------------------------------------------------------------------
--     Cr�ation du package d'interface d'affichage de l'accueil
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernicre modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_accueil
IS
	--affichage de la page d'accueil
	PROCEDURE dis_accueil
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
		htp.br;
		htp.br;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Bienvenue sur l''application de r�servation de votre centre de tennis');
		htp.print('</div>');		
		htp.br;
		htp.br;
		htp.print('Le r�le principal de cette application est de permettre la gestion des r�servations.');
		htp.br;
		htp.print('Elle est principalement destin�e � �tre utilis�e par les agents d''accueil et les entraineurs du club.');	
		htp.br;
		htp.print('Par ailleurs, l''application a pour objectif d''am�liorer et de simplifier les t�ches classiques de gestion dans le but de faire gagner du temps aux utilisateurs.');
		htp.br;
		htp.print('Enfin, cette application va permettre de g�rer et de recenser les joueurs, les r�servations, les entraineurs, les abonnements, les factures et les terrains du club.');
		htp.br;		
		htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
	END;		
		
END pq_ui_accueil;
/