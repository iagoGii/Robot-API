# Robot Framework API Testing

Este projeto utiliza o Robot Framework para realizar testes automatizados em uma API de cadastro de usuários, produtos e carrinhos. O objetivo é validar endpoints relacionados ao cadastro, consulta, atualização e exclusão desses dados, além de garantir que o estoque seja reabastecido após exclusões de carrinhos.

---

## 📁 Estrutura do Projeto

```
Robot Framework API/
├── Resources/                 
│   ├── usuarios.robot         # Keywords para testes de Usuários
│   ├── produtos.robot         # Keywords para testes de Produtos
│   └── carrinhos.robot        # Keywords para testes de Carrinhos
├── Tests/                     
│   ├── usuarios_tests.robot   # Testes dos endpoints de usuários
│   ├── produtos_tests.robot   # Testes dos endpoints de produtos
│   └── carrinhos_tests.robot  # Testes dos endpoints de carrinhos
├── Json/                      
│   ├── usuario.json           # Payload para cadastro de Usuários
│   ├── produto.json           # Payload para cadastro de Produtos
│   └── carrinho.json          # Payload para cadastro de Carrinhos
└── README.md                  # Documentação do projeto

```

---

## ✅ Pré-requisitos

Certifique-se de ter os seguintes itens instalados:

- Python 3.9+
- Robot Framework
- RequestsLibrary

Para instalar as dependências:

```bash
pip install robotframework robotframework-requests
```

---

## ⚖️ Como Executar os Testes

Execute os testes com o seguinte comando:

```bash
robot Tests/

Ou execute testes específicos, como:

robot Tests/usuarios_tests.robot
robot Tests/produtos_tests.robot
robot Tests/carrinhos_tests.robot

```

---

## 🚀 O que foi Feito

## Automação de Testes de API
- Cadastro de Usuários, Produtos e Carrinhos: Envio de payloads JSON para criação de registros.
- Consulta de Usuários, Produtos e Carrinhos: Recuperação de todos os registros ou por ID.
- Atualização de Usuários, Produtos e Carrinhos: Alteração de informações dos registros.
- Exclusão de Usuários, Produtos e Carrinhos: Remoção de dados e reabastecimento de estoque (quando aplicável).

## Validações
- Verificação de status codes apropriados.
- Validação do conteúdo da resposta (mensagens de sucesso e estrutura esperada).

## Boas Práticas
- Uso de keywords reutilizáveis.
- Organização modular em pastas por contexto (recursos, testes, dados).

---

## ⚙️ Como os Testes Foram Construídos

### Keywords Reutilizáveis (Resources/)
- As keywords encapsulam chamadas de API e validações comuns. Exemplos:
- Cadastrar Usuário / Produto / Carrinho
- Consultar por ID ou listar todos
- Atualizar dados
- Excluir dados com verificações adicionais (ex: reabastecimento de estoque)

### Casos de Teste (Tests/)
- Os testes são compostos de cenários completos, como:
- Cadastro → Consulta → Atualização → Exclusão
- Fluxos positivos e negativos com validação de resposta

### Payloads JSON (Json/)
- Contêm os dados utilizados nas requisições:
- usuario.json: dados de criação de usuários
- produto.json: dados para cadastro de produtos
- carrinho.json: dados de carrinhos com produtos vinculados

---

## 🔍 Exemplo de Caso de Teste

```robot
*** Test Cases ***
Fluxo Completo de Carrinho
    [Documentation]    Testa o cadastro de um usuário, produto e carrinho; depois realiza consulta e exclusão.
    ${token}         Set Variable          Bearer seu_token_aqui
    ${id_usuario}    Cadastrar Usuário     ${token}
    ${id_produto}    Cadastrar Produto     ${token}
    ${id_carrinho}   Cadastrar Carrinho    ${token}          ${id_produto}
    Consultar Carrinhos da Lista por ID    ${id_carrinho}    ${token}
    Deletar Carrinho e Repor Estoque       ${id_carrinho}    ${token}

```

---

Para mais informações, consulte os arquivos `.robot` nas pastas `Resources/` e `Tests/`.