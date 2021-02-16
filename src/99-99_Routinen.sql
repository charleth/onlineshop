/* Prozeduren, Routinen und Trigger */

USE onlineshop;

SET @jetzt = NOW();

SELECT @jetzt;

SELECT ROUND(3.2342342342343, 2);
--

DROP PROCEDURE IF EXISTS AdresseAnlegen;

DELIMITER $$

CREATE PROCEDURE AdresseAnlegen (   IN Strasse_ Varchar(40),
                                    IN Hausnummer_ VARCHAR(6),
                                    IN Postleitzahl_ VARCHAR(8),
                                    IN Stadt_ VARCHAR(40),
                                    IN Land_ VARCHAR(40),
                                    OUT Adresse_ID_ INTEGER
)
BEGIN
    SET Adresse_ID_ = NULL;
    SELECT  Adresse_ID INTO Adresse_ID_ FROM Adresse
    WHERE   Strasse = Strasse_ AND
            Hausnummer = Hausnummer_ AND
            Postleitzahl = Postleitzahl_ AND
            Stadt = Stadt_ AND
            Land = Land_;
    IF Adresse_ID_ IS NULL THEN
        INSERT INTO Adresse VALUES
            (NULL,
                Strasse_,
                Hausnummer_,
                Postleitzahl_,
                Stadt_,
                Land_);
        SET Adresse_ID_ = last_insert_ID ();
        END IF;
END $$

DELIMITER ;

CALL AdresseAnlegen(
        'Karl-Marx-Allee',
        '1458',
        '272',
        'Berlin',
        'Deutschland',
        @Neue_Adresse_ID);

SELECT * FROM Adresse;

/* KundeAnlegen */

DROP PROCEDURE IF EXISTS KundeAnlegen;

DELIMITER $$

CREATE PROCEDURE KundeAnlegen(  IN Vorname_ VARCHAR(40),
                                IN Nachname_ VARCHAR(40),
                                IN GeburtsDatum_ DATE,
                                IN Adresse_ID_ INTEGER,
                                OUT neue_Kunde_ID INTEGER
)