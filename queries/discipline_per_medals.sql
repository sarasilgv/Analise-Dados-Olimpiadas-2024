
--Quais modalidades tivemos mais medalhas em 2024?

select 
	discipline,
	country_long,
	country_code,
	--medal_type,
	count(medal_type) as qty_medal
from olimpiadas_datas_2024.medallists
--where country_code
group by 
	discipline,
	country_code,
	country_long
	--medal_type
order by 
	discipline,
	qty_medal desc

--BRAZIL:

select 
	discipline,
	country_long,
	country_code,
	--medal_type,
	count(medal_type) as qty_medal
from olimpiadas_datas_2024.medallists
where country_long = 'Brazil'
group by 
	discipline,
	country_code,
	country_long
	--medal_type
order by 
	discipline,
	qty_medal desc