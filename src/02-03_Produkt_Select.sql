USE onlineshop;

SELECT '02-03_Produkt_Select.sql' AS o;

# Alle Datensätze der Tabelle Produkt

SELECT * FROM Produkt;


# Alle Produkte, die teurer sind als 10,00 €
# Bezeichnung, Preis -- sortiert nach Preis, aufsteigend

SELECT Bezeichnung, Preis
    FROM Produkt
    WHERE Preis > 10
    ORDER BY Preis ASC;

# Das Produkt mit der Bezeichnung 'Klavierhocker'

SELECT Bezeichnung, Preis
    FROM Produkt
    WHERE Bezeichnung = 'Klavierhocker';

# Alle Produkte, die ein 'Tee' in der Bezeichnung haben

SELECT Bezeichnung, Preis
    FROM Produkt
    WHERE Bezeichnung LIKE '%Tee%'
    ORDER BY Bezeichnung ASC;

# Das teuerste Produkt - simpel (und nicht akkurat)

SELECT Bezeichnung, Preis
    FROM Produkt
    ORDER BY Preis DESC
    LIMIT 1;

# Das teuerste Produkt - mit Aggregat

SELECT MAX(Preis) INTO @maxPreis FROM Produkt;
SELECT ROUND(@maxPreis, 2) AS 'Höchster Preis', Bezeichnung FROM Produkt
    WHERE Preis = @maxPreis;

# Das günstigste Produkt - simpel (und nicht akkurat)

SELECT Bezeichnung, Preis
    FROM Produkt
    ORDER BY Preis ASC
    LIMIT 1;

# Das günstigste Produkt - mit Aggregat

SELECT MIN(Preis) INTO @minPreis FROM Produkt;
SELECT ROUND(@minPreis, 2) AS 'Kleinster Preis', Bezeichnung FROM Produkt
    WHERE Preis =@minPreis;

# Durchschnitts-Preis aller angebotenen Produkte

SELECT ROUND(AVG(Preis),2) AS 'Durchschnitts-Preis' FROM Produkt;

# Anzahl Zeilen in einer Tabellen-Ausgabe limitieren um zu 'blättern'

# Teuerste Produkte 1-5

SELECT Bezeichnung, Preis
    FROM Produkt
    ORDER BY Preis DESC
    LIMIT 5
;

# Teuerste Produkte 6-10

SELECT Bezeichnung, Preis
    FROM Produkt
    ORDER BY Preis DESC
    LIMIT 5 OFFSET 5
;

# Teuerste Produkte 11-15

SELECT Bezeichnung, Preis
    FROM Produkt
    ORDER BY Preis DESC
    LIMIT 5 OFFSET 10
;

# Teuerste Produkte 16-21

SELECT Bezeichnung, Preis
    FROM Produkt
    ORDER BY Preis DESC
    LIMIT 5 OFFSET 15
;