
CREATE OR REPLACE TRIGGER tr_nom_majuscule
BEFORE INSERT OR UPDATE OF nom ON ADHERENTS
FOR EACH ROW
BEGIN
    :NEW.nom := UPPER(:NEW.nom);
END;
/


CREATE OR REPLACE TRIGGER tr_limite_prets
BEFORE INSERT ON PRETS
FOR EACH ROW
DECLARE
    v_nb_prets_en_cours NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_nb_prets_en_cours
    FROM PRETS
    WHERE id_adherent = :NEW.id_adherent AND date_retour IS NULL;
    
    IF v_nb_prets_en_cours >= 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cet adhérent a déjà 3 prêts en cours. Limite atteinte.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erreur lors de la vérification des prêts: ' || SQLERRM);
END;
/

CREATE OR REPLACE TRIGGER tr_date_retour_aut
CREATE OR REPLACE TRIGGER tr_nom_majuscule
BEFORE INSERT OR UPDATE OF nom ON ADHERENTS
FOR EACH ROW
BEGIN
    :NEW.nom := UPPER(:NEW.nom);
END;
/

-- Trigger to limit loans to 3 per member
CREATE OR REPLACE TRIGGER tr_limite_prets
BEFORE INSERT ON PRETS
FOR EACH ROW
DECLARE
    v_nb_prets_en_cours NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_nb_prets_en_cours
    FROM PRETS
    WHERE id_adherent = :NEW.id_adherent AND date_retour IS NULL;
    
    IF v_nb_prets_en_cours >= 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cet adhérent a déjà 3 prêts en cours. Limite atteinte.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erreur lors de la vérification des prêts: ' || SQLERRM);
END;
/


CREATE OR REPLACE TRIGGER tr_date_retour_auto
BEFORE UPDATE OF date_retour ON PRETS
FOR EACH ROW
WHEN (NEW.date_retour IS NULL)
BEGIN
    :NEW.date_retour := SYSDATE;
    DBMS_OUTPUT.PUT_LINE('Date de retour automatiquement définie à la date actuelle.');
END;
/
BEFORE UPDATE OF date_retour ON PRETS
FOR EACH ROW
WHEN (NEW.date_retour IS NULL)
BEGIN
    :NEW.date_retour := SYSDATE;
    DBMS_OUTPUT.PUT_LINE('Date de retour automatiquement définie à la date actuelle.');
END;
/