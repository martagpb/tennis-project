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
	-- Affiche le formulaire de choix du terrain
	PROCEDURE aff_add_avoir_lieu(
	  vnumEntrainement IN NUMBER
	 ,vnumJour IN NUMBER
	 ,vheureDebutCreneau IN CHAR
	 ,vretourEntraineur IN NUMBER)
	IS
		CURSOR listTerrainDispo IS
		SELECT 
				DISTINCT T.NUM_TERRAIN
				,C.LIBELLE
		FROM
			TERRAIN T INNER JOIN CODIFICATION C
			ON T.CODE_SURFACE = C.CODE
		WHERE
				NOT EXISTS(SELECT 
									AL.NUM_TERRAIN
						   FROM
									AVOIR_LIEU AL
						   WHERE
									T.NUM_TERRAIN = AL.NUM_TERRAIN
									AND AL.NUM_JOUR = vnumJour
									AND AL.HEURE_DEBUT_CRENEAU = vheureDebutCreneau)
		-- Il faut que le terrain soit actif pour être considéré comme disponible
		AND T.ACTIF = 1
		ORDER BY 
				T.NUM_TERRAIN;
	BEGIN
		pq_ui_commun.aff_header;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_avoir_lieu.exec_add_avoir_lieu', 'POST');				
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Création d''une nouvelle séance');
			htp.print('</div>');			
			htp.br;
			htp.tableOpen;
			htp.br;				
			htp.tableRowOpen;
			htp.tableData('Jour :');									
				htp.print('<td>');
				htp.print('<label>');
					if(vnumJour=1)
					then
						htp.print('Lundi');
					elsif(vnumJour=2)
					then
						htp.print('Mardi');
					elsif(vnumJour=3)
					then
						htp.print('Mercredi');
					elsif(vnumJour=4)
					then
						htp.print('Jeudi');
					elsif(vnumJour=5)
					then
						htp.print('Vendredi');
					elsif(vnumJour=6)
					then
						htp.print('Samedi');
					elsif(vnumJour=7)
					then
						htp.print('Dimanche');
					end if;
				htp.print('</label>');									
				htp.print('</td>');						
			htp.tableRowClose;	
			htp.tableRowOpen;
			htp.tableData('Heure de début :');								
				htp.print('<td>');
				htp.print('<label>'||vheureDebutCreneau||'</label>');									
				htp.print('</td>');							
			htp.tableRowClose;
			htp.tableRowOpen;
			htp.tableData('Terrain :', cattributes => 'class="enteteFormulaire"');								
				htp.print('<td>');
				htp.print('<select name="vnumTerrain" id="vnumTerrain">');		
				for currentTerrain in listTerrainDispo loop
						htp.print('<option value="'||currentTerrain.NUM_TERRAIN||'">n°'||currentTerrain.NUM_TERRAIN || ', surface : ' || currentTerrain.LIBELLE||'</option>');
				end loop;
				htp.print('</select>');										
				htp.print('</td>');	
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('');
				htp.tableData(htf.formSubmit(NULL,'Validation'));
			htp.tableRowClose;
			htp.formhidden ('vnumJour',vnumJour);
			htp.formhidden ('vheureDebutCreneau',vheureDebutCreneau);
			htp.formhidden ('vnumEntrainement',vnumEntrainement);
			htp.formhidden('vretourEntraineur',vretourEntraineur);
			htp.tableClose;
			htp.br;
			htp.br;
			htp.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement||'&'||'vretourEntraineur='||vretourEntraineur, 'Retourner au choix de la date et du créneau');
		htp.formClose;
		htp.br; 
		pq_ui_commun.aff_footer;
	END aff_add_avoir_lieu;	

	-- Exécute la procédure d'ajout d'une séance d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR 
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER
	, vretourEntraineur IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		FAILED_CREATE_SEANCE EXCEPTION;
		FAILED_CREATE_AVOIR_LIEU EXCEPTION;
		vexception_avoir_lieu NUMBER(1);
		vexception_occuper NUMBER(1);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		end if;
		vexception_avoir_lieu:=0;
		pq_ui_commun.aff_header;
		pq_db_avoir_lieu.add_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement,vexception_avoir_lieu);
		if(vexception_avoir_lieu=1)
		then
			RAISE FAILED_CREATE_AVOIR_LIEU;
		end if;
		--Création des occupations
		vexception_occuper:=0;
		pq_db_avoir_lieu.add_occupation_seance(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement,vexception_occuper);
		if(vexception_occuper=1)
		then
			RAISE FAILED_CREATE_SEANCE;
		end if;
		htp.br;
		htp.print('<div class="success"> ');
			htp.print('La séance a été ajoutée avec succès.');
		htp.print('</div>');		
		htp.br;
		if(vretourEntraineur=0) 
		then
			pq_ui_entrainement.dis_entrainement(vnumEntrainement);
		else
			pq_ui_entrainement_entraineur.dis_entrainement_entr(vnumEntrainement);
		end if;
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN FAILED_CREATE_AVOIR_LIEU  THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'ERREUR Un entrainement est déja programmé sur le terrain numéro ' ||vnumTerrain||' à '||vheureDebutCreneau);
		WHEN FAILED_CREATE_SEANCE THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'ERREUR Le terrain ' ||vnumTerrain|| ' est déja occupé à '||vheureDebutCreneau);
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de la séance en cours...');
	END exec_add_avoir_lieu;
	
	
	-- Exécute la procédure de suppression d'une séance d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER
	, vretourEntraineur IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		end if;
		htp.br;				
		pq_db_avoir_lieu.del_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain);
		--supprime les séances dont la date est > sysdate
		pq_db_occuper.del_seance(vheureDebutCreneau,vnumTerrain,sysdate,vnumEntrainement);	
		htp.print('<div class="success"> ');
			htp.print('La séance a été supprimée avec succès.');
		htp.print('</div>');	
		htp.br;		
		if(vretourEntraineur=0)
		then
			pq_ui_entrainement.dis_entrainement(vnumEntrainement);
		else
			pq_ui_entrainement_entraineur.dis_entrainement_entr(vnumEntrainement);
		end if;
		htp.br;	
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression de la séance en cours...');
	END exec_del_avoir_lieu;
	
	-- Affiche le formulaire permettant la saisie d'une nouvelle séance pour un entrainement
	PROCEDURE form_add_avoir_lieu(
	   vnumEntrainement IN NUMBER
	  ,vretourEntraineur IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		CURSOR creneaulist IS SELECT HEURE_DEBUT_CRENEAU FROM CRENEAU;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		end if;
		pq_ui_commun.aff_header;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_avoir_lieu.aff_add_avoir_lieu', 'POST');				
			htp.br;
			htp.formhidden ('vnumEntrainement',vnumEntrainement);
			htp.print('<div class="titre_niveau_1">');
				htp.print('Création d''une nouvelle séance');
			htp.print('</div>');				
			htp.br;
			htp.tableOpen;
			htp.br;				
			htp.tableRowOpen;
			htp.tableData('Jour :');									
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
			htp.tableData('Heure de début :');								
				htp.print('<td>');
				htp.print('<select name="vheureDebutCreneau" id="vheureDebutCreneau">');		
				for currentCreneau in creneaulist loop
						htp.print('<option value="'||currentCreneau.HEURE_DEBUT_CRENEAU||'">'||currentCreneau.HEURE_DEBUT_CRENEAU||'</option>');
				end loop;
				htp.print('</select>');										
				htp.print('</td>');							
			htp.tableRowClose;
			htp.tableRowOpen;
				htp.tableData('');
				htp.tableData(htf.formSubmit(NULL,'Choisir terrain'));
			htp.tableRowClose;
			htp.tableClose;
			htp.formhidden ('vretourEntraineur',vretourEntraineur);
		htp.formClose;
		htp.br;
		if(vretourEntraineur=0)
		then
			htp.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||vnumEntrainement, 'Retourner au descriptif de l''entrainement');
		else
			htp.anchor('pq_ui_entrainement_entraineur.exec_dis_entrainement_entr?pnumEntrainement='||vnumEntrainement, 'Retourner au descriptif de l''entrainement');
		end if;
		htp.br; 
		htp.br; 
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
	END form_add_avoir_lieu;
	
END pq_ui_avoir_lieu;

/