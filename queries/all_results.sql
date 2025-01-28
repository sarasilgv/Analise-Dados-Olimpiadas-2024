-- 1) Qual foi o desempenho brasileiro nos esportes que ganharam medalhas

select 
	country_code,
	name,
	discipline,
	case 
		when gender = 'M' then 'Men'
        else 'Women'
		end as gender,
	count(name) as qty_medals
from olimpiadas_datas_2024.medallists
where country = 'Brazil'
group by 
	name, 
	discipline,
	country_code,
	gender
order by qty_medals desc


-- 2) Quantidade de medalhas comparada com a quantidade de medalhas olímpicas anteriores?

--########################## Resultado:

--############ Total de Medalhas 2024 - França:

	
select 
	country_code,
	count(medal_type) as qty_medals_2024
from olimpiadas_datas_2024.medals
--where country_code = 'BRA'
group by 
	country_code
order by qty_medals_2024 desc


--############ Total de Medalhas 2020 - Tóquio:

	select
		country_3_letter_code,
		count(medal_type) as qty_medals_2020
	from lastolimpiadas_datas.olympic_medals
	where slug_game like '%2020'
	group by country_3_letter_code
	order by qty_medals_2020 desc


---#########GERAL 2020 vs 2024:


select 
	medals.country_code,
	count(medal_type) as qty_medals_2024,
	medals_2020_toquio.qty_medals_2020 as Medals_Toquio_2020
from olimpiadas_datas_2024.medals left join medals_2020_toquio
	on medals_2020_toquio.country_3_letter_code = medals.country_code
--where country_code = 'BRA'
group by 
	country_code,
	qty_medals_2020
order by qty_medals_2024 desc


--3) Quais modalidades tivemos mais medalhas em 2024?


select 
	discipline,
	count(medal_type) as qty_medal
from olimpiadas_datas_2024.medallists
group by 
	discipline
order by 
	qty_medal desc


--BRAZIL


select 
	country_long,
	country_code,
	discipline,
	count(medal_type) as qty_medal
from olimpiadas_datas_2024.medallists
where country_long = 'Brazil'
group by 
	discipline,
	country_code,
	country_long
order by 
	qty_medal desc


--BRAZIL - ATHLETES:


select 
	medallists.country_long,
	medallists.country_code,
	medallists.discipline,
	upper(athletes.name),
	medallists.medal_type,
	count(medal_type) as qty_medal
from olimpiadas_datas_2024.medallists
	join olimpiadas_datas_2024.athletes on athletes.code = medallists.code_athlete
where medallists.country_long = 'Brazil'
group by 
	medallists.discipline,
	medallists.country_code,
	athletes.name,
	medallists.medal_type,
	medallists.country_long
order by 
	medallists.discipline asc,
	qty_medal desc


--4) Como foi o desempenho dos atletas Brasileiros em relação aos dos outros países?


select *
from olimpiadas_datas_2024.athletes


select *
from olimpiadas_datas_2024.medallists


----DESEMPENHO OUTROS PAÍSES (ATLETAS):


select
	medallists.nationality,
	name,
	(current_date - medallists.birth_date::date)/365 as age,
	--medallists.medal_type,
	count(medallists.name)
from olimpiadas_datas_2024.medallists
--where country_code = 'BRA'
group by 
	medallists.birth_date,
	medallists.nationality,
	--medallists.medal_type,
	name
order by 
	count(medallists.name) desc



----DESEMPENHO DOS OUTROS PAÍSES:

select
	medallists.nationality,
	medallists.discipline,
	--(current_date - medallists.birth_date::date)/365,
	--medallists.medal_type,
	count(medallists.name) as qty_medals
from olimpiadas_datas_2024.medallists
where nationality is not null 
group by 
	medallists.nationality,
	medallists.discipline
order by 
	medallists.nationality,
	qty_medals desc


----DESEMPENHO BRASILEIRO:


select
	medallists.nationality,
	medallists.discipline,
	--(current_date - medallists.birth_date::date)/365,
	--medallists.medal_type,
	count(medallists.name) as qty_medals
from olimpiadas_datas_2024.medallists
where nationality = 'Brazil' 
group by 
	--medallists.birth_date,
	medallists.nationality,
	medallists.discipline
	--medallists.medal_type,
	--name
order by 
	medallists.nationality,
	qty_medals desc


----DESEMPENHO BRASILEIRO (ATLETAS):


select
	name,
	(current_date - medallists.birth_date::date)/365 as age,
	--medallists.medal_type,
	count(medallists.name)
from olimpiadas_datas_2024.medallists
where country_code = 'BRA'
group by 
	medallists.birth_date,
	--medallists.medal_type,
	name
order by 
	age asc,
	count(medallists.name) desc


----#############Quantidade de "Female" nas modalidades (proporção)


		select 
			distinct athletes.disciplines,
			athletes.country,
			--athletes.name,
			--athletes.country,
			count(athletes.name) over (partition by athletes.country ) as sex_per_country,
			count(athletes.name) over (partition by athletes.disciplines ) as sex_per_discilplines
		from olimpiadas_datas_2024.athletes as athletes
		where athletes.country_long != 'Brazil' and athletes.gender = 'Female'
		group by 	
			--athletes.gender,
			athletes.name,

			athletes.disciplines,
			athletes.country
		order by 
			sex_per_discilplines desc

	
	--#############Quantidade de "Male" nas modalidades (proporção)


	select 
		distinct athletes.disciplines,
		--athletes.name,
		athletes.country,
		count(athletes.name) over (partition by athletes.country ) as sex_per_country,	
		count(athletes.name) over (partition by athletes.disciplines) as sex_discilplines
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long != 'Brazil' and athletes.gender = 'Male'
	group by 	
		--athletes.gender,
		athletes.name,
		athletes.country,
		athletes.disciplines
	order by 
		sex_discilplines desc
		
	

--############### RESULTADO BRASILEIRO:


select 
	athletes.code,
	athletes.name,
	athletes.gender,
	athletes.country,
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
	athletes.country,
	athletes.disciplines,
	medallists.medal_type
order by 
	disciplines asc,
	count(medal_type) desc

	
	--#############Quantidade de "Female" nas modalidades (proporção)
	
	
	select 
		distinct athletes.disciplines,
		--athletes.name,
		--athletes.country,
		count(athletes.name) over (partition by athletes.disciplines) as sex_discilplines
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long = 'Brazil' and athletes.gender = 'Female'
	group by 	
		--athletes.gender,
		athletes.name,
		--athletes.country,
		athletes.disciplines
	order by 
		sex_discilplines desc

	
	--#############Quantidade de "Male" nas modalidades (proporção)
	
	
	select 
		distinct athletes.disciplines,
		--athletes.name,
		--athletes.country,
		count(athletes.name) over (partition by athletes.disciplines) as sex_discilplines
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long = 'Brazil' and athletes.gender = 'Male' 
	group by 	
		--athletes.gender,
		athletes.name,
		--athletes.country,
		athletes.disciplines
	order by 
		sex_discilplines desc
