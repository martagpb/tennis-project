-- -----------------------------------------------------------------------------
--           Cr�ation du corps du package d'affichage des donn�es
--           pour la table S_INSCRIRE
--                      Oracle Version 10g
--                        (29/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 29/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_s_inscrire
IS 

	PROCEDURE manage_inscriptions(vnumEntrainement IN NUMBER)
	AS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>2,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
                pq_ui_commun.aff_header;
		pq_ui_s_inscrire.dis_inscriptions(vnumEntrainement);
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des inscriptions');
	END manage_inscriptions;
	

	--Permet dafficher les inscriptions d'un entrainement
	PROCEDURE dis_inscriptions(vnumEntrainement IN NUMBER)
	AS
	CURSOR listInscriptions IS
		SELECT
			 PER.NUM_PERSONNE
			,PER.NOM_PERSONNE
			,PER.PRENOM_PERSONNE
		FROM
			PERSONNE PER INNER JOIN S_INSCRIRE INS
				ON PER.NUM_PERSONNE=INS.NUM_PERSONNE
		WHERE
			INS.NUM_ENTRAINEMENT=vnumEntrainement
		ORDER BY 1;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>2,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		htp.br;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Liste des joueurs inscris pour l''entrainement n�' || vnumEntrainement);
		htp.print('</div>');			
		htp.br;	
		htp.br;	
			htp.print(htf.anchor('pq_ui_s_inscrire.form_add_inscription?vnumEntrainement=' || vnumEntrainement,'Inscrire un joueur'));
			htp.br;	
			htp.br;	
				htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('N� joueur');
				htp.tableheader('Nom joueur');
				htp.tableheader('D�sinscrire');
				for currentInscris in listInscriptions loop
					htp.tableRowOpen;
					htp.tabledata(currentInscris.NUM_PERSONNE);
					htp.tabledata(currentInscris.NOM_PERSONNE);	
					htp.tabledata(currentInscris.PRENOM_PERSONNE);	
					htp.tabledata(htf.anchor('pq_ui_s_inscrire.exec_del_inscription?vnumEntrainement=' || vnumEntrainement || '&' || 'vnumPersonne=' || currentInscris.NUM_PERSONNE,'D�sinscrire', cattributes => 'onClick="return confirmerChoixLien()"'));
					htp.tableRowClose;
				end loop;	
				htp.tableClose;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des inscriptions');
	END dis_inscriptions;
	
	
	-- Ex�cute la proc�dure de suppression d'une inscription et g�re les erreurs �ventuelles
	PROCEDURE exec_del_inscription(vnumEntrainement IN NUMBER, vnumPersonne IN NUMBER)
	AS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>2,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		pq_db_s_inscrire.del_inscription(vnumEntrainement,vnumPersonne);
		htp.br;
		htp.print('<div class="success"> ');
				htp.print('Le joueur n� '|| vnumPersonne || ' a �t� d�sinscrit de l''entrainement n�' || vnumEntrainement || ' avec succ�s.');
		htp.print('</div>');		
		htp.br;
		htp.br;			
		pq_ui_s_inscrire.dis_inscriptions(vnumEntrainement);
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'D�sinscription en cours...');
	END exec_del_inscription;
	
	
	-- Affiche le formulaire permettant la saisie dune nouvelle inscription
	PROCEDURE form_add_inscription(vnumEntrainement IN NUMBER)
	AS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		CURSOR listPersonnes IS
		SELECT
			 PER.NUM_PERSONNE
             ,PER.NOM_PERSONNE
		FROM
			 PERSONNE PER
		WHERE
			PER.CODE_NIVEAU = (SELECT ENT.CODE_NIVEAU FROM ENTRAINEMENT ENT WHERE ENT.NUM_ENTRAINEMENT=vnumEntrainement)
		AND
			PER.NUM_PERSONNE NOT IN (SELECT INS.NUM_PERSONNE FROM S_INSCRIRE INS WHERE INS.NUM_ENTRAINEMENT=vnumEntrainement)
		AND PER.STATUT_JOUEUR='A'
		ORDER BY 1;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>2,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		htp.br;		
		htp.print('<div class="titre_niveau_1">');
			htp.print('Liste des joueurs disponibles pour l''entrainement n�' || vnumEntrainement);
		htp.print('</div>');				
		htp.br;	
		htp.br;	
		htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('N� joueur');
				htp.tableheader('Nom joueur');
				htp.tableheader('Inscrire');
				for currentPersonne in listPersonnes loop
					htp.tableRowOpen;
					htp.tabledata(currentPersonne.NUM_PERSONNE);
					htp.tabledata(currentPersonne.NOM_PERSONNE);	
					htp.tabledata(htf.anchor('pq_ui_s_inscrire.exec_add_inscription?vnumEntrainement=' || vnumEntrainement || '&' || 'vnumPersonne=' || currentPersonne.NUM_PERSONNE,'Inscrire', cattributes => 'onClick="return confirmerChoixLien()"'));
					htp.tableRowClose;
				end loop;	
		htp.tableClose;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Inscription en cours...');
	END form_add_inscription;
	
	
-- Ex�cute la proc�dure d'ajout d'une inscription et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_inscription(vnumEntrainement IN NUMBER, vnumPersonne IN NUMBER)
	AS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		pq_db_s_inscrire.add_inscription(vnumEntrainement,vnumPersonne);
		htp.br;
		htp.print('<div class="success"> ');
			htp.print('Le joueur n� '|| vnumPersonne || ' a �t� inscrit de l''entrainement n�' || vnumEntrainement || ' avec succ�s.');
		htp.print('</div>');		
		htp.br;
		htp.br;			
		pq_ui_s_inscrire.dis_inscriptions(vnumEntrainement);
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Inscription en cours...');
	END exec_add_inscription;
	
END pq_ui_s_inscrire;
/ 