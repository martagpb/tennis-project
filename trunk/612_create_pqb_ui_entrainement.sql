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

CREATE OR REPLACE PACKAGE BODY pq_ui_entrainement
IS
	
	--Permet d'afficher tous les entrainement existant 
	PROCEDURE manage_entrainement
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255)  := pq_ui_param_commun.get_rep_js;
		-- On stocke dans un curseur la liste de tous les entrainements existants
		CURSOR listEntrainement IS
		SELECT 
			NUM_ENTRAINEMENT
		   ,NUM_ENTRAINEUR
		   ,CODE_NIVEAU
		   ,NATURE_NIVEAU
		   ,NB_PLACE_ENTRAINEMENT
		   ,DATE_DEBUT_ENTRAINEMENT
		   ,DATE_FIN_ENTRAINEMENT
		   ,EST_RECURENT_ENTRAINEMENT
		FROM 
			ENTRAINEMENT ENTR
		ORDER BY 
			1;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>'); 	
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				htp.print('Gestion des entrainements' || ' (' || htf.anchor('pq_ui_entrainement.manage_entrainement','Actualiser')|| ')' );
				htp.br;	
				htp.br;	
				htp.print(htf.anchor('pq_ui_entrainement.form_add_entrainement','Ajouter un entrainement'));
				htp.br;	
				htp.br;	
				htp.tableOpen;
					htp.tableheader('Numéro d''entrainement');
					htp.tableheader('Informations');
					htp.tableheader('Mise à jour');
					htp.tableheader('Suppression');
					for currentEntrainement in listEntrainement loop
						htp.tableRowOpen;
						htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);				
						htp.tabledata(htf.anchor('pq_ui_entrainement.dis_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT||'&vnumEmploye='||currentEntrainement.NUM_ENTRAINEUR||
						'&vcodeNiveau='||currentEntrainement.CODE_NIVEAU||'&vnatureNiveau='||currentEntrainement.NATURE_NIVEAU||'&vnbPlaces='||currentEntrainement.NB_PLACE_ENTRAINEMENT||
						'&vdateDebut='||currentEntrainement.DATE_DEBUT_ENTRAINEMENT||'&vdateFin='||currentEntrainement.DATE_FIN_ENTRAINEMENT||'&vestRecurent='||currentEntrainement.EST_RECURENT_ENTRAINEMENT,'Informations'));
						htp.tabledata(htf.anchor('pq_ui_entrainement.form_upd_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Mise à jour'));
						htp.tabledata(htf.anchor('pq_ui_entrainement.exec_del_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
						htp.tableRowClose;
					end loop;	
				htp.tableClose;
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END manage_entrainement;
	
	-- Exécute la procédure d’affichage des entrainements et gère les erreurs éventuelles
	PROCEDURE exec_dis_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				pq_ui_entrainement.dis_entrainement(vnumEntrainement,vnumEmploye,vcodeNiveau,vnatureNiveau,vnbPlaces,vdateDebut,vdateFin,vestRecurent));
				htp.br;		
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage de l''entrainement en cours...');
	END exec_dis_entrainement;
	
	--Permet d’afficher un entrainement existant
	PROCEDURE dis_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;	
				htp.print('Affichage des informations d''un entrainement' || ' (' || htf.anchor('pq_ui_entrainement.dis_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT||'&vnumEmploye='||currentEntrainement.NUM_ENTRAINEUR||
						'&vcodeNiveau='||currentEntrainement.CODE_NIVEAU||'&vnatureNiveau='||currentEntrainement.NATURE_NIVEAU||'&vnbPlaces='||currentEntrainement.NB_PLACE_ENTRAINEMENT||
						'&vdateDebut='||currentEntrainement.DATE_DEBUT_ENTRAINEMENT||'&vdateFin='||currentEntrainement.DATE_FIN_ENTRAINEMENT||'&vestRecurent='||currentEntrainement.EST_RECURENT_ENTRAINEMENT,'Actualiser')|| ')' )
				htp.br;
				htp.br;					
				htp.print('L''entrainement numéro '|| vnumEntrainement || ' est animé par l''entraineur numéro '|| vnumEmploye || '.');
				htp.br;					
				htp.print('L''entrainement s''adresses aux joueurs possèdant le niveau : '|| vcodeNiveau || '.');
				htp.br;
				htp.print('Le nombre de places disponibles est de : '|| vnbPlaces || '.');
				htp.br;
				htp.print('Il a lieu entre le  : '|| vdateDebut || 'et le' || vdateFin ||'.');
				htp.br;
				htp.br;		
				htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner à la gestion des entrainements');	
			htp.bodyClose;
		htp.htmlClose;
	END dis_entrainement;
	
	-- Exécute la procédure d'ajout d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
			htp.bodyClose;
		htp.htmlClose;
	END exec_add_entrainement;
	
	-- Exécute la procédure de mise à jour d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
			htp.bodyClose;
		htp.htmlClose;
	END exec_upd_entrainement;

	-- Exécute la procédure de suppression d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
			htp.bodyClose;
		htp.htmlClose;
	END exec_del_entrainement;
	

	
	-- Affiche le formulaire permettant la saisie d’un nouvel entrainement
	PROCEDURE form_add_entrainement
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
			htp.bodyClose;
		htp.htmlClose;
	END form_add_entrainement;
	
	-- Affiche le formulaire de saisie permettant la modification d’un entrainement existant	
	PROCEDURE form_upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEmploye IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255)  := pq_ui_param_commun.get_rep_js;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>'); 	
			htp.headClose;
			htp.bodyOpen;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_upd_creneau', 'GET', cattributes => 'onSubmit="return validerCreneau(this,document)"');
					htp.tableOpen;
					htp.br;
					htp.print('Mise à jour d''un entrainement' || ' (' || htf.anchor('pq_ui_entrainement.form_upd_creneau?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT||'&vnumEmploye='||currentEntrainement.NUM_ENTRAINEUR||
						'&vcodeNiveau='||currentEntrainement.CODE_NIVEAU||'&vnatureNiveau='||currentEntrainement.NATURE_NIVEAU||'&vnbPlaces='||currentEntrainement.NB_PLACE_ENTRAINEMENT||
						'&vdateDebut='||currentEntrainement.DATE_DEBUT_ENTRAINEMENT||'&vdateFin='||currentEntrainement.DATE_FIN_ENTRAINEMENT||'&vestRecurent='||currentEntrainement.EST_RECURENT_ENTRAINEMENT,,'Actualiser')|| ')' );
					htp.br;
					htp.br;
					htp.tableRowOpen;
						htp.tableData('Numéro de l''entrainement :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(vnumEntrainement);
					htp.tableRowClose;	
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner à la gestion des entrainements');
			htp.bodyClose;
		htp.htmlClose;
	END form_upd_entrainement;
		
END pq_ui_entrainement;
/