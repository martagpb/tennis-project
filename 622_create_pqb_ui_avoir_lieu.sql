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
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		FAILED_CREATE_SEANCE EXCEPTION;
		FAILED_CREATE_AVOIR_LIEU EXCEPTION;
		vexception_avoir_lieu NUMBER(1);
		vexception_occuper NUMBER(1);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		end if;
		pq_ui_commun.aff_header;
		pq_db_avoir_lieu.add_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement,vexception_avoir_lieu);
		if(vexception_avoir_lieu=1)
		then
			RAISE FAILED_CREATE_AVOIR_LIEU;
		end if;
		--Création des occupations
		pq_db_avoir_lieu.add_occupation_seance(vnumJour,vheureDebutCreneau,vnumTerrain,vnumEntrainement,vexception_occuper);
		if(vexception_occuper=1)
		then
			RAISE FAILED_CREATE_SEANCE;
		end if;
		
		pq_ui_entrainement.exec_dis_entrainement(vnumEntrainement);
		htp.br;
		htp.br;
		htp.print('La séance a été ajoutée avec succès.');
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN FAILED_CREATE_AVOIR_LIEU  THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'ERREUR Un entrainement est déja programmé sur le terrain numéro ' ||vnumTerrain||' à '||vheureDebutCreneau);
		WHEN FAILED_CREATE_SEANCE THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'ERREUR Le terrain ' ||vnumTerrain|| 'est déja occupé à '||vheureDebutCreneau);
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de la séance en cours...');
	END exec_add_avoir_lieu;
	
	
	-- Exécute la procédure de suppression d'une séance d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		end if;
		pq_ui_commun.aff_header;
		htp.br;				
		pq_db_avoir_lieu.del_avoir_lieu(vnumJour,vheureDebutCreneau,vnumTerrain);
		--supprime les séances dont la date est > sysdate
		pq_db_occuper.del_seance(vheureDebutCreneau,vnumTerrain,sysdate,vnumEntrainement);		
		htp.print('La séance a été supprimée avec succès.');
		htp.br;
		htp.br;			
		pq_ui_entrainement.exec_dis_entrainement(vnumEntrainement);
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression de la séance en cours...');
	END exec_del_avoir_lieu;
	  
	-- Affiche le formulaire permettant la saisie d'une nouvelle séance d'un entrainement
	PROCEDURE form_add_avoir_lieu(
	  vnumEntrainement IN NUMBER)
	IS
		CURSOR creneaulist IS SELECT HEURE_DEBUT_CRENEAU FROM CRENEAU;
		CURSOR terrainlist IS SELECT T.NUM_TERRAIN,C.LIBELLE FROM TERRAIN T INNER JOIN CODIFICATION C ON T.CODE_SURFACE = C.CODE WHERE C.NATURE = 'Surface';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		end if;
		pq_ui_commun.aff_header;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_avoir_lieu.exec_add_avoir_lieu', 'GET');				
			htp.br;
			htp.print('Création d''une nouvelle séance' || ' (' || htf.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement,'Actualiser')|| ')' );
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
		htp.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||vnumEntrainement, 'Retourner au descriptif de l''entrainement');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END form_add_avoir_lieu;
		
END pq_ui_avoir_lieu;
/