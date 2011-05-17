-- -----------------------------------------------------------------------------
--           Création du corps du package d'affichage des données
--           qui sont communes à plusieurs tables
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 17/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_commun
AS
	---Procédure permettant d'afficher les détails d'une erreur d'oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2)
	IS
		rep_css VARCHAR2(255) := pq_ui_commun.get_rep_css;
	begin
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;
				htp.print('Détails sur l''erreur d''oracle');
				htp.br;
				htp.br;
				htp.tableopen;		
					htp.tablerowopen;
						htp.tabledata('N° :', cattributes => 'class="enteteFormulaire"');
						htp.tabledata(vnumero);
					htp.tablerowclose;
					htp.tablerowopen;
						htp.tabledata('Description :', cattributes => 'class="enteteFormulaire"');
						htp.tabledata(vliberreur);
					htp.tablerowclose;
					htp.tablerowopen;
						htp.tabledata('Action en cours :', cattributes => 'class="enteteFormulaire"');	
						htp.tabledata(vactionencours);
					htp.tablerowclose;
				htp.tableclose;
				htp.br;
				htp.br;
				htp.anchor('pq_ui_login.login', 'Retourner à l''accueil');
			htp.bodyClose;
		htp.htmlClose;
	END;
	
	-- Fonction permettant de retourner le chemin complet du répertoire CSS
	FUNCTION get_rep_css
	RETURN VARCHAR2
	IS
		rep_css VARCHAR2(255) := '/public/css/';
	BEGIN
		RETURN rep_css;
	END;
	
	-- Fonction permettant de retourner le chemin complet du répertoire JavaScript (JS)
	FUNCTION get_rep_js
	RETURN VARCHAR2
	IS
		rep_js VARCHAR2(255) := '/public/js/';
	BEGIN
		RETURN rep_js;
	END;
	
END pq_ui_commun;
/