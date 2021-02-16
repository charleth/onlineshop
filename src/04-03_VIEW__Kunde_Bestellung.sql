USE onlineshop;

DROP VIEW IF EXISTS KundeBestelltProdukt;

CREATE VIEW KundeBestelltProdukt AS
    SELECT  Kunde.Kunde_ID as KID,
            Vorname,
            Nachname,
            GeburtsDatum,
            Kunde.Adresse_ID AS K_Adresse_ID,
            Bestellung.Bestellung_ID AS BID,
            Datum AS BestellDatum,
            Produkt.Produkt_ID as PID,
            Bezeichnung AS ProduktBezeichnung,
            Preis,
            Anzahl
    FROM Kunde, Bestellung, BestellungPosten, Produkt
    WHERE Kunde.Kunde_ID = Bestellung.Kunde_ID AND
          Bestellung.Bestellung_ID = BestellungPosten.Bestellung_ID AND
          BestellungPosten.Produkt_ID = Produkt.Produkt_ID;

SELECT * FROM KundeBestelltProdukt;

SELECT KID,
       Vorname,
       Nachname,
       BID,
       COUNT(*) AS 'Anzahl der bestellten Produkte'
        FROM KundeBestelltProdukt
    GROUP BY BID
    ORDER BY Nachname;


# Umsatz pro Bestellung

DROP VIEW IF EXISTS UmsatzProBestellung;

CREATE VIEW UmsatzProBestellung AS
    SELECT KID,
           Vorname,
           Nachname,
           BID,
           SUM(Preis*Anzahl) AS Umsatz
        FROM KundeBestelltProdukt
    GROUP BY BID
    ORDER BY Nachname;

SELECT * FROM UmsatzProBestellung;

# Gesamtumsatz pro Kunde

SELECT KID,
       Vorname,
       Nachname,
       SUM(Umsatz) AS Gesamtumsatz
        FROM UmsatzProBestellung
    GROUP BY KID;