SELECT nev, ar
FROM Termek
WHERE kategoria = 'elelmiszer';

SELECT DISTINCT g.nev
FROM Gyarto g
INNER JOIN Termek t ON t.gyartoId = g.gyartoId
WHERE t.kategoria = 'elelmiszer';

SELECT gyartoId
FROM Gyarto g
WHERE NOT EXISTS (
  SELECT kategoria
  FROM KeresettKategoria kk
  WHERE NOT EXISTS (
    SELECT 1
    FROM Termek t
    WHERE t.gyartoId = g.gyartoId
      AND t.kategoria = kk.kategoria
  )
);
