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
    SET Preis = (Preis*1.1);

-- 04-24-06

SELECT Preis INTO @PreisTeekanne
    FROM Produkt
    WHERE Produkt.Bezeichnung = 'Teekanne';


SELECT Preis, Bezeichnung FROM Produkt
    WHERE Produkt.Bezeichnung = 'Teekanne';

UPDATE Produkt
    SET Preis = 61.95
    WHERE Preis = @PreisTeekanne;

-- 04-24-07

SELECT Vorname, Nachname, Kunde.Kunde_ID,
       Bestellung.Bestellung_ID,
       Produkt.Produkt_ID,
       Produkt.Bezeichnung
    FROM Kunde, Produkt, Bestellung
    WHERE Vorname = 'Murat' AND
          Nachname = 'Özel'
    GROUP BY Produkt_ID
    ORDER BY Bestellung_ID ASC;

-- 04-24-08 A)

# Anzahl der Bestellungen der Kunden ausgeben

SELECT Vorname,
       Nachname,
       COUNT(Bestellung_ID) AS 'Anzahl der Bestellungen'
FROM Kunde, Bestellung
WHERE Kunde.Kunde_ID = Bestellung.Kunde_ID
GROUP BY Kunde.Kunde_ID
ORDER BY Kunde.Kunde_ID ASC;

-- 04-24-08 B)

# Gesamt-Umsatz einer Kundin ermitteln

SELECT  Vorname,
        Nachname,
        SUM(Produkt.Preis * BestellungPosten.Anzahl) AS 'Gesamtumsatz'
    FROM Kunde, Bestellung, BestellungPosten, Produkt
        WHERE   Kunde.Kunde_ID = Bestellung.Kunde_ID &&
                Bestellung.Bestellung_ID = BestellungPosten.Bestellung_ID &&
                BestellungPosten.Produkt_ID && Produkt.Produkt_ID
    GROUP BY Kunde.Kunde_ID
    ORDER BY Kunde.Kunde_ID ASC;

-- 04-24-08 C)

SELECT  Vorname,
        Nachname,
        Bestellung.Bestellung_ID,
        Datum AS 'Bestell-Datum',
        SUM(Preis*Anzahl) AS UmsatzProBestellung
    FROM Kunde, Bestellung, BestellungPosten, Produkt
    WHERE   Bestellung.Kunde_ID = Kunde.Kunde_ID AND
            BestellungPosten.Bestellung_ID = Bestellung.Bestellung_ID AND
            BestellungPosten.Produkt_ID = Produkt.Produkt_ID
    GROUP BY Bestellung.Bestellung_ID
    HAVING  UmsatzProBestellung > 1000 AND
            UmsatzProBestellung < 10000
    ORDER BY UmsatzProBestellung DESC;
