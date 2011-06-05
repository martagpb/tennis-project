-- -----------------------------------------------------------------------------
--           Création du package d'affichage des données
--           pour la table PERSONNE
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 22/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_personne
IS
	--Permet d'afficher toutes les personnes et les actions possibles de gestion avec le menu
	PROCEDURE manage_personnes
	IS
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		pq_ui_personne.dis_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des personnes');
	END manage_personnes;	
				
	--Permet d'afficher toutes les personnes et les actions possibles de gestion (sans le menu)
	PROCEDURE dis_personnes
	IS		
		-- On stocke dans un curseur la liste de toutes les personnes existantes
		CURSOR listpersonne IS
		SELECT 
			 PER.NUM_PERSONNE           
			,PER.NOM_PERSONNE
			,PER.PRENOM_PERSONNE
			,PER.LOGIN_PERSONNE
			,PER.VILLE_PERSONNE
			,PER.CODE_STATUT_EMPLOYE
			,PER.NATURE_STATUT_EMPLOYE
			,PER.CODE_NIVEAU
			,PER.NATURE_NIVEAU
			,PER.STATUT_JOUEUR
		FROM 
			PERSONNE PER
		ORDER BY 
			1;
	BEGIN	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des personnes');
		htp.print('</div>');	
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_personne.form_add_personne','Ajouter un personne'));
		htp.br;	
		htp.br;					
		htp.tableOpen('',cattributes => 'class="tableau"');
		htp.tableheader('N° du personne');
		htp.tableheader('Nom');
		htp.tableheader('Prénom');
		htp.tableheader('Login');
		htp.tableheader('Ville');
		htp.tableheader('Niveau');
		htp.tableheader('Statut joueur');
		htp.tableheader('Statut employé');
		for currentpersonne in listpersonne loop
			htp.tableRowOpen;
			htp.tabledata(currentpersonne.NUM_PERSONNE);
			htp.tabledata(currentpersonne.NOM_PERSONNE);
			htp.tabledata(currentpersonne.PRENOM_PERSONNE);
			htp.tabledata(currentpersonne.LOGIN_PERSONNE);
			IF currentpersonne.VILLE_PERSONNE IS NOT NULL THEN
				htp.tabledata(currentpersonne.VILLE_PERSONNE);
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.CODE_NIVEAU IS NOT NULL THEN
				htp.tabledata(pq_db_codification.get_libelle(currentpersonne.CODE_NIVEAU,currentpersonne.NATURE_NIVEAU));
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.STATUT_JOUEUR IS NOT NULL THEN
			htp.tabledata(currentpersonne.STATUT_JOUEUR);
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.CODE_STATUT_EMPLOYE IS NOT NULL THEN
			htp.tabledata(pq_db_codification.get_libelle(currentpersonne.CODE_STATUT_EMPLOYE,currentpersonne.NATURE_STATUT_EMPLOYE));
			ELSE
				htp.tabledata('');
			END IF;			
			htp.tabledata(htf.anchor('pq_ui_personne.dis_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Informations complémentaires'));
			htp.tabledata(htf.anchor('pq_ui_personne.form_upd_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Mise à jour'));
			htp.tabledata(htf.anchor('pq_ui_personne.exec_del_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
			htp.tableRowClose;
		end loop;	
		htp.tableClose;			
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des personnes');
	END dis_personnes;

	--Permet d’afficher une personne existante
	PROCEDURE dis_personne(vnumpersonne IN NUMBER)
	IS
		currentPersonne PERSONNE%ROWTYPE;
		CURSOR listReservation IS
		SELECT 
			 OCC.DATE_OCCUPATION
			,OCC.NUM_TERRAIN
			,OCC.HEURE_DEBUT_CRENEAU
		FROM 
			OCCUPER OCC INNER JOIN ETRE_ASSOCIE ASS
				ON OCC.DATE_OCCUPATION=ASS.DATE_OCCUPATION
				AND OCC.NUM_TERRAIN=ASS.NUM_TERRAIN
				AND OCC.HEURE_DEBUT_CRENEAU=ASS.HEURE_DEBUT_CRENEAU
		WHERE
			ASS.NUM_PERSONNE=vnumpersonne 
		ORDER BY 
			1;
		CURSOR listEntrainement IS
		SELECT 
			  INS.NUM_ENTRAINEMENT
			 ,ENT.DATE_DEBUT_ENTRAINEMENT
			 ,ENT.DATE_FIN_ENTRAINEMENT
		FROM 
			S_INSCRIRE INS INNER JOIN ENTRAINEMENT ENT
				ON INS.NUM_ENTRAINEMENT=ENT.NUM_ENTRAINEMENT
		WHERE
			INS.NUM_PERSONNE=vnumpersonne
		ORDER BY 
			1;	
	BEGIN
		SELECT * into currentPersonne
		FROM PERSONNE
		WHERE NUM_PERSONNE=vnumpersonne;
		pq_ui_commun.aff_header;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Affichage des informations de la personne n°' || vnumpersonne);
			htp.print('</div>');			
			htp.br;
			htp.br;					
			htp.tableopen('',cattributes => 'class="tableau"');	
				htp.tablerowopen;
					htp.tabledata('N° de la personne :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vnumpersonne);
				htp.tablerowclose;					
				htp.tablerowopen;
					htp.tabledata('Nom :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.NOM_PERSONNE);				
				htp.tablerowclose;	
				htp.tablerowopen;
					htp.tabledata('Prénom :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.PRENOM_PERSONNE);				
				htp.tablerowclose;	
				htp.tablerowopen;
					htp.tabledata('Login :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.LOGIN_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Téléphone :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.TEL_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Mail :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.EMAIL_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Adresse :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.NUM_RUE_PERSONNE || ' ' || currentPersonne.CP_PERSONNE || ' ' || currentPersonne.VILLE_PERSONNE);				
				htp.tablerowclose;
				IF currentPersonne.CODE_STATUT_EMPLOYE IS NOT NULL THEN
				htp.tablerowopen;
					htp.tabledata('Statut d''employé :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(pq_db_codification.get_libelle(currentPersonne.CODE_STATUT_EMPLOYE,currentPersonne.NATURE_STATUT_EMPLOYE));				
				htp.tablerowclose;
				END IF; 
				IF currentPersonne.CODE_NIVEAU IS NOT NULL THEN
				htp.tablerowopen;
					htp.tabledata('Niveau :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(pq_db_codification.get_libelle(currentPersonne.CODE_NIVEAU,currentPersonne.NATURE_NIVEAU));				
				htp.tablerowclose;
				END IF;
			htp.tableclose;
			htp.br;
			htp.br;		
			htp.br;
			htp.br;
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Liste des réservations liées à cette personne :');
			htp.print('</div>');			
			htp.br;
			htp.br;	
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('Date de la réservation');
				htp.tableheader('Heure de réservation');
				htp.tableheader('Terrain');
				for currentreservation in listReservation loop
					htp.tableRowOpen;
					htp.tabledata(currentreservation.DATE_OCCUPATION);
					htp.tabledata(currentreservation.HEURE_DEBUT_CRENEAU);
					htp.tabledata(currentreservation.NUM_TERRAIN);
				end loop;	
			htp.tableClose;		
			htp.br;
			htp.br;		
			htp.br;
			htp.br;
			htp.br;
			IF currentPersonne.STATUT_JOUEUR='A' THEN
				htp.print('<div class="titre_niveau_1">');
					htp.print('Liste des entrainements suivis par cette personne :');
				htp.print('</div>');				
			htp.br;
			htp.br;	
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('Numéro de l''entrainement');
				htp.tableheader('Date de début de l''entrainement');
				htp.tableheader('Date de fin de l''entrainement');
				for currententrainement in listEntrainement loop
					htp.tableRowOpen;
					htp.tabledata(currententrainement.NUM_ENTRAINEMENT);
					htp.tabledata(currententrainement.DATE_DEBUT_ENTRAINEMENT);
					htp.tabledata(currententrainement.DATE_FIN_ENTRAINEMENT);
				end loop;	
			htp.tableClose;		
			END IF;
			htp.anchor('pq_ui_personne.manage_personnes_with_menu', 'Retourner à la gestion des personnes');	
		pq_ui_commun.aff_footer;
	END dis_personne;
	

	
	-- Exécute la procédure d'ajout d'un personne et gère les erreurs éventuelles.
/*	PROCEDURE exec_add_personne(
	  vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header;
			htp.br;
			pq_db_personne.add_personne(vcodeSurface,vnatureSurface,vactif);
			htp.print('<div class="success"> ');
				htp.print('Le personne a été ajouté avec succès.');
			htp.print('</div>');			
			htp.br;
			htp.br;			
			pq_ui_personne.manage_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un personne en cours...');
	END exec_add_personne;*/
	
	-- Exécute la procédure de mise à jour d'un personne et gère les erreurs éventuelles
/*	PROCEDURE exec_upd_personne(
	  vnumpersonne IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header;				
			pq_db_personne.upd_personne(vnumpersonne,vcodeSurface,vnatureSurface,vactif);
			htp.print('<div class="success"> ');
				htp.print('Le personne n° '|| vnumpersonne || ' a été mis à jour avec succès.');
			htp.print('</div>');				
			htp.br;
			htp.br;			
			pq_ui_personne.manage_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour d''un personne en cours...');
	END exec_upd_personne;*/
	
	-- Exécute la procédure de suppression d'un personne et gère les erreurs éventuelles
/*	PROCEDURE exec_del_personne(
	  vnumpersonne IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header;		
			pq_db_personne.del_personne(vnumpersonne);
			htp.print('<div class="success"> ');
				htp.print('Le personne n° '|| vnumpersonne || ' a été supprimé avec succès.');
			htp.print('</div>');				
			htp.br;
			htp.br;			
			pq_ui_personne.manage_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un personne en cours...');
	END exec_del_personne;*/
	
	
	/*
	-- Affiche le formulaire de saisie permettant la modification d’un personne existant
	PROCEDURE form_upd_personne(
	  vnumpersonne IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
		-- On stocke dans un curseur la liste de tous les libelles de codification existants
		CURSOR listLibelleCodification IS
		SELECT 
		    COD.LIBELLE
		  , COD.NATURE
		  , COD.CODE
		FROM 
			CODIFICATION COD
		WHERE
			--TODO : Récupérer cette valeur de manière dynamique si possible
			COD.NATURE = 'Surface'
		ORDER BY 
			1;
	BEGIN
		pq_ui_commun.aff_header;	
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_personne.exec_upd_personne', 'POST', cattributes => 'onSubmit="return validerpersonne(this,document)"');
					htp.formhidden ('vnumpersonne',vnumpersonne);
					--Les bonnes valeurs dans les champs hidden sont indiquées après validation du formulaire (Cf. validerpersonne)
					htp.formhidden ('vcodeSurface','DefaultValue', cattributes => 'id="idVcodeSurface"');
					htp.formhidden ('vnatureSurface','DefaultValue', cattributes => 'id="idVnatureSurface"');
					htp.tableOpen;
					htp.br;
					htp.print('Mise à jour d''un personne' || ' (' || htf.anchor('pq_ui_personne.form_upd_personne?vnumpersonne='||vnumpersonne||'&'||'vcodeSurface='||vcodeSurface||'&'||'vnatureSurface='||vnatureSurface||'&'||'vactif='||vactif,'Actualiser')|| ')' );
					htp.br;
					htp.br;
					htp.tableRowOpen;
						htp.tableData('N° du personne * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(vnumpersonne);
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Libelle de la surface * :', cattributes => 'class="enteteFormulaire"');	
						--Forme une liste déroulante avec tous les libellés de surface à partir de la table CODIFICATION									
						htp.print('<td>');
							htp.print('<select id="vlibelleSurface">');						
							FOR currentLibelle in listLibelleCodification loop
								--On transmet le code, la nature et le libellé
								htp.print('<option value="'||currentLibelle.CODE||'*'||currentLibelle.NATURE||'*'||currentLibelle.LIBELLE||'"');
								IF(currentLibelle.CODE=vcodeSurface and currentLibelle.NATURE=vnatureSurface) THEN
									--Valeur sélectionnée par défaut
									htp.print(' selected="selected"'); 
								END IF;
								htp.print('>'||currentLibelle.LIBELLE||'</option>');
							END LOOP; 																				
							htp.print('</select>');										
						htp.print('</td>');						
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('Le personne est-il actif ? * :', cattributes => 'class="enteteFormulaire"');												
						htp.print('<td>');
						htp.print('<select name="vactif" id="vactif">');
							htp.print('<option value="1"');
							IF(vactif=1) THEN
								htp.print(' selected="selected"'); --Valeur sélectionnée par défaut si actif vaut 1
							END IF;
							htp.print('>oui</option>');
							htp.print('<option value="0"');
							IF(vactif=0) THEN
								htp.print(' selected="selected"'); --Valeur sélectionnée par défaut si actif vaut 0
							END IF;
							htp.print('>non</option>');
						htp.print('</select>');
						htp.print('</td>');	
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_personne.manage_personnes_with_menu', 'Retourner à la gestion des personne');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''un personne');
	END form_upd_personne;
	*/	
END pq_ui_personne;
/