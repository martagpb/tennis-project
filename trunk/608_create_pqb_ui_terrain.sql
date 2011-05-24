-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table TERRAIN
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 22/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_terrain
AS

	--Permet d'afficher tous les terrains et les actions possibles de gestion avec le menu
	PROCEDURE manage_terrains_with_menu
	IS
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header(3);
		pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
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
	BEGIN		
		htp.br;	
		htp.print('Gestion des terrains' || ' (' || htf.anchor('pq_ui_terrain.manage_terrains_with_menu','Actualiser')|| ')' );
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_terrain.form_add_terrain','Ajouter un terrain'));
		htp.br;	
		htp.br;		
		htp.formOpen('',cattributes => 'class="tableau"');	
			htp.tableOpen;
			htp.tableheader('N� du terrain');
			htp.tableheader('Libell� surface');
			htp.tableheader('Actif');
			htp.tableheader('Informations');
			htp.tableheader('Mise � jour');
			htp.tableheader('Suppression');
			for currentTerrain in listTerrain loop
				htp.tableRowOpen;
				htp.tabledata(currentTerrain.NUM_TERRAIN);
				--On r�cup�re le libell� du terrain � partir du code et de la nature
				htp.tabledata(pq_db_codification.get_libelle(currentTerrain.CODE_SURFACE,currentTerrain.NATURE_SURFACE));
				htp.tabledata(pq_ui_param_commun.dis_number_to_yes_or_not(currentTerrain.ACTIF));							
				htp.tabledata(htf.anchor('pq_ui_terrain.dis_terrain?vnumTerrain='||currentTerrain.NUM_TERRAIN||'&'||'vcodeSurface='||currentTerrain.CODE_SURFACE||'&'||'vnatureSurface='||currentTerrain.NATURE_SURFACE||'&'||'vactif='||currentTerrain.ACTIF,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_terrain.form_upd_terrain?vnumTerrain='||currentTerrain.NUM_TERRAIN||'&'||'vcodeSurface='||currentTerrain.CODE_SURFACE||'&'||'vnatureSurface='||currentTerrain.NATURE_SURFACE||'&'||'vactif='||currentTerrain.ACTIF,'Mise � jour'));
				htp.tabledata(htf.anchor('pq_ui_terrain.exec_del_terrain?vnumTerrain='||currentTerrain.NUM_TERRAIN,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;
			end loop;	
			htp.tableClose;
		htp.formClose;			
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des terrains');
	END manage_terrains;

	--Permet d�afficher un terrain existant
	PROCEDURE dis_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header(3);
			htp.br;	
			htp.print('Affichage des informations d''un terrain' || ' (' || htf.anchor('pq_ui_terrain.dis_terrain?vnumTerrain='||vnumTerrain||'&'||'vcodeSurface='||vcodeSurface||'&'||'vnatureSurface='||vnatureSurface||'&'||'vactif='||vactif,'Actualiser')|| ')' );
			htp.br;
			htp.br;					
			htp.tableopen;		
				htp.tablerowopen;
					htp.tabledata('N� du terrain :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vnumTerrain);
				htp.tablerowclose;					
				htp.tablerowopen;
					htp.tabledata('Libelle de la surface :', cattributes => 'class="enteteFormulaire"');
					--On r�cup�re le libell� du terrain � partir du code et de la nature
					htp.tabledata(pq_db_codification.get_libelle(vcodeSurface,vnatureSurface));					
				htp.tablerowclose;				
				htp.tablerowopen;
					htp.tabledata('Le terrain est-il actif ? :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(pq_ui_param_commun.dis_number_to_yes_or_not(vactif));
				htp.tablerowclose;
			htp.tableclose;
			htp.br;
			htp.br;		
			htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Retourner � la gestion des terrains');	
		pq_ui_commun.aff_footer;
	END dis_terrain;
	
	-- Ex�cute la proc�dure d'ajout d'un terrain et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_terrain(
	  vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header(3);
			htp.br;
			pq_db_terrain.add_terrain(vcodeSurface,vnatureSurface,vactif);
			htp.print('Le terrain a �t� ajout� avec succ�s.');
			htp.br;
			htp.br;			
			pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un terrain en cours...');
	END exec_add_terrain;
	
	-- Ex�cute la proc�dure de mise � jour d'un terrain et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header(3);				
			pq_db_terrain.upd_terrain(vnumTerrain,vcodeSurface,vnatureSurface,vactif);
			htp.print('Le terrain n� '|| vnumTerrain || ' a �t� mis � jour avec succ�s.');
			htp.br;
			htp.br;			
			pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise � jour d''un terrain en cours...');
	END exec_upd_terrain;
	
	-- Ex�cute la proc�dure de suppression d'un terrain et g�re les erreurs �ventuelles
	PROCEDURE exec_del_terrain(
	  vnumTerrain IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header(3);		
			pq_db_terrain.del_terrain(vnumTerrain);
			htp.print('Le terrain n� '|| vnumTerrain || ' a �t� supprim� avec succ�s.');
			htp.br;
			htp.br;			
			pq_ui_terrain.manage_terrains;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un terrain en cours...');
	END exec_del_terrain;
	
	-- Ex�cute la proc�dure d�affichage des terrains et g�re les erreurs �ventuelles
	PROCEDURE exec_dis_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		pq_ui_commun.aff_header(3);			
				pq_ui_terrain.dis_terrain(vnumTerrain,vcodeSurface,vnatureSurface,vactif);
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''un terrain en cours...');
	END exec_dis_terrain;
	
	-- Affiche le formulaire permettant la saisie d�un nouveau terrain
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
			--TODO : R�cup�rer cette valeur de mani�re dynamique si possible
			COD.NATURE = 'Surface'
		ORDER BY 
			1;
	BEGIN
		pq_ui_commun.aff_header(3);	
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_terrain.exec_add_terrain', 'POST', cattributes => 'onSubmit="return validerTerrain(this,document)"');				
				--Les bonnes valeurs dans les champs hidden sont indiqu�es apr�s validation du formulaire (Cf. validerTerrain)
				htp.formhidden ('vcodeSurface','DefaultValue', cattributes => 'id="idVcodeSurface"');
				htp.formhidden ('vnatureSurface','DefaultValue', cattributes => 'id="idVnatureSurface"');
				htp.tableOpen;
				htp.br;
				htp.print('Cr�ation d''un nouveau terrain' || ' (' || htf.anchor('pq_ui_terrain.form_add_terrain','Actualiser')|| ')' );
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.br;				
				htp.tableRowOpen;
					htp.tableData('Libelle de la surface * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste d�roulante avec tous les libell�s de surface � partir de la table CODIFICATION									
					htp.print('<td>');
						htp.print('<select id="vlibelleSurface">');						
						FOR currentLibelle in listLibelleCodification loop
							--On transmet le code, la nature et le libell�
							htp.print('<option value="'||currentLibelle.CODE||'*'||currentLibelle.NATURE||'*'||currentLibelle.LIBELLE||'">'||currentLibelle.LIBELLE||'</option>');
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
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''un nouveau terrain');
	END form_add_terrain;

	
	-- Affiche le formulaire de saisie permettant la modification d�un terrain existant
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
			--TODO : R�cup�rer cette valeur de mani�re dynamique si possible
			COD.NATURE = 'Surface'
		ORDER BY 
			1;
	BEGIN
		pq_ui_commun.aff_header(3);	
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_terrain.exec_upd_terrain', 'POST', cattributes => 'onSubmit="return validerTerrain(this,document)"');
					htp.formhidden ('vnumTerrain',vnumTerrain);
					--Les bonnes valeurs dans les champs hidden sont indiqu�es apr�s validation du formulaire (Cf. validerTerrain)
					htp.formhidden ('vcodeSurface','DefaultValue', cattributes => 'id="idVcodeSurface"');
					htp.formhidden ('vnatureSurface','DefaultValue', cattributes => 'id="idVnatureSurface"');
					htp.tableOpen;
					htp.br;
					htp.print('Mise � jour d''un terrain' || ' (' || htf.anchor('pq_ui_terrain.form_upd_terrain?vnumTerrain='||vnumTerrain||'&'||'vcodeSurface='||vcodeSurface||'&'||'vnatureSurface='||vnatureSurface||'&'||'vactif='||vactif,'Actualiser')|| ')' );
					htp.br;
					htp.br;
					htp.tableRowOpen;
						htp.tableData('N� du terrain * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(vnumTerrain);
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Libelle de la surface * :', cattributes => 'class="enteteFormulaire"');	
						--Forme une liste d�roulante avec tous les libell�s de surface � partir de la table CODIFICATION									
						htp.print('<td>');
							htp.print('<select id="vlibelleSurface">');						
							FOR currentLibelle in listLibelleCodification loop
								--On transmet le code, la nature et le libell�
								htp.print('<option value="'||currentLibelle.CODE||'*'||currentLibelle.NATURE||'*'||currentLibelle.LIBELLE||'"');
								IF(currentLibelle.CODE=vcodeSurface and currentLibelle.NATURE=vnatureSurface) THEN
									--Valeur s�lectionn�e par d�faut
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
								htp.print(' selected="selected"'); --Valeur s�lectionn�e par d�faut si actif vaut 1
							END IF;
							htp.print('>oui</option>');
							htp.print('<option value="0"');
							IF(vactif=0) THEN
								htp.print(' selected="selected"'); --Valeur s�lectionn�e par d�faut si actif vaut 0
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
				htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Retourner � la gestion des terrain');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''un terrain');
	END form_upd_terrain;
		
END pq_ui_terrain;
/