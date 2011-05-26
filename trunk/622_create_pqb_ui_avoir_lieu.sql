-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_avoir_lieu
IS
	
	-- Ex�cute la proc�dure d'ajout d'une s�ance d'un entrainement et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR 
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		Nb NUMBER(3);
		vdateDebut Date;
		vdateFin Date;
		vnumJourDebut NUMBER(1);
		vincrementDate DATE;
		vnumSeance NUMBER(3);
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		BEGIN
			SELECT COUNT(*) INTO Nb FROM ETRE_AFFECTE WHERE NUM_ENTRAINEMENT = vnumEntrainement AND NUM_TERRAIN = vnumTerrain;
			select date_debut_entrainement into vdateDebut from entrainement where num_entrainement=vnumEntrainement;
			select date_fin_entrainement into vdateFin from entrainement where num_entrainement=vnumEntrainement;
			select to_char(vdateDebut,'D') into vnumJourDebut from entrainement where num_entrainement=vnumEntrainement;
			/*pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
			RAISE PERMISSION_DENIED;*/
			pq_db_avoir_lieu.add_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement);
			if(Nb=0)
				then
				pq_db_etre_affecte.add_etre_affecte(vnumEntrainement,vnumTerrain);
			end if;
			
			--Cr�ation des occupations
			vnumSeance:=1;
			--on retrouve le premier jour de la s�ance
			if(vnumjour>=vnumJourDebut)
			then
				vincrementDate:=vdateDebut+(vnumjour-vnumJourDebut);
			else
				vincrementDate:=vdateDebut+(7-vnumJourDebut+vnumJour);
			end if;
			WHILE trunc(vincrementDate) <= trunc(vdateFin)
			LOOP
				pq_db_occuper.add_seance(vheureDebutCreneau,vnumTerrain,vincrementDate,vnumEntrainement,vnumSeance);
				vincrementDate:=vincrementDate+7;
				vnumSeance:=vnumSeance+1;
			END LOOP;

			pq_ui_entrainement.exec_dis_entrainement(vnumEntrainement);
			
			htp.br;
			htp.br;
			htp.print('La s�ance a �t� ajout�e avec succ�s.');
			htp.br;		
		htp.bodyClose;
	htp.htmlClose;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de la s�ance en cours...');
	END exec_add_avoir_lieu;
	
	
	-- Ex�cute la proc�dure de suppression d'une s�ance d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		Nb NUMBER(3);
		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		BEGIN
			SELECT COUNT(*) INTO Nb FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT = vnumEntrainement AND NUM_TERRAIN = vnumTerrain;
			/*pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
			RAISE PERMISSION_DENIED;*/
			htp.br;				
			pq_db_avoir_lieu.del_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain);
			if(Nb=1)
				then
				pq_db_etre_affecte.del_etre_affecte_terrain(vnumEntrainement,vnumTerrain);
			end if;
			--supprime les s�ances dont la date est > sysdate
			pq_db_occuper.del_seance(vheureDebutCreneau,vnumTerrain,sysdate,vnumEntrainement);		
			htp.print('La s�ance a �t� supprim�e avec succ�s.');
			htp.br;
			htp.br;			
			pq_ui_entrainement.exec_dis_entrainement(vnumEntrainement);
			htp.br;		
		htp.bodyClose;
	htp.htmlClose;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression de la s�ance en cours...');
	END exec_del_avoir_lieu;
	  
	-- Affiche le formulaire permettant la saisie d'une nouvelle s�ance d'un entrainement
	PROCEDURE form_add_avoir_lieu(
	  vnumEntrainement IN NUMBER)
	IS
	rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		CURSOR creneaulist IS SELECT HEURE_DEBUT_CRENEAU FROM CRENEAU;
		CURSOR terrainlist IS SELECT T.NUM_TERRAIN,C.LIBELLE FROM TERRAIN T INNER JOIN CODIFICATION C ON T.CODE_SURFACE = C.CODE WHERE C.NATURE = 'Surface';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		BEGIN
			/*pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
			RAISE PERMISSION_DENIED;*/
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_avoir_lieu.exec_add_avoir_lieu', 'GET');				
				htp.br;
				htp.print('Cr�ation d''une nouvelle s�ance' || ' (' || htf.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement,'Actualiser')|| ')' );
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
				htp.tableData('Heure de d�but :', cattributes => 'class="enteteFormulaire"');								
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
			htp.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||vnumEntrainement, 'Retourner au descriptif de l''entrainement');
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END form_add_avoir_lieu;
		
END pq_ui_avoir_lieu;
/