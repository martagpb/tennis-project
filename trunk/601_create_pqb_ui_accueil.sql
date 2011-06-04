-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_accueil
IS

	--affichage de la page d'accueil
	PROCEDURE dis_accueil
	IS
		rep_img VARCHAR2(255) := pq_ui_param_commun.get_rep_img;
	BEGIN
		pq_ui_commun.aff_header;
		htp.br;
		htp.br;
		htp.Print('BIENVENUE SUR LE SITE DU CENTRE DE TENNIS DE SAINT GILLE CROIX DE VIE LES SAPINS');
		htp.br;
		htp.br;
		--htp.print('<img title="Système de réservation" alt="Accueil" src="' || rep_img || 'accueil.jpg" >');
		htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.br;		
		htp.br;
		pq_ui_commun.aff_footer;
	END;
	
	
		
END pq_ui_accueil;
/