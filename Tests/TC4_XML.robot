*** Settings ***
Documentation    This is XML validation test case
Resource       ../Resources/resources.robot
Library     Collections
Library     os
Library     XML

*** Test Cases ***
ValidateXML
    ${xml_data}=       parse xml     Data/books.xml
    ${first_title}=      get element text     ${xml_data}   .//book[@id='bk101'][1]/title[1]

    log to console    ${first_title}
    should be equal    ${first_title}   XML Developer's Guide

    ${first_title}=      get element     ${xml_data}   .//book[@id='bk101'][1]/title
    should be equal    ${first_title.text}   XML Developer's Guide

    element text should be    ${xml_data}      XML Developer's Guide         .//book[@id='bk101'][1]/title

    ${count_books}=     get element count      ${xml_data}      .//book
    log to console    ${count_books}
    should be equal as integers    ${count_books}   12


    element attribute should be    ${xml_data}   id    bk101    .//book[1]


    ${first_book}=  get child elements    ${xml_data}       .//book[1]

    ${author}=  get element text    ${first_book[0]}
    should be equal    ${author}    Gambardella, Matthew