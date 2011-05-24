create or replace
PACKAGE BODY pq_ui_commun
AS
	---Procédure permettant d'afficher les détails d'une erreur d'oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2)
	IS
	begin
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
		pq_ui_commun.aff_footer;
	END;


	-- Affiche le détail d'une erreur personnalisée
	PROCEDURE dis_error_custom(
	  vtitre in varchar2
	, vexplicationerreur in varchar2
	, vconseilerreur in varchar2
	, vlienretour  in varchar2
	, vlibellelien in varchar2)
	IS
	begin
			htp.br;
			htp.print(vtitre);
			htp.br;
			htp.br;
			htp.print('Explication : ' || vexplicationerreur);
			htp.br;
			htp.br;
			htp.print('Conseil : ' || vconseilerreur);
			htp.br;
			htp.br;
			htp.anchor(vlienretour, vlibellelien);
		pq_ui_commun.aff_footer;
	END;

PROCEDURE aff_accueil
IS
	perm BOOLEAN;
	PERMISSION_DENIED EXCEPTION;
BEGIN
	pq_ui_commun.aff_header(niveau => 1, permission => perm);
	IF perm=false THEN
		RAISE PERMISSION_DENIED;
	END IF;
	htp.print('Accueil');
	pq_ui_commun.aff_footer;
EXCEPTION
	WHEN PERMISSION_DENIED THEN
		 pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
END;

PROCEDURE aff_header (niveau IN NUMBER, permission OUT BOOLEAN)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255) := pq_ui_param_commun.get_rep_js;
		rep_img VARCHAR2(255) := pq_ui_param_commun.get_rep_img;
		PERMISSION_DENIED EXCEPTION;
		niveauPersonne NUMBER(1) :=3;
		target_cookie OWA_COOKIE.cookie;
	BEGIN
		target_cookie := OWA_COOKIE.get('numpersonne');
		SELECT
			NIVEAU_DROIT INTO niveauPersonne
		FROM
			PERSONNE
		WHERE
			NUM_PERSONNE=TO_NUMBER(target_cookie.vals(1));
                IF(niveauPersonne<niveau)
                        THEN RAISE PERMISSION_DENIED;
                END IF;
				permission:=true;
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />');
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>');
			htp.headClose;
			htp.bodyOpen;
			--logo
			htp.print('<img title="Système de réservation" alt="Logo" src="' || rep_img || 'logo.jpg">');
			pq_ui_commun.aff_menu(niveauPersonne);
			htp.div(cattributes => 'id="corps"');

        EXCEPTION
              WHEN PERMISSION_DENIED THEN
                htp.print('Vous n''avez pas la permission d''accéder à cette page');
                permission := false;
              WHEN others THEN
                  pq_ui_login.LOGIN;
                  permission := false;
	END;


	PROCEDURE aff_menu(niveau IN NUMBER)
	IS
	BEGIN
		CASE niveau
			WHEN 1 THEN
				pq_ui_commun.aff_menu_niveau1;
			WHEN 2 THEN
				pq_ui_commun.aff_menu_niveau2;
			WHEN 3 THEN
				pq_ui_commun.aff_menu_niveau3;
		END CASE;
	END;


	PROCEDURE aff_menu_niveau1
	IS
	BEGIN
		htp.div(cattributes => 'id="menuvisiteur"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('#', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Réservation');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes réservation');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Nouvelle réservation');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Informations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau2
	IS
	BEGIN
		htp.div(cattributes => 'id="menuadherent"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('#', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Réservation');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes réservation');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Nouvelle réservation');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Entrainement');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes entrainements');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Souscrire');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Informations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau3
	IS
	BEGIN
		htp.div(cattributes => 'id="menuadmin"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('#', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Réservation');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes réservation');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Nouvelle réservation');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Entrainement');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes entrainements');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Souscrire');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Informations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Administration');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Gestion des terrains');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Gestion des créneaux');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_footer
	IS
	BEGIN
		htp.print('</div>');
		htp.div(cattributes => 'id="footer"');
			htp.print('Système de réservation d''un centre de tennis');
		htp.print('</div>');
		htp.bodyClose;
		htp.htmlClose;
	END;
	
	PROCEDURE deconnect
	IS
	BEGIN
		owa_util.mime_header('text/html', false);
                owa_cookie.remove('numpersonne',NULL);
                owa_util.http_header_close;
		pq_ui_login.login;
	END;

END pq_ui_commun;
