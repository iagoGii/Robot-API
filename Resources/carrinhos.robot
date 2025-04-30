*** Settings ***
Library    RequestsLibrary
Library    String
Library    OperatingSystem
Library    Collections

*** Variables ***
*** Keywords ***


Cadastrar Carrinho
    [Arguments]    ${token}    ${idp}

    ${body}        Get File    path=${EXECDIR}/Json/carrinho.json
    ${body}        Replace String Using Regexp    ${body}    _id    ${idp}

    ${header}      Create Dictionary    Content-Type=application/json
    ...            Authorization=${token}
       
    ${response}    POST On Session    alias=api    url=/carrinhos
    ...            headers=${header}    
    ...            data=${body}        
    ...            expected_status=201
    
    ${response_json}    Set Variable    ${response.json()}
    ${idc}              Set Variable    ${response_json['_id']}

    Dictionary Should Contain Value     ${response_json}    Cadastro realizado com sucesso
    RETURN    ${idc}

Consultar Carrinhos da Lista

    ${header}      Create Dictionary    Content-Type=application/json

    ${response}    GET On Session    alias=api    url=/carrinhos
    ...            headers=${header}
    ...            expected_status=200
    
Consultar Carrinhos da Lista por ID
    [Arguments]     ${id}    ${token}
    ${header}       Create Dictionary    Content-Type=application/json
    ...             Authorization=${token}
        
    ${response}    GET On Session    alias=api    url=/carrinhos/${id}
    ...            headers=${header}
    ...            expected_status=200


Deleta Carrinho e voltar Produto para estoque
    [Arguments]    ${token}
    ${header}      Create Dictionary    Content-Type=application/json
    ...            Authorization=${token}
    ${response}    DELETE On Session    alias=api    url=/carrinhos/cancelar-compra
    ...            headers=${header}    expected_status=200
    
    ${response_json}    Set Variable        ${response.json()}
    Dictionary Should Contain Value         ${response_json}    Registro excluído com sucesso. Estoque dos produtos reabastecido

