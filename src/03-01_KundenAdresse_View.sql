USE onlineshop;

# impliziter join

SELECT * FROM Kunde, Adresse;

# inner join

SELECT * FROM Kunde
    INNER JOIN Adresse
    ON Kunde.Adresse_ID = Adresse.Adresse_ID;

/* Datensätze mit gleichen Merkmalenkönnen mit GROUP gruppiert werden.
Auf die Gruppen lassen sich Aggregat-Funktionen anwenden.
   Datensätze mit gleichen Merkmalen treten mit höherer Wahrscheinlichkeit
   bei verknüpften Tabellen-Abfragen auf
 */

 SELECT Strasse, Postleitzahl, COUNT(Kunde_ID) AS AnzahlKunden FROM Kunde, Adresse
    WHERE Kunde.Adresse_ID = Adresse.Adresse_ID
    GROUP BY Postleitzahl, Strasse
    ORDER BY Strasse;

/*
 Syntax für SELECT-Abfrage: vorgegebene Reihenfolge!
 SELECT Strasse, count(*) from Kunde, Adresse
 opt: JOIN-Klausel (statt Liste der verknüpften Tabellen)
 WHERE Kunde.Adresse_ID = Adresse.Adresse_ID
 GROUP BY Strasse
    HAVING-Klausel
 ORDER BY Strasse
  LIMIT;
 */



/* SELECT-Abfragen vereinfachen, indem man wichtige Abfragen als VIEW speichert.
Das speichert nur die Abfrage, nicht das Ergebnis.
   Die Selektion der Abbfrage wird bei jedem Aufruf der VIEW neu erstellt.
 */

DROP VIEW IF EXISTS KundenAdresse;

CREATE VIEW KundenAdresse AS
    SELECT  Kunde_ID,
            Vorname,
            Nachname,
            GeburtsDatum,
            Kunde.Adresse_ID AS K_Adresse,
            Strasse,
            Hausnummer,
            Postleitzahl,
            Stadt,
            Land
    FROM Kunde, Adresse
        WHERE Kunde.Adresse_ID = Adresse.Adresse_ID;

/* Views können weiter modifiziert werden - als ob sie eine eigene Tabelle wären
 */

 SELECT Postleitzahl, COUNT(Kunde_ID) FROM KundenAdresse
    GROUP BY Postleitzahl;