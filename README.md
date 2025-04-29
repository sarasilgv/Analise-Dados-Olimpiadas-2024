# Análise das Olimpíadas na França em 2024

Este projeto possui como objetivo analisar os dados obtidos dos jogos olímpicos que aconteceram na França.


## 🛣️ Contexto:

Com essa base de dados possui vários detalhes sobre os jogos, atletas, medalhas, entre outros. O comitê Olímpico solicitou um overview a respeito das olimpíadas mas, tendo um foco na equipe Brasileira.

### Descrição das Tabelas 

| TABELAS               | DESCRIÇÃO                                      |
|-----------------------| -----------------------------------------------|
|athletes.csv           | Informações pessoais sobre todos os atletas    |
|coaches.csv            | Informações pessoais sobre todos os treinadores|
|events.csv             | Todos os eventos que tiveram um lugar          |
|medals.csv             | Todos os medalhistas                           |
|medals_total.csv       | Todas as medalhas (agrupadas por país)         |
|medalists.csv          | Medalhistas                                    |
|nocs.csv               | Comitês Olímpicos (código, país)               |
|schedule.csv           | Agenda dos eventos dia a dia                   |
|schedule_preliminary.csv|Agendas preliminares dos eventos               |
|teams.csv              | Todos as equipes                               |
|technical_officials.csv| Técnicos oficiais (juízes, membros do juri)    |
|torch_route..csv       | Rotas da tocha olímpica                         |
|venues.csv             | Locais de competição                            |
|results	        	| Pasta que contem as tabelas com os resultados de todos os eventos|



## 🚩 Desafios:

- Qual foi o desempenho brasileiro nos esportes que ganharam medalhas?

- Qual foi a quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores? (França 2024 vs Tóquio 2020)

- Quais modalidades tivemos mais medalhas em 2024?

- Como foi o desempenho dos atletas Brasileiros em relação aos dos outros países?

- Quais são as modalidades que possuem maior presença Feminina e Masculina?


## 📊 Soluções: (Para consultar os resultados acessar a pasta results)


### 1. Qual foi o desempenho brasileiro nos esportes que ganharam medalhas? 

#### Resultado_01.xlsx


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
    order by
        qty_medals desc


### 2. Qual foi a quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores? (França 2024 vs Tóquio 2020)

#### Resultado_02.xlsx

	select 
		medals.country_code as country,
		count(medal_type) as qty_medals_2024,
		medals_2020_toquio.qty_medals_2020 as qty_medals_2020
	from olimpiadas_datas_2024.medals left join medals_2020_toquio
		on medals_2020_toquio.country_3_letter_code = medals.country_code
	group by 
		country_code,
		qty_medals_2020
	order by qty_medals_2024 desc



### 3. Quais modalidades tivemos mais medalhas em 2024?

#### Resultado_03_geral.xlsx

	select 
		discipline as modality,
		count(medal_type) as qty_medals_2024
	from olimpiadas_datas_2024.medallists
	group by 
		discipline
	order by 
		qty_medals_2024 desc


#### Resultado_03_Brasil.xlsx


	select 
		country_long as country_name,
		country_code as country,
		discipline as modality,
		count(medal_type) as qty_medals_2024
	from olimpiadas_datas_2024.medallists
	where country_long = 'Brazil'
	group by 
		discipline,
		country_code,
		country_long
	order by 
		qty_medals_2024 desc


#### Resultado_03_Brasil_atletas.xlsx


	select 
		medallists.country_long as country_name,
		medallists.country_code as country,
		medallists.discipline as modality,
		upper(athletes.name) as name,
		medallists.medal_type,
		count(medal_type) as qty_medals
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
		qty_medals desc



### 4. Como foi o desempenho dos atletas Brasileiros em relação aos dos outros países?

#### Results_04_Brasil_atletas.xlsx

	select
		name,
		medallists.nationality,
		medallists.discipline as modality,
		(current_date - medallists.birth_date::date)/365 as age,
		count(medallists.name) as qty_medals
	from olimpiadas_datas_2024.medallists
	where country_code = 'BRA'
	--where nationality is not null 
	group by 
		medallists.birth_date,
		medallists.nationality,
		medallists.discipline,
		name
	order by 
		nationality,
		modality,
		age,
		count(medallists.name) desc


### 5. Quais são as modalidades que possuem maior presença Feminina e Masculina?

#### MULHERES - Resultado_05_modalidades_mulheres

	select 
		distinct athletes.disciplines as modality,
		athletes.country as nationality,
		count(athletes.name) over (partition by athletes.country, athletes.disciplines) as qty_womens
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long != 'Brazil' and athletes.gender = 'Female' and athletes.country is not null
	group by 	
		athletes.name,
		athletes.disciplines,
		athletes.country
	order by 
		qty_womens desc,
		nationality asc


#### HOMENS - Resultado_05_modalidades_homens


	select 
		distinct athletes.disciplines as modality,
		athletes.country as nationality,
		count(athletes.name) over (partition by athletes.country, athletes.disciplines) as qty_mens
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long != 'Brazil' and athletes.gender = 'Male' and athletes.country is not null
	group by 	
		athletes.name,
		athletes.disciplines,
		athletes.country
	order by 
		qty_mens desc,
		nationality asc


#### MULHERES (Brazil) - Resultado_05_modalidades_mulheres_Brasil
	
	
	select 
		distinct athletes.disciplines as modality,
		count(athletes.name) over (partition by athletes.disciplines) as qty_womens
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long = 'Brazil' and athletes.gender = 'Female'
	group by 	
		athletes.name,
		athletes.disciplines
	order by 
		qty_womens desc


#### HOMENS (Brazil) - Resultado_05_modalidades_homens_Brasil
	
	
	select 
		distinct athletes.disciplines as modality,
		count(athletes.name) over (partition by athletes.disciplines) as qty_mens
	from olimpiadas_datas_2024.athletes as athletes
	where athletes.country_long = 'Brazil' and athletes.gender = 'Male' 
	group by 	
		athletes.name,
		athletes.disciplines
	order by 
		qty_mens desc


## 🔎 Resultado das Análises:

- A análise revelou que o Brasil teve um desempenho superior em 2024, conquistando mais medalhas do que em Tóquio 2020.

- A atleta  Rebeca Andrade consquistou 4 medalahas na modalidade Ginástica Artistica, sendo 2 de Prata, 1 de ouro e 1 de Bronze.

- As modalidades em que os Brasileiros se destacaram foram o Futebol e Judo, enquanto os demais países foram	231 no Atletismo
e 219 na Natação.

- Houve equilíbrio entre a presença feminina e masculina em diversas modalidades, evidenciando maior diversidade.


## 🚀 Tecnologias Utilizadas:

SQL e Excel para consultas e análises.


#### Conecte-se comigo

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sara-galv%C3%A3o-601776204/)
