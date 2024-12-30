--Como foi o desempenho do atletas Brasileiros em relação aos dos outros países?


select *
from olimpiadas_datas_2024.athletes


--###############RESULTADO GERAL:


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
	

--###############RESULTADO BRASILEIRO:


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
where medallists.country_long = 'Brazil'
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