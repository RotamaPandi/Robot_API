*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_rul}    https://reqres.in



*** Test Cases ***
Get Request
    Create Session    API    
    ...    ${base_rul}
    ${resp}=    GET On Session    API    /api/users/2
    Log To Console    ${resp.content}
    ${status_code}=    convert to String    ${resp.status_code}
    should be equal    ${status_code}
    ...    200

Create Request
    Create Session    API    
    ...    ${base_rul}   
    ...    verify=${True}
    ${body}=    Create Dictionary    name=morpheus    job=leader
    ${resp}=    POST On Session    API    /api/users    data=${body}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}
    ${resp_body}    convert to String    ${resp.content}
    Should Contain    ${resp_body}    morpheus
    Should Contain    ${resp_body}    leader
    ${status_code}=    convert to String    ${resp.status_code}
    should be equal    ${status_code}
    ...    201

Update Request
    Create Session    API    ${base_rul}    verify=${True}
    ${body}=    Create Dictionary    name=morpheus    job=zion resident
    ${resp}=    PUT On Session    API    /api/users/2    data=${body}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}
    ${resp_body}    convert to String    ${resp.content}
    Should Contain    ${resp_body}    morpheus
    Should Contain    ${resp_body}    zion resident
    ${status_code}=    convert to String    ${resp.status_code}
    should be equal    ${status_code}
    ...    200

Delete Request
    Create Session    API    ${base_rul}    verify=${True}
    ${resp}=    DELETE On Session    API    /api/users/2
    ${status_code}=    convert to String    ${resp.status_code}
    should be equal    ${status_code}
    ...    204