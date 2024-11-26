--Desempenho brasileiro nos esportes que ganharam medalhas ou quase ganharam
select 
	name,
	discipline,
	country_code,
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


--Esportes que temos representantes mas precisamos melhorar o desempenho


--Quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores (qtde e tipo)

with brazil_2020 as (
	select 
		discipline_title,
		slug_game,
		event_title,
		event_gender,
		medal_type,
		participant_type,
		athlete_full_name,
		country_name
	from lastolimpiadas_datas.olympic_medals
	where slug_game like '%2020'
		and country_name = 'Brazil'
		order by country_name
)


--Quais modalidades tivemos mais medalhas?

--Como foi o desempenho do Brasil em relação aos países da América no Sul?