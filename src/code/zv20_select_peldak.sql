SELECT t.nev, t.ar
FROM Termek t
WHERE t.ar > 1000
ORDER BY t.nev;

SELECT g.nev AS gyartoNev, COUNT(*) AS termekDarab, AVG(t.ar) AS atlagAr
FROM Gyarto g
INNER JOIN Termek t ON t.gyartoId = g.gyartoId
GROUP BY g.gyartoId, g.nev
HAVING COUNT(*) >= 2;

SELECT t.nev, t.ar
FROM Termek t
WHERE t.ar > (
  SELECT AVG(t2.ar)
  FROM Termek t2
);

SELECT g.nev
FROM Gyarto g
WHERE NOT EXISTS (
  SELECT 1
  FROM Termek t
  WHERE t.gyartoId = g.gyartoId
);
