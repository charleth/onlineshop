USE onlineshop;

DROP TABLE IF EXISTS Bestellung;
DROP TABLE IF EXISTS BestellungPosten;

CREATE TABLE Bestellung
(
    Bestellung_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Datum DATE,
    Kunde_ID INTEGER,
        FOREIGN KEY Kunde_ID(Kunde_ID) REFERENCES Kunde(Kunde_ID)
);

CREATE TABLE BestellungPosten
(
    BestellungPosten_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Bestellung_ID INTEGER,
        FOREIGN KEY Bestellung_ID (Bestellung_ID) REFERENCES Bestellung(Bestellung_ID),
    Produkt_ID INTEGER,
        FOREIGN KEY Produkt_ID (Produkt_ID) REFERENCES Produkt(Produkt_ID),
    Anzahl INTEGER
);