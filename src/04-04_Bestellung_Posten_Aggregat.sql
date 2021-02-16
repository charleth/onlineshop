USE onlineshop;

/*
 Die Aggregat-Funktionen
 + min()    :   Minimaler Wert eines Zahlentypen ( inkl. Zeittypen ) in einer Datensammlung
 + max()    :   Maximaler Wert eines Zahlentypen ( inkl. Zeittypen ) in einer Datensammlung
 + avg()    :   Durchschnittlicher Wert eines Zahlentypen in einer Datensammlung
 + sum()    :   Die Summe eines Zahlentypen in einer Datensammlung
 + count()  :   Die Anzahl von Datensätzen, die ein bestimmtes Kriterium erfüllen.

 */

SELECT * FROM KundeBestelltProdukt;

# Durchschnitts-Preis einer Bestellung

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        ROUND(AVG(Preis),2) AS 'Durchschnittspreis der Bestellung'
            FROM KundeBestelltProdukt
    GROUP BY BID;

# Das teuerste Produkt einer Bestellung

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        MAX(Preis) AS 'Teuerster Preis der Bestellung'
            FROM KundeBestelltProdukt
    GROUP BY BID;

# Günstigstes Produkt einer Bestellung

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        MIN(Preis) AS 'Günstigster Preis der Bestellung'
            FROM KundeBestelltProdukt
    GROUP BY BID;

# Durchschnittspreis einer Bestellung
# Preis ist NICHT Umsatz

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        ROUND(AVG(Preis),2),
        ROUND(AVG(Preis*Anzahl),2)
            FROM KundeBestelltProdukt
    GROUP BY BID;

# Minimal-Einzelumsatz einer Bestellung

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        MIN(Preis*Anzahl)
    FROM KundeBestelltProdukt
    GROUP BY BID;

# Maximal-Einzelumsatz einer Bestellung

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        MAX(Preis*Anzahl)
    FROM KundeBestelltProdukt
    GROUP BY BID;

# Anzahl der Adress-Datensätze mit demselben Straßennamen in einem PLZ-Gebiet

SELECT COUNT(*), Strasse, Postleitzahl
    FROM Adresse
    GROUP BY Postleitzahl, Strasse
    ORDER BY Strasse;

# Anzahl von Kunden, die in einer bestimmten Straße wohnen

SELECT  COUNT(*),
        Strasse,
        Postleitzahl
    FROM Adresse, Kunde
    WHERE Kunde.Adresse_ID = Adresse.Adresse_ID
    GROUP BY Postleitzahl, Strasse
    ORDER BY Strasse;

# Die Bestellungen herausfinden, die einen Gesamtumsatz von mehr als 20€ haben

SELECT  Vorname,
        Nachname,
        BID,
        BestellDatum,
        SUM(Preis*Anzahl) AS 'GesamtUmsatz pro Bestellung > 20€'
    FROM KundeBestelltProdukt
    GROUP BY BID
    HAVING SUM(Preis*Anzahl) > 20;

# Die Adressen herausfinden, in denen mehr als 2 Kund:innen wohnen

SELECT  COUNT(*),
        Strasse,
        Postleitzahl
    FROM Kunde, Adresse
    WHERE Kunde.Adresse_ID = Adresse.Adresse_ID
    GROUP BY Strasse, Postleitzahl
    HAVING COUNT(*) > 2;

# Das Geburtsdatum der jüngsten Kundin

SELECT MAX(GeburtsDatum) INTO @maxGeburtsdatum from Kunde;

SELECT @maxGeburtsdatum;

# Die jüngste Kundin und ihre Adresse

SELECT * FROM Kunde, Adresse
    WHERE Kunde.Adresse_ID = Adresse.Adresse_ID AND
          GeburtsDatum = @maxGeburtsdatum;


# Subquery: Kunden mit Maximalumsatz ermitteln
# VIEW = gespeicherte SELECT-Abfrage die einfach namentlich aufgerufen wird
# subquery = verschachtelte, ausformulierte SELECT-Abfrage

SELECT  Vorname,
        Nachname,
        MAX(GesamtSumme) INTO @maxUmsatz
    FROM(
        SELECT
            Vorname,
            Nachname,
            SUM(Preis*Anzahl) AS GesamtSumme
        FROM KundeBestelltProdukt
        GROUP BY KID
            ) U;

SELECT BID, Vorname, Nachname, SUM(Umsatz) FROM UmsatzProBestellung
    GROUP BY BID
    HAVING SUM(Umsatz) = @maxUmsatz;