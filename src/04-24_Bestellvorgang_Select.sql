USE onlineshop;

-- 04-24-01
SELECT Vorname, Nachname, GeburtsDatum
    FROM Kunde
    WHERE Vorname = 'Marcus' AND
          Nachname = 'Barth';

UPDATE Kunde
    SET Vorname = 'Markus'
    WHERE Vorname = 'Marcus' AND
          Nachname = 'Barth' AND
          GeburtsDatum = '1986-08-04';

-- 04-24-02
SELECT Vorname, Nachname, GeburtsDatum
    FROM Kunde
    WHERE   Vorname = 'Sybel' AND
            Nachname = 'Kaleyci';

UPDATE Kunde
    SET GeburtsDatum = '1982-12-01'
    WHERE Vorname = 'Sybel' AND
          Nachname = 'Kaleyci';

-- 04-24-03 A)

SELECT NOW() AS 'Heutiges Datum und Uhrzeit';

-- 04-24-03 B)

SELECT Vorname, Nachname, GeburtsDatum
    FROM Kunde
    WHERE MONTH(NOW()) = MONTH(GeburtsDatum);

-- 04-24-04

UPDATE Kunde
    SET GeburtsDatum = CONCAT('1971-', MONTH(GeburtsDatum), '-', DAY(GeburtsDatum) )
    WHERE Vorname = 'Marianne' AND
          Nachname = 'Schramm';

SELECT Vorname, Nachname, GeburtsDatum
    FROM Kunde
    WHERE Vorname = 'Marianne' AND
          Nachname = 'Schramm';

-- 04-24-05

UPDATE Produkt
    SET Preis = (Preis*1.25);

-- 04-24-06

SELECT Preis INTO @PreisTeekanne
    FROM Produkt
    WHERE Produkt.Bezeichnung = 'Teekanne';

UPDATE @PreisTeekanne
    SET @PreisTeekanne = 61.95;