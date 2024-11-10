-- Fazer uma Query que tenha os produtos por quantidade vendida - mais algumas informações a respeito, por comprador.

select 
	dim_vendedor.nome_vendedor,
	fato_vendas.dim_produto_id,
	fato_vendas.quantidade,
	sum (quantidade * valor_total) over ( partition by dim_vendedor.nome_vendedor) as total_faturado
from toy_table.dim_vendedor left join toy_table.fato_vendas
on dim_vendedor.dim_vendedor_id = fato_vendas.dim_vendedor_id
