INSERT INTO Gyarto (gyartoId, nev, telephely)
VALUES (1, 'Mintagyarto', 'Miskolc');

INSERT INTO Termek (termekId, nev, ar, kategoria, gyartoId, keszlet)
VALUES (10, 'Tej', 450, 'elelmiszer', 1, 120);

UPDATE Termek
SET ar = ar * 1.10
WHERE kategoria = 'elelmiszer';

DELETE FROM Termek
WHERE keszlet = 0;

GRANT SELECT, INSERT ON Termek TO ugyintezo;

REVOKE INSERT ON Termek FROM ugyintezo;
