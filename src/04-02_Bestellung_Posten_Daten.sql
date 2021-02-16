USE onlineshop;

INSERT INTO Bestellung VALUES
(
    NULL,
    '2018-01-12',
    9
),
(
    NULL,
    '2019-02-01',
    5
),
(
    NULL,
    '2019-02-01',
    11
),
(
    NULL,
    '2019-02-01',
    13
),
(
    NULL,
    '2019-02-12',
    9
),
(
    NULL,
    '2019-02-12',
    13
)
;

INSERT INTO BestellungPosten VALUES
( NULL, 1, 1, 3 ),
( NULL, 1, 4, 1 ),
( NULL, 1, 9, 1 ),

( NULL, 2, 8, 1 ),
( NULL, 2, 10, 2 ),
( NULL, 2, 11, 5 ),
( NULL, 2, 13, 3 ),

( NULL, 3, 5, 12 ),
( NULL, 3, 6, 1 ),
( NULL, 3, 3, 7 ),
( NULL, 3, 4, 1 ),
( NULL, 3, 2, 8 ),

( NULL, 4, 15, 20 ),
( NULL, 4, 16, 1 ),
( NULL, 4, 14, 4 ),

( NULL, 5, 7, 4 ),
( NULL, 5, 12, 20 ),
( NULL, 5, 1, 3 ),

( NULL, 6, 5, 7 ),
( NULL, 6, 8, 3 ),
( NULL, 6, 11, 5 ),
( NULL, 6, 14, 4 )
;


SELECT * FROM BestellungPosten;