set SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE modifier_adherent(
    p_id IN NUMBER,
    p_nouveau_nom IN VARCHAR2,
    p_nouveau_prenom IN VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    
    SELECT COUNT(*)
    INTO v_count
    FROM ADHERENTS
    WHERE id_adherent = p_id;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Aucun adhérent trouvé avec l''ID ' || p_id);
    ELSE
        
        UPDATE ADHERENTS
        SET nom = UPPER(p_nouveau_nom),
            prenom = p_nouveau_prenom
        WHERE id_adherent = p_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Adhérent ID ' || p_id || ' modifié avec succès.');
        DBMS_OUTPUT.PUT_LINE('Nouveau nom : ' || UPPER(p_nouveau_nom));
        DBMS_OUTPUT.PUT_LINE('Nouveau prénom : ' || p_nouveau_prenom);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur lors de la modification de l''adhérent : ' || SQLERRM);
END modifier_adherent;
/