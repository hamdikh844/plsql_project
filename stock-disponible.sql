SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION stock_disponible(
    p_id_livre IN NUMBER
) RETURN NUMBER
IS
    v_stock_total NUMBER := 0;
    v_prets_en_cours NUMBER := 0;
    v_stock_disponible NUMBER := 0;
    v_livre_existe NUMBER := 0;
BEGIN
    -- Vérifier si le livre existe
    SELECT COUNT(*)
    INTO v_livre_existe
    FROM LIVRES
    WHERE id_livre = p_id_livre;
    
    IF v_livre_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Livre avec ID ' || p_id_livre || ' non trouvé.');
        RETURN -1;
    END IF;
    
    -- Récupérer le stock total
    SELECT NVL(nb_exemplaires, 0)
    INTO v_stock_total
    FROM LIVRES
    WHERE id_livre = p_id_livre;
    
    -- Compter les exemplaires prêtés
    SELECT NVL(COUNT(*), 0)
    INTO v_prets_en_cours
    FROM PRETS
    WHERE id_livre = p_id_livre
    AND date_retour IS NULL;
    
    -- Calculer le stock disponible (minimum 0)
    v_stock_disponible := GREATEST(v_stock_total - v_prets_en_cours, 0);
    
    DBMS_OUTPUT.PUT_LINE('Calcul du stock disponible:');
    DBMS_OUTPUT.PUT_LINE('Stock total: ' || v_stock_total);
    DBMS_OUTPUT.PUT_LINE('Exemplaires prêtés: ' || v_prets_en_cours);
    DBMS_OUTPUT.PUT_LINE('Disponible: ' || v_stock_disponible);
    
    RETURN v_stock_disponible;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
        RETURN -2;
END stock_disponible;
/