-- -----------------------------------------------------------------------------
--  Cr�ation du corps du package des  m�thodes communes
--  qui permettent l'affichage de donn�es pour l'utilisateur.
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 17/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_commun
AS
	---Proc�dure permettant d'afficher les d�tails d'une erreur d'oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	begin
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;
				htp.print('D�tails sur l''erreur d''oracle');
				htp.br;
				htp.br;
				htp.tableopen;		
					htp.tablerowopen;
						htp.tabledata('N� :', cattributes => 'class="enteteFormulaire"');
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
				htp.anchor('pq_ui_login.login', 'Retourner � l''accueil');
			htp.bodyClose;
		htp.htmlClose;
	END;	
	
END pq_ui_commun;
/