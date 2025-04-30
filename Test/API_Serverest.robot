*** Settings ***

Resource    ../Resources/usuario.robot
Resource    ../Resources/produto.robot
Resource    ../Resources/carrinhos.robot

Suite Setup    Criar Sessão    https://serverest.dev
Suite Teardown    Encerrar Sessão

*** Variables ***
${email}       new@user.io
${password}    112233
*** Test Cases ***
CRUD Usuário
    [Documentation]    Realizar o cadastro de um usuário, consultar, atualizar e excluir o mesmo.
    ${id}    Cadastrar Usuário
    ${token}    Gerar Token de autenticação    ${email}    ${password}
    Consultar Usuário Lista
    Consultar Usuário por ID                   ${id}
    Atualiza Usuário                           ${id}
    Exluir Registro                            ${id}


CRUD de Produto
    [Documentation]    Realizar o cadastro de um produto, consultar, atualizar e excluir o mesmo.
    ${id}       Cadastrar Usuário
    ${token}    Gerar Token de autenticação      ${email}      ${password}
    ${idp}      Cadastrar Produto                ${token}
                Consultar Produto da Lista       ${token}
                Consultar Produto por ID         ${idp}        ${token}
                Atualiza Produto                 ${idp}        ${token}
                Deleta produto                   ${idp}        ${token}
                Exluir Registro                  ${id}


CRUD Carrinho
    [Documentation]    Realizar o cadastro de um carrinho, consultar, atualizar e excluir o mesmo.
    ${id}       Cadastrar Usuário
    ${token}    Gerar Token de autenticação              ${email}    ${password}
    ${idp}      Cadastrar Produto                        ${token}
    ${idc}      Cadastrar Carrinho                       ${token}    ${idp}
                Consultar Carrinhos da Lista    
                Consultar Carrinhos da Lista por ID      ${idc}      ${token}
                Deleta Carrinho e voltar Produto para estoque        ${token}
                Deleta produto                           ${idp}      ${token}
                Exluir Registro                          ${id}

Cenários Negativos - Usuário
    [Documentation]    Realizar o cadastro de um usuário já existente e consulta um usuário por ID inexistente.
    ${id}       Cadastrar Usuário
    ${token}    Gerar Token de autenticação                ${email}    ${password}
                Cadastrar Usuario com email já existente
                Consultar Usuário por ID Inexistente
                Exluir Registro                            ${id}

Cenários Negativos - Produto
    [Documentation]    Realizar o cadastro de um produto já existente, consulta um produto com menos de 16 caracteres e consulta um produto por ID inexistente.
    ${id}       Cadastrar Usuário
    ${token}    Gerar Token de autenticação                                          ${email}    ${password}
    ${idp}      Cadastrar Produto                                                    ${token}
                Cadastrar Produto já existente                                       ${token}
                Consultar Produto com menos de 16 caracteres alfanuméricos           ${token}
                Consultar Produto não encontrado                                     ${token}
                Deleta produto                                                       ${idp}        ${token}
                Exluir Registro                                                      ${id}