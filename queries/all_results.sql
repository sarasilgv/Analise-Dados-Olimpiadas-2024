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


--Quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores (quantidade e tipo)

--############ Total de Medalhas Brasil 2024:

	
select 
	country_code,
	count(medal_type)
from olimpiadas_datas_2024.medals
--where country_code = 'BRA'
group by country_code


--########################## Resultado:


---Medalhas olímpicas anteriores:



select *
	from lastolimpiadas_datas.olympic_medals

select *
from olimpiadas_datas_2024.medals




with medals_lastolimpiadas as (
	select 
		country_name,
		slug_game,
		count(country_name) over(partition by slug_game) as count_medals_lastolimpiadas
	from lastolimpiadas_datas.olympic_medals
	group by 
		country_name,
		slug_game
	order by 
		country_name
),
	
	medals_olimpiadas as (
		select 
			medals.country,
			slug_game,
			count(country) as count_medals_olimpiadas2024
		from olimpiadas_datas_2024.medals
		group by 
			medals.country,
			slug_game
		order by 
			medals.country
	)

select 
	medals_lastolimpiadas.country_name,
	medals_lastolimpiadas.slug_game,
	medals_lastolimpiadas.count_medals_lastolimpiadas,
	medals_olimpiadas.count_medals_olimpiadas2024,
	(medals_lastolimpiadas.count_medals_lastolimpiadas/medals_olimpiadas.count_medals_olimpiadas2024) as "difference (%)"
from medals_lastolimpiadas left join medals_olimpiadas
	on medals_lastolimpiadas.country_name = medals_olimpiadas.country



	
-- Com a Olimpiada de 2024 - França:


select *
from olimpiadas_datas_2024.medals_old_and_2024
order by count_medals_last_olimpiadas desc


--insert into olimpiadas_datas_2024.medals_old_and_2024
--(slug_game, count_medals_last_olimpiadas)

--values
--('french-2024', 20)


---Medalhas olimpíadas 2024:


select
	count(medal_type) count_medals_2024
from olimpiadas_datas_2024.medals
where country_code = 'BRA'
group by 
	medal_date
order by 
	medal_date


---Medalhas olimpíadas 2024 atualizado:

select 
	medal_date,
	sum(count_medals_2024)
from olimpiadas_datas_2024.medals_2024
group by medal_date


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


--Como foi o desempenho do atletas Brasileiros em relação aos dos outros países?


select *
from olimpiadas_datas_2024.athletes


--############### RESULTADO GERAL:


select 
	athletes.code,
	athletes.name,
	athletes.gender,
	athletes.country_long,
	athletes.disciplines,
	athletes.nationality_full,
	athletes.height,
	athletes.weight,
	--medallists.medal_type,
	medallists.birth_date,
	count(medal_type)
from olimpiadas_datas_2024.medallists as medallists 
	left join olimpiadas_datas_2024.athletes as athletes
		on medallists.code_athlete = athletes.code
group by 	
	athletes.code,
	athletes.name,
	athletes.gender,
	athletes.country_long,
	athletes.disciplines,
	athletes.nationality_full,
	athletes.height,
	athletes.weight,
	--medallists.medal_type,
	medallists.birth_date
order by 
	count(medal_type) desc
	

--############### RESULTADO BRASILEIRO:


select 
	athletes.code,
	athletes.name,
	athletes.gender,
	athletes.country_long,
	athletes.disciplines,
	--medallists.medal_type,
	count(medal_type),
	count(medal_type) over(partition by athletes.disciplines) as medals_disc_totals
from olimpiadas_datas_2024.medallists as medallists 
	left join olimpiadas_datas_2024.athletes as athletes
		on medallists.code_athlete = athletes.code
where medallists.country_long = 'Brazil'
group by 	
	athletes.code,
	athletes.name,
	athletes.gender,
	athletes.country_long,
	athletes.disciplines,
	medallists.medal_type
order by 
	count(medal_type) desc
