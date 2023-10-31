*** Settings ***
Documentation    This is JSON validation test case
Resource       ../Resources/resources.robot
Library     Collections
Library     os
Library     JSONLibrary

*** Test Cases ***
ValidateJSON
    ${json_data}=       Load json from file     Data/jsondata.json
    ${debug_value}=      get value from json     ${json_data}        $.widget.debug
    ${window_title_value}=      get value from json     ${json_data}        $.widget.window.title
    ${image_value}=      get value from json     ${json_data}        $.widget.image

    log to console    ${json_data}
    log to console    ${debug_value}

    should be equal    ${debug_value[0]}   on
    should be equal    ${window_title_value[0]}   Sample Konfabulator Widget