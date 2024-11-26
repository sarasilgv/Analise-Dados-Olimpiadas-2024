select 
	discipline,
	upper(name),
	count(country) as count_medal
from olimpiadas_datas.medallists
where country like 'Bra%'
group by discipline, name
order by discipline