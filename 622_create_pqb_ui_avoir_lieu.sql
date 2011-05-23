-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_avoir_lieu
IS
	
	-- Exécute la procédure d'ajout d'une séance d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		CURSOR listEntrainement IS SELECT NUM_ENTRAINEUR,CODE_NIVEAU,NATURE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,
										  DATE_FIN_ENTRAINEMENT,EST_RECURENT_ENTRAINEMENT FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				pq_db_avoir_lieu.add_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement);
				pq_db_etre_affecte.add_etre_affecte(vnumEntrainement,vnumTerrain);
				for currentEntrainement in listEntrainement loop
				pq_ui_entrainement.dis_entrainement(vnumEntrainement,currentEntrainement.NUM_ENTRAINEUR,currentEntrainement.CODE_NIVEAU,
												    currentEntrainement.NATURE_NIVEAU,currentEntrainement.NB_PLACE_ENTRAINEMENT,
													currentEntrainement.DATE_DEBUT_ENTRAINEMENT,currentEntrainement.DATE_FIN_ENTRAINEMENT,
													currentEntrainement.EST_RECURENT_ENTRAINEMENT);
				end loop;
				htp.br;		
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de la séance en cours...');
	END exec_add_avoir_lieu;
	
	-- Exécute la procédure de mise à jour d'une séance d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_upd_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				
				htp.br;		
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour de la séance en cours...');
	END exec_upd_avoir_lieu;
	
	-- Exécute la procédure de suppression d'une séance d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		CURSOR listEntrainement IS SELECT NUM_ENTRAINEUR,CODE_NIVEAU,NATURE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,
										  DATE_FIN_ENTRAINEMENT,EST_RECURENT_ENTRAINEMENT FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				pq_db_avoir_lieu.del_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain);
				pq_db_etre_affecte.del_etre_affecte_terrain(vnumEntrainement,vnumTerrain);
				htp.print('La séance a été supprimé avec succès.');
				htp.br;
				htp.br;			
				for currentEntrainement in listEntrainement loop
				pq_ui_entrainement.dis_entrainement(vnumEntrainement,currentEntrainement.NUM_ENTRAINEUR,currentEntrainement.CODE_NIVEAU,
												    currentEntrainement.NATURE_NIVEAU,currentEntrainement.NB_PLACE_ENTRAINEMENT,
													currentEntrainement.DATE_DEBUT_ENTRAINEMENT,currentEntrainement.DATE_FIN_ENTRAINEMENT,
													currentEntrainement.EST_RECURENT_ENTRAINEMENT);
				end loop;
				htp.br;		
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression de la séance en cours...');
	END exec_del_avoir_lieu;
	  
	-- Affiche le formulaire permettant la saisie d'une nouvelle séance d'un entrainement
	PROCEDURE form_add_avoir_lieu(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
	rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		CURSOR creneaulist IS SELECT HEURE_DEBUT_CRENEAU FROM CRENEAU;
		CURSOR terrainlist IS SELECT T.NUM_TERRAIN,C.LIBELLE FROM TERRAIN T INNER JOIN CODIFICATION C ON T.CODE_SURFACE = C.CODE WHERE C.NATURE = 'Surface';
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_avoir_lieu.exec_add_avoir_lieu', 'GET');				
				htp.br;
				htp.print('Création d''une nouvelle séance' || ' (' || htf.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement||'&'||'vnumEntraineur='||vnumEntraineur||'&'||
						'vcodeNiveau='||vcodeNiveau||'&'||'vnatureNiveau='||vnatureNiveau||'&'||'vnbPlaces='||vnbPlaces
						||'&'||'vdateDebut='||vdateDebut||'&'||'vdateFin='||vdateFin||'&'||'vestRecurent='||vestRecurent,'Actualiser')|| ')' );
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableRowOpen;
				htp.tableData('Jour :', cattributes => 'class="enteteFormulaire"');									
					htp.print('<td>');
					htp.print('<select name="vnumJour" id="vnumJour">');		
						htp.print('<option value="1">Lundi</option>');
						htp.print('<option value="2">Mardi</option>');
						htp.print('<option value="3">Mercredi</option>');
						htp.print('<option value="4">Jeudi</option>');
						htp.print('<option value="5">Vendredi</option>');
						htp.print('<option value="6">Samedi</option>');
						htp.print('<option value="7">Dimanche</option>');
					htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;	
				htp.tableRowOpen;
				htp.tableData('Heure de début :', cattributes => 'class="enteteFormulaire"');								
					htp.print('<td>');
					htp.print('<select name="vheureDebutCreneau" id="vheureDebutCreneau">');		
					for currentCreneau in creneaulist loop
							htp.print('<option value="'||currentCreneau.HEURE_DEBUT_CRENEAU||'">'||currentCreneau.HEURE_DEBUT_CRENEAU||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
				htp.tableData('Terrain :', cattributes => 'class="enteteFormulaire"');								
					htp.print('<td>');
					htp.print('<select name="vnumTerrain" id="vnumTerrain">');		
					for currentTerrain in terrainlist loop
							htp.print('<option value="'||currentTerrain.NUM_TERRAIN||'">'||currentTerrain.NUM_TERRAIN || ' surface : ' || currentTerrain.LIBELLE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');	
					htp.formhidden ('vnumEntrainement',vnumEntrainement);
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement.dis_entrainement?vnumEntrainement='||vnumEntrainement||'&'||'vnumEntraineur='||vnumEntraineur||'&'||
						'vcodeNiveau='||vcodeNiveau||'&'||'vnatureNiveau='||vnatureNiveau||'&'||'vnbPlaces='||vnbPlaces
						||'&'||'vdateDebut='||vdateDebut||'&'||'vdateFin='||vdateFin||'&'||'vestRecurent='||vestRecurent, 'Retourner au descriptif de l''entrainement');
			htp.bodyClose;
		htp.htmlClose;
	END form_add_avoir_lieu;
	
	-- Affiche le formulaire de saisie permettant la modification d’un entrainement existant	
	PROCEDURE form_upd_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				
				htp.br;		
			htp.bodyClose;
		htp.htmlClose;
	END form_upd_avoir_lieu;
		
END pq_ui_avoir_lieu;
/