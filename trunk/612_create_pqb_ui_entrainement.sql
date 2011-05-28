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

	--affichage de la liste seule des entrainements
	PROCEDURE aff_entrainement
	IS
		CURSOR listEntrainement IS
		SELECT 
			E.NUM_ENTRAINEMENT
		   ,P.NOM_PERSONNE
		   ,P.PRENOM_PERSONNE
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
		ORDER BY 
			NUM_ENTRAINEMENT;
		
		vnomEntraineur VARCHAR2(20);
	BEGIN
		htp.br;				
		htp.print('Gestion des entrainements' || ' (' || htf.anchor('pq_ui_entrainement.manage_entrainement','Actualiser')|| ')' );
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_entrainement.form_add_entrainement','Ajouter un entrainement'));
		htp.br;	
		htp.br;
		htp.print(htf.anchor('pq_ui_entrainement.manage_historique_entrainement','Historique'));
		htp.br;
		htp.br;	
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Numéro');
			htp.tableheader('Intitulé');
			htp.tableheader('Entraineur');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for currentEntrainement in listEntrainement loop
				htp.tableRowOpen;
				htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);	
				htp.tabledata(currentEntrainement.LIB_ENTRAINEMENT);
				htp.tabledata(currentEntrainement.PRENOM_PERSONNE||'  '||currentEntrainement.NOM_PERSONNE);
				htp.tabledata(htf.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_entrainement.form_upd_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Mise à jour'));
				htp.tabledata(htf.anchor('pq_ui_entrainement.exec_del_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;	
			end loop;
		htp.tableClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END aff_entrainement;
	
	
	--Permet d'afficher tous les entrainement existant 
	PROCEDURE manage_entrainement
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		aff_entrainement;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END manage_entrainement;

	--Permet d'afficher tous les entrainement inactifs
	PROCEDURE manage_historique_entrainement
	IS
		CURSOR listEntrainement IS
		SELECT 
			E.NUM_ENTRAINEMENT
		   ,P.NOM_PERSONNE
		   ,P.PRENOM_PERSONNE
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
			TRUNC(DATE_FIN_ENTRAINEMENT)<TRUNC(SYSDATE)
		ORDER BY 
			NUM_ENTRAINEMENT;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
				htp.br;				
				htp.print('Gestion de l''historique des entrainements');
				htp.br;
				htp.br;	
				htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('Numéro');
				htp.tableheader('Intitulé');
				htp.tableheader('Entraineur');
				htp.tableheader('Informations');
					for currentEntrainement in listEntrainement loop
						htp.tableRowOpen;
						htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);	
						htp.tabledata(currentEntrainement.LIB_ENTRAINEMENT);
						htp.tabledata(currentEntrainement.PRENOM_PERSONNE||'  '||currentEntrainement.NOM_PERSONNE);
						htp.tabledata(htf.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
						htp.tableRowClose;
					end loop;	
				htp.tableClose;
				htp.br;
				htp.br;
				htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner à la gestion des entrainements actuels');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des historiques des entrainements');
	END manage_historique_entrainement;
	
	
	-- Exécute la procédure d’affichage des entrainements et gère les erreurs éventuelles
	PROCEDURE exec_dis_entrainement(
	  vnumEntrainement IN NUMBER)
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
		pq_ui_entrainement.dis_entrainement(vnumEntrainement);	
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage de l''entrainement en cours...');
	END exec_dis_entrainement;
	
	-- Exécute la procédure d'ajout d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_entrainement(
	  vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vlibEntrainement IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN VARCHAR2
	, vdateFin IN VARCHAR2)
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
		pq_db_entrainement.add_entrainement(vnumEntraineur,vcodeNiveau,vlibEntrainement,vnbPlaces,to_date(vdateDebut, 'dd/mm/yy'),to_date(vdateFin, 'dd/mm/yy'));
		htp.br;
		htp.print('L''entrainement a été créé avec succès');
		htp.br;
		htp.br;
		SELECT SEQ_ENTRAINEMENT.currval INTO sequenceNumEntrainement FROM dual;
		pq_ui_entrainement.dis_entrainement(sequenceNumEntrainement);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un entrainement en cours...');
	END exec_add_entrainement;
	
	-- Exécute la procédure de mise à jour d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vlibEntrainement IN VARCHAR2
	, vnbPlaces IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_db_entrainement.upd_entrainement(vnumEntrainement,vnumEntraineur,vcodeNiveau,vlibEntrainement,vnbPlaces);
		htp.br;
		htp.print('L''entrainement n° '|| vnumEntrainement || ' a été modifié avec succès.');
		htp.br();
		htp.br();
		pq_ui_entrainement.aff_entrainement;
		htp.br();
		pq_ui_commun.aff_footer;
		EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification de l''entrainement en cours...');
	END exec_upd_entrainement;

	-- Exécute la procédure de suppression d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		--supprimer l'entrainement
		pq_db_entrainement.del_entrainement(vnumEntrainement);
		htp.br;
		htp.print('L''entrainement n° '|| vnumEntrainement || ' a été supprimé avec succès.');
		htp.br;
		htp.br;			
		pq_ui_entrainement.aff_entrainement;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un entrainement en cours...');
	END exec_del_entrainement;
	
	--Permet d’afficher un entrainement existant
	PROCEDURE dis_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
		vnumEntraineur ENTRAINEMENT.NUM_ENTRAINEUR%TYPE;
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vdateDebut ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE;
		vdateFin ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		vprenomEntraineur VARCHAR2(40);
		vnomEntraineur VARCHAR2(40);
		vnbSeance NUMBER (3);
		CURSOR listSeance IS SELECT NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=vnumEntrainement ORDER BY NUM_JOUR;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;

		SELECT NUM_ENTRAINEUR,LIB_ENTRAINEMENT,CODE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,DATE_FIN_ENTRAINEMENT 
		INTO vnumEntraineur,vlibEntrainement,vcodeNiveau,vnbplaces,vdateDebut,vdateFin
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
		
		SELECT P.PRENOM_PERSONNE INTO vprenomEntraineur FROM PERSONNE P WHERE P.NUM_PERSONNE=vnumEntraineur;
		SELECT P.NOM_PERSONNE INTO vnomEntraineur FROM PERSONNE P WHERE P.NUM_PERSONNE=vnumEntraineur;
		SELECT COUNT(*) INTO vnbSeance FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=vnumEntrainement;
		htp.br;	
		htp.print('Affichage des informations d''un entrainement');
		htp.br;
		htp.br;						
		htp.print('Desription de l''entrainement numéro '|| vnumEntrainement || ' : '||vlibEntrainement);
		htp.br;	
		htp.br;
		htp.print('Il est animé par '|| vprenomEntraineur || ' ' || vnomEntraineur || '.');
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
				currentSeance.HEURE_DEBUT_CRENEAU||'&'||'vnumTerrain='||currentSeance.NUM_TERRAIN||'&'||'vnumEntrainement='||vnumEntrainement, 
				'Supprimer',cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.print('</td>');
				htp.tableRowClose;
				htp.br;
			end loop;
		end if;
		htp.br;	
		htp.tableClose;
		htp.br;
		htp.br;
		htp.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement, 'Ajouter une séance');	
		htp.br;
		htp.br;
		if(TRUNC(vdateFin)>=TRUNC(SYSDATE))
		then
			htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner à la gestion des entrainements');
		else
			htp.anchor('pq_ui_entrainement.manage_historique_entrainement', 'Retourner à la gestion des entrainements');
		end if;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END dis_entrainement;
	
	-- Affiche le formulaire permettant la saisie d’un nouvel entrainement
	PROCEDURE form_add_entrainement
	IS
		CURSOR entraineurlist IS SELECT NUM_PERSONNE,NOM_PERSONNE,PRENOM_PERSONNE FROM PERSONNE WHERE CODE_STATUT_EMPLOYE='ENT';
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement.exec_add_entrainement', 'POST', cattributes => 'onSubmit="return validerEntrainement(this,document)"');				
				htp.br;
				htp.print('Création d''un nouvel entrainement');
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableRowOpen;
				htp.tableData('Entraineur * :');
					--Forme une liste déroulante avec tous les entraineur à partir de la table personne									
					htp.print('<td>');
					htp.print('<select name="vnumEntraineur" id="vnumEntraineur">');		
					for currentEntraineur in entraineurlist loop
							htp.print('<option value="'||currentEntraineur.NUM_PERSONNE||'">'||currentEntraineur.PRENOM_PERSONNE||' '||currentEntraineur.NOM_PERSONNE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;	
				htp.tableRowOpen;
				htp.tableData('Niveau * :');
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="vcodeNiveau" id="vcodeNiveau">');		
					for currentNiveau in niveaulist loop
							htp.print('<option value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libellé * :');	
					htp.print('<td>');					
					htp.formText('vlibEntrainement',20);										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :');	
					htp.print('<td>');					
					htp.formText('vnbPlaces',2);										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de début * :');	
					htp.print('<td>');					
					htp.formText('vdateDebut',8);
					htp.print('date sous le forme "22/01/10"');
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de fin * :');	
					htp.print('<td>');					
					htp.formText('vdateFin',8);										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner à la gestion des entrainements');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END form_add_entrainement;
	
	-- Affiche le formulaire de saisie permettant la modification d’un entrainement existant	
	PROCEDURE form_upd_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
		vnumEntraineur ENTRAINEMENT.NUM_ENTRAINEUR%TYPE;
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		CURSOR entraineurlist IS SELECT NUM_PERSONNE,NOM_PERSONNE,PRENOM_PERSONNE FROM PERSONNE WHERE CODE_STATUT_EMPLOYE='ENT';
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		
		SELECT NUM_ENTRAINEUR,CODE_NIVEAU,LIB_ENTRAINEMENT,NB_PLACE_ENTRAINEMENT
		INTO vnumEntraineur,vcodeNiveau,vlibEntrainement,vnbplaces
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
		
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement.exec_upd_entrainement', 'POST');				
				htp.formhidden ('vnumEntrainement',vnumEntrainement);
				htp.br;
				htp.print('Mise à jour de l''entrainement numéro ' || vnumEntrainement);
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableRowOpen;
				htp.tableData('Entraineur * :');	
					--Forme une liste déroulante avec tous les entraineur à partir de la table personne									
					htp.print('<td>');
					htp.print('<select name="vnumEntraineur" id="vnumEntraineur">');		
					for currentEntraineur in entraineurlist loop
						if(currentEntraineur.NUM_PERSONNE=vnumEntraineur)
						then
							htp.print('<option selected value="'||currentEntraineur.NUM_PERSONNE||'">'||currentEntraineur.PRENOM_PERSONNE||' '||currentEntraineur.NOM_PERSONNE||'</option>');
						else
							htp.print('<option value="'||currentEntraineur.NUM_PERSONNE||'">'||currentEntraineur.PRENOM_PERSONNE||' '||currentEntraineur.NOM_PERSONNE||'</option>');
						end if;
					end loop;
					htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;	
				htp.tableRowOpen;
				htp.tableData('Niveau * :');	
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="vcodeNiveau" id="vcodeNiveau">');		
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
					htp.print('<INPUT TYPE="text" name="vlibEntrainement" value="'||vlibEntrainement||'"> ');													
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :');	
					htp.print('<td>');	
					htp.print('<INPUT TYPE="text" name="vnbPlaces" value="'||vnbPlaces||'"> ');													
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
				htp.tableData('');
				htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner à la gestion des entrainements');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END form_upd_entrainement;
		
END pq_ui_entrainement;
/