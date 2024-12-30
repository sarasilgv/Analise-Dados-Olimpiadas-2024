--Quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores (quantidade e tipo)

--############ Total de Medalhas Brasil 2024:

	
select 
	country_code,
	count(medal_type)
from olimpiadas_datas_2024.medals
where country_code = 'BRA'
group by country_code


--########################## Resultado:


---Medalhas Brasileiras olimpíadas anteriores:

select
	distinct(slug_game),
	count(medal_type) over(partition by slug_game) as count_medals_last_olimpiadas
from lastolimpiadas_datas.olympic_medals
where country_3_letter_code = 'BRA'
order by 
	slug_game,
	count_medals_last_olimpiadas


-- Medalhas Brasileiras na Olimpíada de 2024 - França:

select *
from olimpiadas_datas_2024.medals_old_and_2024
order by count_medals_last_olimpiadas desc



--insert into olimpiadas_datas_2024.medals_old_and_2024
--(slug_game, count_medals_last_olimpiadas)

--values
--('french-2024', 20)


---Medalhas Brasileiras nas Olimpíadas 2024 atualizado:

select 
	medal_date,
	sum(count_medals_2024)
from olimpiadas_datas_2024.medals_2024
group by medal_date
