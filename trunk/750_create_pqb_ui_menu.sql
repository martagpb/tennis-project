  -- -----------------------------------------------------------------------------
--           Création du corps du package de création des menus 
--                      Oracle Version 10g
--                        (18/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------


CREATE OR REPLACE PACKAGE BODY UI_MENU
AS 
	PROCEDURE GENERATE_MENU IS
		rep_css VARCHAR2(255) := pq_ui_commun.get_rep_css;
		statutEmploye VARCHAR2(255);
		statutJoueur VARCHAR2(255);
	BEGIN
		PA_PERSONNE.getStatutEmploye(numPersonne =>  owa_sec.get_user_id,
										statut => statutEmploye);
		PA_PERSONNE.getStatutJoueur(numPersonne =>  owa_sec.get_user_id,
										statut => statutJoueur);
		IF(statutJoueur IS NOT NULL) THEN
			CASE statutJoueur
				WHEN 'V' THEN
				--affiche le menu VISITEUR	
				htp.br;
				WHEN 'A' THEN
				--affiche le menu ADHERENT
				htp.br;
			END CASE;
		ELSE IF(statutEmploye IS NOT NULL) THEN
			CASE statutEmploye
				WHEN 'Entraineur' THEN
				--affiche le menu ENTRAINEUR	
				htp.br;
				WHEN 'Administrateur' THEN
				--affiche le menu ADMINISTRATEUR
				htp.br;
				WHEN 'Agent d''accueil' THEN
				--affiche le menu AGENT D'ACCUEIL
				htp.br;
			END CASE;
		END IF;
	END;
	
END UI_MENU;
/