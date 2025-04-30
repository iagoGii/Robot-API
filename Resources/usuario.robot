*** Settings ***
Library    RequestsLibrary
Library    String
Library    OperatingSystem
Library    Collections

*** Variables ***
*** Keywords ***

Criar Sessão
    [Arguments]    ${url}
    Create Session    alias=api    url=${url}

Encerrar Sessão
    Delete All Sessions

Cadastrar Usuário
    ${body}    Get File    path=${EXECDIR}/Json/usuario.json

    ${header}    Create Dictionary    Content-Type=application/json

    ${response}    POST On Session    alias=api    url=/usuarios

    ...            headers=${header}    
    ...            data=${body}    
    ...            expected_status=201
    
    ${response_json}    Set Variable                ${response.json()}
    ${id}               Set Variable                ${response_json['_id']}

    Dictionary Should Contain Value      ${response_json}    Cadastro realizado com sucesso
    RETURN    ${id}

Consultar Usuário Lista
    ${header}      Create Dictionary    Content-Type=application/json
    ${response}    GET On Session    alias=api    url=/usuarios
    ...            headers=${header}
    ...            expected_status=200
   

Consultar Usuário por ID
    [Arguments]   ${id}
    ${header}      Create Dictionary    Content-Type=application/json
    ${response}    GET On Session    alias=api    url=/usuarios/${id}
    ...            headers=${header}
    ...            expected_status=200
    

Atualiza Usuário
    [Arguments]   ${id}

    ${body}        Get File    path=${EXECDIR}/Json/atualiza_usuario.json

    ${header}      Create Dictionary    Content-Type=application/json

    ${response}    PUT On Session    alias=api    url=/usuarios/${id}

    ...            headers=${header}    
    ...            data=${body}    
    ...            expected_status=200
    
    ${response_json}    Set Variable        ${response.json()}
    Dictionary Should Contain Value         ${response_json}    Registro alterado com sucesso

Exluir Registro
    [Arguments]   ${id}
    ${header}      Create Dictionary    Content-Type=application/json

    ${response}    DELETE On Session    alias=api    url=/usuarios/${id}

    ...            headers=${header}    
    ...            expected_status=200
    
    ${response_json}    Set Variable       ${response.json()}
    Dictionary Should Contain Value        ${response_json}    Registro excluído com sucesso
    

Gerar Token de autenticação
    [Arguments]    ${email}    ${password}

    ${body}      Get File    path=${EXECDIR}/Json/usuario.json

    ${header}    Create Dictionary    Content-Type=application/json

    ${response}    POST On Session    alias=api    url=/login
    ...            headers=${header}    
    ...            data={"email":"${email}","password":"${password}"}    
    ...            expected_status=200
    
    ${response_json}    Set Variable           ${response.json()}
    ${token}            Set Variable           ${response_json['authorization']}

    Dictionary Should Contain Value    ${response_json}    Login realizado com sucesso
    RETURN    ${token}

Cadastrar Usuario com email já existente
    ${body}    Get File    path=${EXECDIR}/Json/usuario.json

    ${header}    Create Dictionary    Content-Type=application/json

    ${response}    POST On Session    alias=api    url=/usuarios

    ...            headers=${header}    
    ...            data=${body}    
    ...            expected_status=400
    
    ${response_json}    Set Variable                ${response.json()}
    Dictionary Should Contain Value      ${response_json}    Este email já está sendo usado

Consultar Usuário por ID Inexistente
    ${header}      Create Dictionary    Content-Type=application/json
    ${response}    GET On Session    alias=api    url=/usuarios/123450011
    ...            headers=${header}
    ...            expected_status=400
    