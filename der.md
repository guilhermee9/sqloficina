erDiagram
    CLIENTES ||--o{ VEICULOS : "possui"
    VEICULOS ||--o{ ORDENS_SERVICO : "recebe"
    ORDENS_SERVICO ||--o{ ITENS_ORDEM : "tem"
    SERVICOS ||--o{ ITENS_ORDEM : "compõe"

    CLIENTES {
        INT     id_cliente PK
        VARCHAR nome
        CHAR    cpf
        VARCHAR telefone
        VARCHAR email
    }

    VEICULOS {
        INT     id_veiculo PK
        INT     id_cliente FK
        CHAR    placa UK
        VARCHAR marca
        VARCHAR modelo
        SMALLINT ano
        VARCHAR cor
    }

    SERVICOS {
        INT     id_servico PK
        VARCHAR nome
        ENUM    categoria  "Mecânica|Elétrica|Funilaria|Diagnóstico|Revisão"
        DECIMAL preco_base
        INT     minutos_estimados
    }

    ORDENS_SERVICO {
        INT       id_os PK
        INT       id_veiculo FK
        DATETIME  data_abertura
        DATETIME  data_fechamento
        ENUM      status "Aberta|Em andamento|Concluída|Cancelada"
        ENUM      forma_pagamento "Dinheiro|Cartão|Pix|Boleto"
        DECIMAL   desconto_os      "% (0-100)"
        VARCHAR   observacoes
    }

    ITENS_ORDEM {
        INT     id_os PK, FK
        INT     id_servico PK, FK
        INT     quantidade
        DECIMAL preco_unitario
        DECIMAL desconto_item     "% (0-100)"
    } 
