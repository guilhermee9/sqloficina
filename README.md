# sq# Banco de Dados — Oficina (MySQL, 5 tabelas)

Modelo simples para gerenciamento de **oficina** (clientes, veículos, OS e serviços).

## Tabelas
- **clientes**: cadastro (CPF único).
- **veiculos**: um cliente pode ter vários veículos (placa única).
- **servicos**: catálogo (categoria, preço base, tempo estimado).
- **ordens_servico (OS)**: status, datas, desconto da OS e forma de pagamento.
- **itens_ordem**: itens da OS (quantidade, preço unitário, desconto do item).

## Relacionamentos
- `veiculos.id_cliente → clientes.id_cliente`
- `ordens_servico.id_veiculo → veiculos.id_veiculo`
- `itens_ordem.id_os → ordens_servico.id_os`
- `itens_ordem.id_servico → servicos.id_servico`

## Como executar
1. (Opcional) `CREATE DATABASE oficina_db ...; USE oficina_db;`
2. Rode `schema.sql` para criar as tabelas.
3. Rode `seed.sql` para popular com dados de teste.
4. Execute as consultas em `queries.sql` (ou copie do documento).

## Perguntas que as queries respondem
- **Catálogo:** quais serviços existem e seus preços?
- **Operação:** quais OS foram concluídas no mês atual?
- **Financeiro:** qual o **total por OS** (com descontos)?
- **Comercial:** quais **veículos** mais gastaram nos últimos 90 dias?
- **Cliente:** quem tem **2+ OS concluídas**?
- **Categoria:** quais categorias renderam **> 400** em 60 dias?
- **Backlog:** quais OS estão em andamento **> 24 horas**?

## Notas
- Valores monetários: `DECIMAL(10,2)`.
- Descontos em `%` nos itens e na OS.
- `ENUM`s para **categoria** e **status** simplificam validação.
