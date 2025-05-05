CREATE OR REPLACE PROCEDURE modifier_stock_livre(
    p_id_livre IN NUMBER,
    p_nouveau_stock IN NUMBER
) AS
    v_count NUMBER;
    v_titre LIVRES.titre%TYPE;
    v_ancien_stock LIVRES.nb_exemplaires%TYPE;
BEGIN
    
    SELECT COUNT(*), titre, nb_exemplaires
    INTO v_count, v_titre, v_ancien_stock
    FROM LIVRES
    WHERE id_livre = p_id_livre;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Aucun livre trouvé avec l''ID ' || p_id_livre);
    ELSIF p_nouveau_stock < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Le stock ne peut pas être négatif');
    ELSE
        
        UPDATE LIVRES
        SET nb_exemplaires = p_nouveau_stock
        WHERE id_livre = p_id_livre;
        
        COMMIT;
        
        
        DBMS_OUTPUT.PUT_LINE('Stock du livre mis à jour avec succès :');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        DBMS_OUTPUT.PUT_LINE('ID Livre: ' || p_id_livre);
        DBMS_OUTPUT.PUT_LINE('Titre: ' || v_titre);
        DBMS_OUTPUT.PUT_LINE('Ancien stock: ' || v_ancien_stock);
        DBMS_OUTPUT.PUT_LINE('Nouveau stock: ' || p_nouveau_stock);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur lors de la modification du stock : ' || SQLERRM);
END modifier_stock_livre;

/