--Desempenho brasileiro nos esportes que ganharam medalhas

select 
	country_code,
	name,
	discipline,
	case 
		when 
			gender = 'M' then replace ('M','M','Men')
		else replace ('W', 'W', 'Women')
		end as gender_upd,
	count(name) as qty_medals
from olimpiadas_datas_2024.medallists
where country = 'Brazil'
group by name, discipline,country_code,gender_upd
order by count(name) desc
