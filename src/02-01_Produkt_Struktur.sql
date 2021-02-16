USE onlineshop;

DROP TABLE IF EXISTS Produkt;

CREATE TABLE Produkt (
    Produkt_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    Bezeichnung VARCHAR( 40 ),
    Preis DECIMAL( 9,2 )
);