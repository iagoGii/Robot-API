*** Settings ***
Library    RequestsLibrary
Library    String
Library    OperatingSystem
Library    Collections

*** Variables ***
*** Keywords ***


Cadastrar Produto
    [Arguments]    ${token}

    ${body}        Get File    path=${EXECDIR}/Json/produto.json

    ${header}      Create Dictionary    Content-Type=application/json
    ...            Authorization=${token}
       
    ${response}    POST On Session    alias=api    url=/produtos
    ...            headers=${header}    
    ...            data=${body}    
    ...            expected_status=201
    
    ${response_json}    Set Variable                  ${response.json()}
    ${idp}              Set Variable                  ${response_json['_id']}

    Dictionary Should Contain Value                   ${response_json}    Cadastro realizado com sucesso
    RETURN                                            ${idp}


Consultar Produto da Lista
    [Arguments]    ${token}

    ${header}    Create Dictionary    Content-Type=application/json
    ...          Authorization=${token}
      
    ${response}    GET On Session    alias=api    url=/produtos
    ...            headers=${header}
    ...            expected_status=200

Consultar Produto por ID
    [Arguments]   ${id}    ${token}
    ${header}    Create Dictionary    Content-Type=application/json
    ...          Authorization=${token}
    
    ${response}    GET On Session    alias=api    url=/produtos/${id}
    ...            headers=${header}
    ...            expected_status=200
    
Atualiza Produto
    [Arguments]    ${id}    ${token}

    ${body}        Get File    path=${EXECDIR}/Json/atualiza_produto.json

    ${header}      Create Dictionary    Content-Type=application/json
    ...            Authorization=${token}
       
    ${response}    PUT On Session    alias=api    url=/produtos/${id}
    ...            headers=${header}    
    ...            data=${body}    
    ...            expected_status=200
    
    ${response_json}    Set Variable        ${response.json()}
    Dictionary Should Contain Value         ${response_json}    Registro alterado com sucesso
    

Deleta produto

    [Arguments]    ${id}    ${token}
    ${header}      Create Dictionary    Content-Type=application/json
    ...            Authorization=${token}
    ${response}    DELETE On Session    alias=api    url=/produtos/${id}
    ...            headers=${header}    expected_status=200
    
    ${response_json}    Set Variable       ${response.json()}
    Dictionary Should Contain Value        ${response_json}    Registro excluído com sucesso


Cadastrar Produto já existente
    [Arguments]    ${token}

    ${body}        Get File    path=${EXECDIR}/Json/produto.json

    ${header}      Create Dictionary    Content-Type=application/json
    ...            Authorization=${token}
       
    ${response}    POST On Session    alias=api    url=/produtos
    ...            headers=${header}    
    ...            data=${body}    
    ...            expected_status=400
    
    ${response_json}    Set Variable                  ${response.json()}

    Dictionary Should Contain Value                   ${response_json}    Já existe produto com esse nome

Consultar Produto com menos de 16 caracteres alfanuméricos
    [Arguments]      ${token}
    ${header}        Create Dictionary    Content-Type=application/json
    ...              Authorization=${token}
    
    ${response}    GET On Session    alias=api    url=/produtos/112211
    ...            headers=${header}
    ...            expected_status=400
    
    ${response_json}    Set Variable        ${response.json()}
    Dictionary Should Contain Value         ${response_json}    id deve ter exatamente 16 caracteres alfanuméricos

Consultar Produto não encontrado
    [Arguments]      ${token}
    ${header}        Create Dictionary    Content-Type=application/json
    ...              Authorization=${token}
    
    ${response}    GET On Session    alias=api    url=/produtos/1234567891011123
    ...            headers=${header}
    ...            expected_status=400
    
    ${response_json}    Set Variable        ${response.json()}
    Dictionary Should Contain Value         ${response_json}    Produto não encontrado