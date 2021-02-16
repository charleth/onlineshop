use onlineshop;

# Alle Datensätze aller Spalten der Tabelle 'Kunde' anzeigen

select * from Kunde;

# Alle Datensätze in den Spalten Vorname und Nachname der Tabelle 'Kunde' anzeigen

select Vorname, Nachname from Kunde;

# verknüpfte Datensätze der Tabellen Kunde und Adresse

select
       CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) as Kunde,
       CONCAT(Adresse.Strasse, ' ', Adresse.Hausnummer, ', ', Adresse.Postleitzahl, ' ', Adresse.Stadt) as Adresse
    from Kunde, Adresse
    where Kunde.Adresse_ID = Adresse.Adresse_ID;

# Alle Spalten der Tabelle Kunde anzeigen und nach
# Geburtsdatum absteigend sortieren

select * from Kunde
    order by GeburtsDatum DESC;

# Alle Spalten der Tabelle Kunde anzeigen und nach
# Geburtsdatum aufsteigend sortieren

select * from Kunde
    order by GeburtsDatum ASC;

# Alle Einträge in 'Kunde' zeigen und alpha-numerisch
# aufsteigend nach Nachnamen sortieren

select * from Kunde
    order by Nachname ASC;

# Alle Datensätze der Tabelle 'Kunde' eintragen, die nach dem 01.01.1970 geboren wurden

select * from Kunde
    where GeburtsDatum > '1970-01-01'
    order by GeburtsDatum ASC;

# Alle Kunden selektieren, die Müller heißen UND nach dem 01.01.1958 geboren wurden

select * from Kunde
    where   GeburtsDatum > '1985-01-01' AND
            Nachname = 'Müller';

# Alle Kunden mit den Nachnamen 'Müller, 'Özel' oder 'Rodriguez' anzeigen

select * from Kunde
    where Nachname = 'Müller' OR
          Nachname = 'Özel' OR
          Nachname = 'Rodriguez'
    order by Nachname ASC;

# Alle Nachnamen nur einmal auflisten:

SELECT DISTINCT Nachname FROM Kunde
    ORDER BY Nachname ASC;

/*
 Die Aggregat-Funktionen
 + min()    :   Minimaler Wert eines Zahlentypen ( inkl. Zeittypen ) in einer Datensammlung
 + max()    :   Maximaler Wert eines Zahlentypen ( inkl. Zeittypen ) in einer Datensammlung
 + avg()    :   Durchschnittlicher Wert eines Zahlentypen in einer Datensammlung
 + sum()    :   Die Summe eines Zahlentypen in einer Datensammlung
 + count()  :   Die Anzahl von Datensätzen, die ein bestimmtes Kriterium erfüllen.

 */

# Anzahl der identischen Nachnamen zählen

SELECT Nachname, COUNT (*) AS Anzahl
    FROM Kunde
    GROUP BY Nachname;

# Anzahl aller Datensätze in der Tabelle 'Kunde' zurückgeben

SELECT COUNT(*) FROM Kunde;