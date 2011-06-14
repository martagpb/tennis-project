-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table TERRAIN
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 22/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_terrain
IS 

	--Permet d'afficher tous les terrains et les actions possibles de gestion avec le menu
	PROCEDURE manage_terrains_with_menu
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
		pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des terrains');
	END manage_terrains_with_menu;	
				
--Permet d'afficher tous les terrains et les actions possibles de gestion (sans le menu)
	PROCEDURE manage_terrains
	IS		
		-- On stocke dans un curseur la liste de tous les terrains existants
		CURSOR listTerrain IS
		SELECT 
		   TER.NUM_TERRAIN            
		 , TER.CODE_SURFACE           
		 , TER.NATURE_SURFACE         
		 , TER.ACTIF                  
		FROM 
			TERRAIN TER
		ORDER BY 
			1;
		
		--Variables permettant de déterminer si le curseur est vide ou non
		cursorListIsEmpty BOOLEAN:= true;
		nbValuesIntoCursorList NUMBER(1):= 0; 		
						
		terrainUtilisePourEntrainement NUMBER(5):= 0;  
		terrainUtilisePourReservation  NUMBER(5):= 0; 
		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		htp.br;	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des terrains');
		htp.print('</div>');			
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_terrain.form_add_terrain','Ajouter un terrain'));
		htp.br;	
		htp.br;		

		--On parcours le curseur pour déterminer s'il est vide
		for emptyTerrain in listTerrain loop
			nbValuesIntoCursorList:= nbValuesIntoCursorList + 1;	
			--On sort de la boucle dès qu'il y a une valeur
			if nbValuesIntoCursorList > 0 then
				--On indique le fait que le curseur n'est pas vide
				cursorListIsEmpty := false;
				exit;
			end if;
		end loop;	
		
		--Si le curseur est vide alors on affiche un message indiquant qu'il n'y a pas de valeur
		if cursorListIsEmpty = true Then	
			htp.print('Il n''y a aucun terrain de disponible.');	
		--Sinon, si le curseur contient au moins une valeur alors on affiche le tableau
		else		
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('N° du terrain');
				htp.tableheader('Libellé surface');
				htp.tableheader('Actif');
				htp.tableheader('Informations');
				htp.tableheader('Mise à jour');
				htp.tableheader('Suppression');
				for currentTerrain in listTerrain loop
					htp.tableRowOpen;
					htp.tabledata(currentTerrain.NUM_TERRAIN);
					--On récupère le libellé du terrain à partir du code et de la nature
					htp.tabledata(pq_db_codification.get_libelle(currentTerrain.CODE_SURFACE,currentTerrain.NATURE_SURFACE));
					htp.tabledata(pq_ui_param_commun.dis_number_to_yes_or_not(currentTerrain.ACTIF));					
					htp.tabledata(htf.anchor('pq_ui_terrain.dis_terrain?vnumTerrain='||currentTerrain.NUM_TERRAIN||'&'||'vcodeSurface='||currentTerrain.CODE_SURFACE||'&'||'vnatureSurface='||currentTerrain.NATURE_SURFACE||'&'||'vactif='||currentTerrain.ACTIF,'Informations'));
									
					--Permet de déterminer si un terrain est utilisé pour un entrainement				
					SELECT 
						COUNT(*) INTO terrainUtilisePourEntrainement
					FROM 
						AVOIR_LIEU 
					WHERE 
						NUM_TERRAIN = currentTerrain.NUM_TERRAIN;
						
					--Permet de déterminer si un terrain est utilisé pour une réservation (autre qu'un entrainement)		
					SELECT 
						COUNT(*) INTO terrainUtilisePourReservation
					FROM 
						OCCUPER 
					WHERE 
						NUM_TERRAIN = currentTerrain.NUM_TERRAIN;	
						
					--On autorise la mise à jour et la suppression d'un terrain seulement dans le cas où il n'est pas utilisé
					if (terrainUtilisePourEntrainement = 0 and terrainUtilisePourReservation = 0) then
						htp.tabledata(htf.anchor('pq_ui_terrain.form_upd_terrain?vnumTerrain='||currentTerrain.NUM_TERRAIN||'&'||'vcodeSurface='||currentTerrain.CODE_SURFACE||'&'||'vnatureSurface='||currentTerrain.NATURE_SURFACE||'&'||'vactif='||currentTerrain.ACTIF,'Mise à jour'));
						htp.tabledata(htf.anchor('pq_ui_terrain.exec_del_terrain?vnumTerrain='||currentTerrain.NUM_TERRAIN,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
					else
						htp.tabledata(pq_ui_param_commun.dis_forbidden);
						htp.tabledata(pq_ui_param_commun.dis_forbidden);
					end if;						
					
					htp.tableRowClose;
				end loop;	
			htp.tableClose;	
		end if;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des terrains');
	END manage_terrains;

	--Permet d’afficher un terrain existant
	PROCEDURE dis_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
			htp.br;	
			htp.print('<div class="titre_niveau_1">');
				htp.print('Affichage des informations d''un terrain');
			htp.print('</div>');				
			htp.br;
			htp.br;					
			htp.tableopen;		
				htp.tablerowopen;
					htp.tabledata('N° du terrain :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vnumTerrain);
				htp.tablerowclose;					
				htp.tablerowopen;
					htp.tabledata('Libelle de la surface :', cattributes => 'class="enteteFormulaire"');
					--On récupère le libellé du terrain à partir du code et de la nature
					htp.tabledata(pq_db_codification.get_libelle(vcodeSurface,vnatureSurface));					
				htp.tablerowclose;				
				htp.tablerowopen;
					htp.tabledata('Le terrain est-il actif ? :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(pq_ui_param_commun.dis_number_to_yes_or_not(vactif));
				htp.tablerowclose;
			htp.tableclose;
			htp.br;
			htp.br;		
			htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Retourner à la gestion des terrains');	
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
	END dis_terrain;
	
	-- Exécute la procédure d'ajout d'un terrain et gère les erreurs éventuelles.
	PROCEDURE exec_add_terrain(
	  vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
			htp.br;
			pq_db_terrain.add_terrain(vcodeSurface,vnatureSurface,vactif);
			htp.print('<div class="success"> ');
				htp.print('Le terrain a été ajouté avec succès.');
			htp.print('</div>');	
			htp.br;
			htp.br;			
			pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un terrain en cours...');
	END exec_add_terrain;
	
	-- Exécute la procédure de mise à jour d'un terrain et gère les erreurs éventuelles
	PROCEDURE exec_upd_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;				
			pq_db_terrain.upd_terrain(vnumTerrain,vcodeSurface,vnatureSurface,vactif);
			htp.print('<div class="success"> ');
				htp.print('Le terrain n° '|| vnumTerrain || ' a été mis à jour avec succès.');
			htp.print('</div>');	
			htp.br;
			htp.br;			
			pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour d''un terrain en cours...');
	END exec_upd_terrain;
	
	-- Exécute la procédure de suppression d'un terrain et gère les erreurs éventuelles
	PROCEDURE exec_del_terrain(
	  vnumTerrain IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;		
			pq_db_terrain.del_terrain(vnumTerrain);
			htp.print('<div class="success"> ');
				htp.print('Le terrain n° '|| vnumTerrain || ' a été supprimé avec succès.');
			htp.print('</div>');
			htp.br;
			htp.br;			
			pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un terrain en cours...');
	END exec_del_terrain;
	
	-- Exécute la procédure d’affichage des terrains et gère les erreurs éventuelles
	PROCEDURE exec_dis_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;			
				pq_ui_terrain.dis_terrain(vnumTerrain,vcodeSurface,vnatureSurface,vactif);
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''un terrain en cours...');
	END exec_dis_terrain;
	
	-- Affiche le formulaire permettant la saisie d’un nouveau terrain
	PROCEDURE form_add_terrain
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
			COD.NATURE = 'Surface'
		ORDER BY 
			1;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;	
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_terrain.exec_add_terrain', 'POST', cattributes => 'onSubmit="return validerTerrain(this,document)"');				
				--Les bonnes valeurs dans les champs hidden sont indiquées après validation du formulaire (Cf. validerTerrain)
				htp.formhidden ('vcodeSurface','DefaultValue', cattributes => 'id="idVcodeSurface"');
				htp.formhidden ('vnatureSurface','DefaultValue', cattributes => 'id="idVnatureSurface"');
				htp.tableOpen;
				htp.br;
				htp.print('<div class="titre_niveau_1">');
					htp.print('Création d''un nouveau terrain');
				htp.print('</div>');				
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.br;				
				htp.tableRowOpen;
					htp.tableData('Libelle de la surface * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste déroulante avec tous les libellés de surface à partir de la table CODIFICATION									
					htp.print('<td>');
						htp.print('<select id="vlibelleSurface">');						
						FOR currentLibelle in listLibelleCodification loop							
							--L'utilisateur peut sélectionner le libellé dans la liste déroulante
							--Cependat, on transmet le code et la nature après validation
							htp.print('<option value="'||currentLibelle.CODE||'*'||currentLibelle.NATURE||'">'||currentLibelle.LIBELLE||'</option>');
						END LOOP; 																				
						htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Le terrain est-il actif ? * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(
						'<select name="vactif" id="vactif">
							<option value="1">oui</option>
							<option value="0">non</option>
						</select>');										
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''un nouveau terrain');
	END form_add_terrain;

	
	-- Affiche le formulaire de saisie permettant la modification d’un terrain existant
	PROCEDURE form_upd_terrain(
	  vnumTerrain IN NUMBER
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
			COD.NATURE = 'Surface'
		ORDER BY 
			1;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;	
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_terrain.exec_upd_terrain', 'POST', cattributes => 'onSubmit="return validerTerrain(this,document)"');
					htp.formhidden ('vnumTerrain',vnumTerrain);
					--Les bonnes valeurs dans les champs hidden sont indiquées après validation du formulaire (Cf. validerTerrain)
					htp.formhidden ('vcodeSurface','DefaultValue', cattributes => 'id="idVcodeSurface"');
					htp.formhidden ('vnatureSurface','DefaultValue', cattributes => 'id="idVnatureSurface"');
					htp.tableOpen;
					htp.br;
					htp.print('Mise à jour d''un terrain' || ' (' || htf.anchor('pq_ui_terrain.form_upd_terrain?vnumTerrain='||vnumTerrain||'&'||'vcodeSurface='||vcodeSurface||'&'||'vnatureSurface='||vnatureSurface||'&'||'vactif='||vactif,'Actualiser')|| ')' );
					htp.br;
					htp.br;
					htp.tableRowOpen;
						htp.tableData('N° du terrain * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(vnumTerrain);
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
						htp.tableData('Le terrain est-il actif ? * :', cattributes => 'class="enteteFormulaire"');												
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
				htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Retourner à la gestion des terrain');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''un terrain');
	END form_upd_terrain;
		
END pq_ui_terrain;
/