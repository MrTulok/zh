select ROGZITETTE, SZALLAS_NEV, CIM
from szallashely
WHERE HELY LIKE 'Balaton%' AND MONTH(ROGZ_IDO) = '03'
ORDER BY CSILLAGOK_SZAMA DESC

select szh.TIPUS, ROUND(COUNT(*),-1)
from Foglalas f JOIN Szoba sz ON f.SZOBA_FK = sz.SZOBA_ID
JOIN szallashely szh ON sz.SZALLAS_FK = szh.SZALLAS_ID
GROUP BY szh.TIPUS
HAVING ROUND(COUNT(*),0) < 500

select sz.SZOBA_ID, year(f.METTOL), count(*)
from Foglalas f JOIN Szoba sz ON f.SZOBA_FK = sz.SZOBA_ID
WHERE sz.SZOBA_ID%2 <> 0
GROUP BY sz.SZOBA_ID, YEAR(f.METTOL)
HAVING COUNT(*)>10


