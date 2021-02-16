USE onlineshop;


# Geburtstage ausgeben

SELECT Vorname,
       Nachname,
       YEAR(GeburtsDatum) AS 'GeburtsJahr',
       MONTH(GeburtsDatum) AS 'GeburtsMonat',
       DAY(GeburtsDatum) AS 'Geburtstag'
    FROM Kunde
    ORDER BY GeburtsDatum
;

# Heutiges Datum und Uhrzeit

SELECT NOW() AS 'Heutiges Datum und Uhrzeit';

SELECT DATE(NOW()) AS 'Heutiges Datum',
       TIME(NOW()) AS 'Jetzige Uhrzeit';

# Alle Kunden, die nach dem 06.10.1984 geboren wurden

SELECT * FROM Kunde
    WHERE GeburtsDatum > '1984-10-06';

# Alle Kunden, die nachdem Jahr 1990 geboren wurden

SELECT * FROM Kunde
    WHERE YEAR(GeburtsDatum) > 1990
    ORDER BY GeburtsDatum;

# Anzahl der Tage seit dem 21.03.2010

SELECT DATEDIFF(NOW(), '2010-03-21');

# Zeit seit dem 21.03.2010

SELECT FROM_DAYS(DATEDIFF(NOW(), '2010-03-21'));

# Ein Datum (inkl. Uhrzeit) vor/nach einer bestimmten Zeitspanne ermitteln

SELECT NOW() - INTERVAL 18 YEAR;

# Das Gleiche, nur mit Datum

SELECT DATE(NOW() - INTERVAL 18 YEAR);

# Alle Kunden, die mindestens 18 Jahre alt sind:

SELECT Vorname, Nachname FROM Kunde
    WHERE GeburtsDatum <= DATE(NOW() - INTERVAL 18 YEAR)
    ORDER BY GeburtsDatum;

# Das Alter der Kunden ausgeben

SELECT Vorname, Nachname, GeburtsDatum,
    YEAR (FROM_DAYS(DATEDIFF(NOW(), GEBURTSDATUM))) AS 'Alter'
    FROM Kunde
    ORDER BY GeburtsDatum;