select
	medals.country,
	count(medals.medal_type) as qtde
from olimpiadas_datas_2024.medals
group by medals.country
order by qtde desc
