import pandas as pd
import psycopg2

# Conecte-se ao seu banco de dados (substitua pelos seus dados de conexão)
conn = psycopg2.connect(
    dbname="olimpiadas_datas_2024",
    user="postgres",
    password="14379095746",
    host="localhost",
    port="5432"
)

# Consulta SQL
query_1 = """
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
"""

# Execute a consulta e converta o resultado em um DataFrame
df_1 = pd.read_sql_query(query_1, conn)

# Converta o DataFrame em uma tabela Markdown
markdown_table_1 = df_1.to_markdown(index=False)

# Imprima a tabela Markdown
print(markdown_table_1)

# Feche a conexão
conn.close()