select
	medals.country,
	count(medals.medal_type) as qtde
from olimpiadas_datas.medals
group by medals.country
order by qtde desc
