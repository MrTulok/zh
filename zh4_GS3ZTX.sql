1.feladat

select v.NEV,v.EMAIL,v.USERNEV
from Foglalas f join vendeg v on f.UGYFEL_FK = v.USERNEV
where month(v.SZUL_DAT) != 5
group by v.NEV, v.EMAIL,v.USERNEV
having COUNT(*) > 1

2.feladat

select v.*
from Foglalas f join Szoba sz on f.SZOBA_FK = sz.SZOBA_ID
    join Vendeg v ON f.UGYFEL_FK = v.USERNEV
where sz.FEROHELY =
(
    select max(FEROHELY)
    from Szoba
)

3.feladat

select v.USERNEV,
    v.NEV,
    COUNT(*) as 'darab',
    RANK() over(order by count(*) desc) as 'Sorszám'
from Vendeg v join Foglalas f on v.USERNEV = f.UGYFEL_FK
group by v.usernev,v.nev

4.feladat

SELECT IIF(GROUPING_ID(szh.SZALLAS_NEV) = 1, 'Végösszeg', CAST(szh.SZALLAS_NEV AS NVARCHAR(50))) AS 'Hotelnév',
    CASE GROUPING_ID(szh.SZALLAS_NEV, sz.POTAGY)
        WHEN 0 THEN CAST(sz.POTAGY AS NVARCHAR(10))
        WHEN 1 THEN 'Részösszeg'
        WHEN 3 THEN 'Végösszeg'
    END as 'Pótágyszám',
    SUM(f.FELNOTT_SZAM + f.GYERMEK_SZAM) AS 'Darab'
FROM szallashely szh
    JOIN Szoba sz ON szh.SZALLAS_ID = sz.SZALLAS_FK
    JOIN Foglalas f ON f.SZOBA_FK = sz.SZOBA_ID
GROUP BY ROLLUP(szh.SZALLAS_NEV, sz.POTAGY)

5.feladat

CREATE TABLE #MASKED_GUEST(
	[USERNEV] [nvarchar](20) NOT NULL,
	[NEV] [nvarchar](50) masked with (function = 'partial(2,"XXX",3)'),
	[EMAIL] [nvarchar](60) NOT NULL,
	[SZAML_CIM] [nvarchar](100) NULL,
	[SZUL_DAT] [date] NULL,
 CONSTRAINT [PK_Vendeg] PRIMARY KEY CLUSTERED
) ON [PRIMARY]