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
|results	        | Pasta que contem tabelas com resultados dos eventos por modalidade|
|torch_route..csv       | Rotas da tocha olímpica                         |
|venues.csv             | Locais de competição                            |



## 🚩 Desafios:

- Qual foi o desempenho brasileiro nos esportes que ganharam medalhas?

- Qual foi a quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores? (França 2024 vs Tóquio 2020)

- Quais modalidades tivemos mais medalhas em 2024?

- Como foi o desempenho dos atletas Brasileiros em relação aos dos outros países?

- Quais são as modalidades que possuem maior presença Feminina e Masculina?


## 📊 Soluções:


1. Qual foi o desempenho brasileiro nos esportes que ganharam medalhas?


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

country_code	name	discipline	gender	qty_medals
BRA	ANDRADE Rebeca	Artistic Gymnastics	Women	4
BRA	PIMENTA Larissa	Judo	Women	2
BRA	SOUZA Beatriz	Judo	Women	2
BRA	LIMA Willian	Judo	Women	2
BRA	TAINA	Football	Women	1
BRA	SCHIMIDT Guilherme	Judo	Women	1
BRA	MACEDO Rafael	Judo	Women	1
BRA	BONFIM Caio	Athletics	Women	1
BRA	MEDINA Gabriel	Surfing	Women	1
BRA	YASMIM	Football	Women	1
BRA	CARGNIN Daniel	Judo	Women	1
BRA	AKIO Augusto	Skateboarding	Women	1
BRA	WESTON-WEBB Tatiana	Surfing	Women	1
BRA	LUCIANA	Football	Women	1
BRA	VITORIA YAYA	Football	Women	1
BRA	DAHER de MENEZES Thaisa	Volleyball	Women	1
BRA	BARBOSA Jade	Artistic Gymnastics	Women	1
BRA	ANA VITORIA	Football	Women	1
BRA	LEAL Rayssa	Skateboarding	Women	1
BRA	GONCALVES Leonardo	Judo	Women	1
BRA	RAFAELLE	Football	Women	1
BRA	SILVA RAMOS Ana Patricia	Beach Volleyball	Women	1
BRA	DUARTE ALECRIM Diana	Volleyball	Women	1
BRA	THAIS	Football	Women	1
BRA	SANTOS LISBOA Eduarda	Beach Volleyball	Women	1
BRA	MARTA	Football	Women	1
BRA	DUDA SAMPAIO	Football	Women	1
BRA	ANTONIA	Football	Women	1
BRA	SOARES FERREIRA Beatriz Iasmin	Boxing	Women	1
BRA	da SILVA Ana Carolina	Volleyball	Women	1
BRA	RATZKE Roberta Silva	Volleyball	Women	1
BRA	QUADROS Ketleyn	Judo	Women	1
BRA	OLIVEIRA Lorrane	Artistic Gymnastics	Women	1
BRA	KEROLIN	Football	Women	1
BRA	LUDMILA	Football	Women	1
BRA	BRAGA GUIMARAES Gabriela	Volleyball	Women	1
BRA	MENEZES OLIVEIRA de SOUZA Ana Cris	Volleyball	Women	1
BRA	SARAIVA Flavia	Artistic Gymnastics	Women	1
BRA	ALEXANDRE COSTA NUNES Nyeme Victor	Volleyball	Women	1
BRA	QUEIROZ Isaquias	Canoe Sprint	Women	1
BRA	ANGELINA	Football	Women	1
BRA	GABI PORTILHO	Football	Women	1
BRA	SILVA Rafael	Judo	Women	1
BRA	PONTES Edival	Taekwondo	Women	1
BRA	PRISCILA	Football	Women	1
BRA	SOARES Julia	Artistic Gymnastics	Women	1
BRA	dos SANTOS Alison	Athletics	Women	1
BRA	ARAUJO Natalia	Volleyball	Women	1
BRA	JHENIFFER	Football	Women	1
BRA	ADRIANA	Football	Women	1
BRA	LORENA	Football	Women	1
BRA	GABI NUNES	Football	Women	1
BRA	TARCIANE	Football	Women	1
BRA	MONTIBELLER Rosamaria	Volleyball	Women	1
BRA	SILVA Rafaela	Judo	Women	1
BRA	BERGMANN Julia Isabelle	Volleyball	Women	1
BRA	TAMIRES	Football	Women	1
BRA	LEMES SANTOS Tainara	Volleyball	Women	1
BRA	GERALDO TEIXEIRA Lorenne	Volleyball	Women	1
BRA	LAUREN	Football	Women	1
BRA	SILVA CARNEIRO Macris Fernanda	Volleyball	Women	1


2. Qual foi a quantidade de medalhas comparada com a quantidade de medalhas olimpíadas anteriores? (França 2024 vs Tóquio 2020)


3. Quais modalidades tivemos mais medalhas em 2024?


4. Como foi o desempenho dos atletas Brasileiros em relação aos dos outros países?


5. Quais são as modalidades que possuem maior presença Feminina e Masculina?



## 🔎 Análises Complementares:

A análise revelou que o Brasil teve um desempenho superior em 2024, conquistando mais medalhas do que em Tóquio 2020.

As modalidades com mais medalhas foram Atletismo e Natação, enquanto o Skate destacou-se entre os atletas mais jovens.

Houve equilíbrio entre a presença feminina e masculina em diversas modalidades, evidenciando maior diversidade.


## 🚀 Tecnologias Utilizadas:

SQL para consultas e análises.



#### Conecte-se comigo

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sara-galv%C3%A3o-601776204/)
