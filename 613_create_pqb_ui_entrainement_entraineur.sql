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

CREATE OR REPLACE PACKAGE BODY pq_ui_entrainement_entraineur
IS
	
	--affichage de la liste seule des entrainements d'un entraineur
	PROCEDURE aff_entrainement_entraineur(
		vnumEntraineur IN NUMBER)
	IS
		CURSOR listEntrainement IS
		SELECT 
			E.NUM_ENTRAINEMENT
		   ,E.LIB_ENTRAINEMENT
		   ,E.CODE_NIVEAU
		   ,E.NATURE_NIVEAU
		   ,E.NB_PLACE_ENTRAINEMENT
		   ,E.DATE_DEBUT_ENTRAINEMENT
		   ,E.DATE_FIN_ENTRAINEMENT
		FROM 
			ENTRAINEMENT E INNER JOIN PERSONNE P
			ON E.NUM_ENTRAINEUR=P.NUM_PERSONNE
		WHERE
			TRUNC(DATE_FIN_ENTRAINEMENT)>=TRUNC(SYSDATE)
			AND P.NUM_PERSONNE = vnumEntraineur
		ORDER BY 
			NUM_ENTRAINEMENT;
		
		vnomEntraineur VARCHAR2(20);
	BEGIN
		htp.br;				
		htp.print('Gestion des entrainements' || ' (' || htf.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur','Actualiser')|| ')' );
		htp.br;
		htp.br;	
		htp.print(htf.anchor('pq_ui_entrainement_entraineur.form_add_entrainement_entr','Ajouter un entrainement'));
		htp.br;	
		htp.br;
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Numéro');
			htp.tableheader('Intitulé');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for currentEntrainement in listEntrainement loop
				htp.tableRowOpen;
				htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);	
				htp.tabledata(currentEntrainement.LIB_ENTRAINEMENT);
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.exec_dis_entrainement_entr?pnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.form_upd_entrainement_entr?pnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Mise à jour'));
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.exec_del_entrainement_entr?pnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;	
			end loop;
		htp.tableClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END aff_entrainement_entraineur;
	
	--Permet d'afficher tous les entrainements de l'entraineur
	PROCEDURE manage_entrainement_entraineur
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN	
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
		aff_entrainement_entraineur(vnumEntraineur);
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END manage_entrainement_entraineur;	
	
	-- Exécute la procédure d’affichage des entrainements et gère les erreurs éventuelles
	PROCEDURE exec_dis_entrainement_entr(
	  pnumEntrainement IN NUMBER)
	IS		
		PERMISSION_DENIED EXCEPTION;
		perm BOOLEAN;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		htp.br;				
		pq_ui_entrainement_entraineur.dis_entrainement_entr(pnumEntrainement);	
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage de l''entrainement en cours...');
	END exec_dis_entrainement_entr;
	
	-- Exécute la procédure d'ajout d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_entrainement_entr(
	  pnumEntraineur IN NUMBER
	, pcodeNiveau IN CHAR
	, plibEntrainement IN VARCHAR2
	, pnbPlaces IN NUMBER
	, pdateDebut IN VARCHAR2
	, pdateFin IN VARCHAR2)
	IS
		sequenceNumEntrainement NUMBER(6);
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		pq_db_entrainement.add_entrainement(pnumEntraineur,pcodeNiveau,plibEntrainement,pnbPlaces,to_date(pdateDebut, 'dd/mm/yy'),to_date(pdateFin, 'dd/mm/yy'));
		htp.br;
		htp.print('L''entrainement a été créé avec succès');
		htp.br;
		htp.br;
		SELECT SEQ_ENTRAINEMENT.currval INTO sequenceNumEntrainement FROM dual;
		pq_ui_entrainement_entraineur.dis_entrainement_entr(sequenceNumEntrainement);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un entrainement en cours...');
	END exec_add_entrainement_entr;
	
	-- Exécute la procédure de mise à jour d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_upd_entrainement_entr(
	  pnumEntrainement IN NUMBER
	, pcodeNiveau IN CHAR
	, plibEntrainement IN VARCHAR2
	, pnbPlaces IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN
		pq_ui_commun.aff_header;
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
		pq_db_entrainement.upd_entrainement(pnumEntrainement,vnumEntraineur,pcodeNiveau,plibEntrainement,pnbPlaces);
		htp.br;
		htp.print('L''entrainement n° '|| pnumEntrainement || ' a été modifié avec succès.');
		htp.br();
		htp.br();
		pq_ui_entrainement_entraineur.aff_entrainement_entraineur(vnumEntraineur);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification de l''entrainement en cours...');
	END exec_upd_entrainement_entr;

	-- Exécute la procédure de suppression d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_entrainement_entr(
	  pnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
        pq_ui_commun.aff_header;
		--supprimer l'entrainement
		pq_db_entrainement.del_entrainement(pnumEntrainement);
		htp.br;
		htp.print('L''entrainement n° '|| pnumEntrainement || ' a été supprimé avec succès.');
		htp.br;
		htp.br;			
		pq_ui_entrainement_entraineur.aff_entrainement_entraineur(vnumEntraineur);
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un entrainement en cours...');
	END exec_del_entrainement_entr;
	
	--Permet d’afficher les informations d'un entrainement de l'entraineur
	
	PROCEDURE dis_entrainement_entr(
	  pnumEntrainement IN NUMBER)
	IS
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vdateDebut ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE;
		vdateFin ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		vnbSeance NUMBER (3);
		CURSOR listSeance IS SELECT NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=pnumEntrainement ORDER BY NUM_JOUR;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;

		SELECT LIB_ENTRAINEMENT,CODE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,DATE_FIN_ENTRAINEMENT 
		INTO vlibEntrainement,vcodeNiveau,vnbplaces,vdateDebut,vdateFin
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = pnumEntrainement;
		
		SELECT COUNT(*) INTO vnbSeance FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=pnumEntrainement;
		htp.br;	
		htp.print('Affichage des informations d''un entrainement');
		htp.br;
		htp.br;						
		htp.print('Desription de l''entrainement numéro '|| pnumEntrainement || ' : '||vlibEntrainement);
		htp.br;
		htp.print('L''entrainement s''adresse aux joueurs possèdant au moins le niveau : '|| vcodeNiveau || '.');
		htp.br;
		htp.print('Le nombre de places disponibles est de : '|| vnbPlaces || '.');
		htp.br;
		htp.print('Il a lieu entre le  : '|| TO_CHAR(vdateDebut,'DD/MM/YYYY') || ' et le ' || TO_CHAR(vdateFin,'DD/MM/YYYY') ||'.');
		htp.br;
		htp.br;
		htp.print('Séances   : ');
		htp.tableOpen;
		if(vnbSeance=0)
		then
			htp.tableRowOpen;
			htp.print('<td>');
			htp.print('L''entrainement n''a pas encore de séance.');
			htp.print('</td>');
			htp.tableRowClose;
		else
			for currentSeance in listSeance loop
				htp.tableRowOpen;
				htp.print('<td>');
				htp.print('   *   ' || 'Le ');
				if(currentSeance.NUM_JOUR=1)
				then
					htp.print('lundi ');
				end if;
				if(currentSeance.NUM_JOUR=2)
				then
					htp.print('mardi ');
				end if;
				if(currentSeance.NUM_JOUR=3)
				then
					htp.print('mercredi ');
				end if;
				if(currentSeance.NUM_JOUR=4)
				then
					htp.print('jeudi ');
				end if;
				if(currentSeance.NUM_JOUR=5)
				then
					htp.print('vendredi ');
				end if;
				if(currentSeance.NUM_JOUR=6)
				then
					htp.print('samedi ');
				end if;
				if(currentSeance.NUM_JOUR=7)
				then
					htp.print('dimanche ');
				end if;
				htp.print(' à ' || currentSeance.HEURE_DEBUT_CRENEAU || ' sur le terrain numéro ' || currentSeance.NUM_TERRAIN || '.' );	
				htp.tabledata(htf.anchor('pq_ui_avoir_lieu.exec_del_avoir_lieu?vnumJour='||currentSeance.NUM_JOUR||'&'||'vheureDebutCreneau='||
				currentSeance.HEURE_DEBUT_CRENEAU||'&'||'vnumTerrain='||currentSeance.NUM_TERRAIN||'&'||'vnumEntrainement='||pnumEntrainement 
				||'&'||'vretourEntraineur=1','Supprimer',cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.print('</td>');
				htp.tableRowClose;
				htp.br;
			end loop;
		end if;
		htp.br;	
		htp.tableClose;
		htp.br;
		htp.br;
		htp.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||pnumEntrainement||'&'||'vretourEntraineur=1', 'Ajouter une séance');	
		htp.br;
		htp.br;
		htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner à la gestion des entrainements');
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
	END dis_entrainement_entr;
	
	-- Affiche le formulaire permettant la saisie d’un nouvel entrainement
	PROCEDURE form_add_entrainement_entr
	IS
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		num_entraineur NUMBER(5);
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;	
		target_cookie := OWA_COOKIE.get('numpersonne');
		num_entraineur:=TO_NUMBER(target_cookie.vals(1));
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement_entraineur.exec_add_entrainement_entr', 'POST', cattributes => 'onSubmit="return test(this,document)"');				
				htp.br;
				htp.print('Création d''un nouvel entrainement');
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.formhidden('pnumEntraineur',num_entraineur);
				htp.tableRowOpen;
				htp.tableData('Niveau * :');
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="pcodeNiveau" id="pcodeNiveau">');		
					for currentNiveau in niveaulist loop
							htp.print('<option value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libellé * :');	
					htp.print('<td>');					
					htp.formText('plibEntrainement',20,cattributes => 'maxlength="50"');										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :');	
					htp.print('<td>');					
					htp.formText('pnbPlaces',2,cattributes => 'maxlength="2"');										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de début * :');	
					htp.print('<td>');					
					htp.formText('pdateDebut',8);
					htp.print('date sous le forme "22/01/10"');
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de fin * :');	
					htp.print('<td>');					
					htp.formText('pdateFin',8);										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner à la gestion des entrainements');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
	END form_add_entrainement_entr;
	
	-- Affiche le formulaire de saisie permettant la modification d’un entrainement existant	
	PROCEDURE form_upd_entrainement_entr(
	  pnumEntrainement IN NUMBER)
	IS
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		
		SELECT CODE_NIVEAU,LIB_ENTRAINEMENT,NB_PLACE_ENTRAINEMENT
		INTO vcodeNiveau,vlibEntrainement,vnbplaces
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = pnumEntrainement;
		
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement_entraineur.exec_upd_entrainement_entr', 'POST');				
				htp.formhidden ('pnumEntrainement',pnumEntrainement);
				htp.br;
				htp.print('Mise à jour de l''entrainement numéro ' || pnumEntrainement);
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableData('Niveau * :');	
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="pcodeNiveau" id="pcodeNiveau">');		
					for currentNiveau in niveaulist loop
						if(currentNiveau.CODE=vcodeNiveau)
						then
							htp.print('<option selected value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
						else
							htp.print('<option value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
						end if;
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libellé * :');	
					htp.print('<td>');	
					htp.print('<INPUT TYPE="text" name="plibEntrainement" maxlength="50" value="'||vlibEntrainement||'"> ');													
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :');	
					htp.print('<td>');	
					htp.print('<INPUT TYPE="text" name="pnbPlaces" maxlength="2" value="'||vnbPlaces||'"> ');													
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
				htp.tableData('');
				htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner à la gestion des entrainements');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusé.');
	END form_upd_entrainement_entr;
		
END pq_ui_entrainement_entraineur;
/