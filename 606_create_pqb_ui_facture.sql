-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table FACTURE
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 30/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_facture
IS

	--Affiche la liste des factures et les actions possibles de gestion (procédure privée)
	PROCEDURE liste_factures
	IS
		CURSOR listeFactures IS
		SELECT 
			  F.NUM_FACTURE
			, F.DATE_FACTURE
			, F.MONTANT_FACTURE
		FROM 
			FACTURE F
		ORDER BY 
			F.NUM_FACTURE;
			
	BEGIN
		htp.br;		
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des factures' );
		htp.print('</div>');		
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_facture.form_add_facture','Ajouter une facture'));
		htp.br;	
		htp.br;
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('N°');
			htp.tableheader('Date');
			htp.tableheader('Montant');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for currentFacture in listeFactures loop
				htp.tableRowOpen;
				htp.tabledata(currentFacture.NUM_FACTURE);
				htp.tabledata(currentFacture.DATE_FACTURE);		
				htp.tabledata(currentFacture.MONTANT_FACTURE);					
				htp.tabledata(htf.anchor('pq_ui_facture.dis_facture?pnumFacture='||currentFacture.NUM_FACTURE,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_facture.form_upd_facture?pnumFacture='||currentFacture.NUM_FACTURE,'Mise à jour'));
				htp.tabledata(htf.anchor('pq_ui_facture.exec_del_facture?pnumFacture='||currentFacture.NUM_FACTURE,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;
			end loop;	
		htp.tableClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des factures');
	END liste_factures;

	--Affiche le panneau de gestion des factures
	PROCEDURE manage_factures
	IS	
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
	pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
		liste_factures;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des factures');
	END manage_factures;
	
	--Affiche une facture existante
	PROCEDURE dis_facture(
	  pnumFacture IN VARCHAR2)
	IS		
		vnumFacture FACTURE.NUM_FACTURE%TYPE;
		vdate FACTURE.DATE_FACTURE%TYPE;
		vmontant FACTURE.MONTANT_FACTURE%TYPE;
		vnomPersonne PERSONNE.NOM_PERSONNE%TYPE;
		vdatePaiement FACTURE.DATE_PAIEMENT%TYPE;
		
		CURSOR listeResas(numFacture FACTURE.NUM_FACTURE%TYPE) IS
		SELECT O.HEURE_DEBUT_CRENEAU, O.NUM_TERRAIN, O.DATE_OCCUPATION, P.NOM_PERSONNE
		FROM OCCUPER O inner join PERSONNE P on O.NUM_JOUEUR = P.NUM_PERSONNE
		WHERE O.NUM_FACTURE = numFacture;
		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
        BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			vnumFacture := to_number(pnumFacture);
		
			SELECT F.DATE_FACTURE, F.MONTANT_FACTURE, P.NOM_PERSONNE, F.DATE_PAIEMENT
			INTO vdate, vmontant, vnomPersonne, vdatePaiement
			FROM FACTURE F inner join PERSONNE P on F.NUM_PERSONNE = P.NUM_PERSONNE
			WHERE F.NUM_FACTURE = vnumFacture;
			
			htp.print('<p>Facture n° ' || vnumFacture || '<br />');
			htp.print('Pour : ' || vnomPersonne || '<br />');
			htp.print('Date :' || vdate || '<br />');
			htp.print('Montant : ' || vmontant || '<br />');
			htp.print('Date paiement :' || vdatePaiement || '<br />');
			htp.print('</p>');
			
			htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Début créneau');
			htp.tableheader('Terrain');
			htp.tableheader('Date');
			htp.tableheader('Personne');
			FOR reservation IN listeResas(vnumFacture) LOOP
				htp.tableRowOpen;
				htp.tabledata(reservation.HEURE_DEBUT_CRENEAU);
				htp.tabledata(reservation.NUM_TERRAIN);		
				htp.tabledata(reservation.DATE_OCCUPATION);	
				htp.tabledata(reservation.NOM_PERSONNE);					
				htp.tableRowClose;
			END LOOP;
			htp.tableClose;
			
			htp.print(htf.anchor('pq_ui_facture.manage_factures','Retour à la gestion des factures'));
		
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Visualisation de facture');
		END;
		pq_ui_commun.aff_footer;
	END dis_facture;
	
	-- Affiche le formulaire de saisie d'une nouvelle facture
	PROCEDURE form_add_facture
	IS
		-- On utilise un curseur pour la liste de tous les visiteurs existants
		CURSOR listeVisiteurs IS
		SELECT P.NUM_PERSONNE, P.NOM_PERSONNE
		FROM PERSONNE P
		WHERE P.STATUT_JOUEUR = 'V'
		ORDER BY P.NOM_PERSONNE;
			
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Ajout de facture');
			htp.print('</div>');				
			htp.br;
			htp.br;
			htp.print('Les champs marqués d''une étoile sont obligatoires.');
			htp.br;
			htp.br;	
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_facture.exec_add_facture', 'POST', cattributes => 'onSubmit="return validerFacture(this,document)"');				
				htp.tableOpen;	
					htp.tableRowOpen;
						htp.tableData('Visiteur * :', cattributes => 'class="enteteFormulaire"');	
						--Forme une liste déroulante avec tous les visiteurs à partir de la table PERSONNE									
						htp.print('<td>');
							htp.print('<select name="pnumPersonne">');						
							FOR visiteur in listeVisiteurs loop
								htp.print('<option value="'||visiteur.NUM_PERSONNE||'">'||visiteur.NOM_PERSONNE||'</option>');
							END LOOP;
							htp.print('</select>');										
						htp.print('</td>');					
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('Date * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(htf.formText('pdate'));
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('Montant * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(htf.formText('pmontant'));
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('Date paiement :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(htf.formText('pdatePaiement'));
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Formulaire d''ajout de facture');
		END;
		
		pq_ui_commun.aff_footer;
	END form_add_facture;
        
	
	-- Exécute la procédure d'ajout d'une facture et gère les erreurs éventuelles.
	PROCEDURE exec_add_facture(
	  pdate IN VARCHAR2
	, pmontant IN VARCHAR2
	, pdatePaiement IN VARCHAR2
	, pnumPersonne IN VARCHAR2)
	IS
		vdate FACTURE.DATE_FACTURE%TYPE;
		vmontant FACTURE.MONTANT_FACTURE%TYPE;
		vdatePaiement FACTURE.DATE_PAIEMENT%TYPE;
		vnumPersonne FACTURE.NUM_PERSONNE%TYPE;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vdate := TO_DATE(pdate, 'DD/MM/YYYY');
			vmontant := TO_NUMBER(pmontant);
			vdatePaiement := TO_DATE(pdatePaiement, 'DD/MM/YYYY');
			vnumPersonne := TO_NUMBER(pnumPersonne);
			
			htp.br;
			pq_db_facture.add_facture(vdate,vmontant,vdatePaiement, vnumPersonne);
			htp.print('<div class="success"> ');
				htp.print('La facture a été ajoutée avec succès.');
			htp.print('</div>');				
			htp.br;
			htp.br;			
			liste_factures;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de facture');
		END;
		
		pq_ui_commun.aff_footer;
	END exec_add_facture;
	
	-- Affiche le formulaire de modification d’une facture existante
	PROCEDURE form_upd_facture(
	  pnumFacture IN VARCHAR2)
	IS
	BEGIN
		pq_ui_commun.aff_header;
		pq_ui_commun.aff_footer;
	END form_upd_facture;
	
	-- Exécute la procédure de mise à jour d'une facture et gère les erreurs éventuelles
	PROCEDURE exec_upd_facture(
	  pnumFacture IN VARCHAR2
	, pdate IN VARCHAR2
	, pmontant IN VARCHAR2)
	IS
	BEGIN
		pq_ui_commun.aff_header;
		pq_ui_commun.aff_footer;
	END exec_upd_facture;
	
	-- Exécute la procédure de suppression d'une facture et gère les erreurs éventuelles
	PROCEDURE exec_del_facture(
	  pnumFacture IN VARCHAR2)
	IS
	BEGIN
		pq_ui_commun.aff_header;
		pq_ui_commun.aff_footer;
	END exec_del_facture;
	  
END pq_ui_facture;
/