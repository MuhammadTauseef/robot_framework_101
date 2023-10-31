# Robot framework introduction


## Install python
Follow the instrution of installing Python, should be version 3.8 or above
https://wiki.python.org/moin/BeginnersGuide/Download

## Install Robot Framework
open command prompt and enter following:
```
pip install robotframework
```

After installing Robotframework you should be able to enter **robot** and get ERROR. 
if that happens then the installation is alright.

## Install Pycharm Community edition
https://www.jetbrains.com/help/pycharm/installation-guide.html#silent
After installing Pycharm, install IntelliBot plugin

## Create first project

Pycharm->New Project and then name the project

### Create directory structure of the Project

```
mkdir Data
mkdir Resources
mkdir Output
mkdir Tests
```

Create a file Tests\TestCase1.robot

### Contents of robot file

Settings section and Test cases section of a robot file is mandatory. Keywords and variables sections are optional.
Settings can be used to import Libraries and for documentation.
```
*** Settings ***
Documentation   This is my first test case
Library OperatingSystem
```

In the below tests, TEST is name of the test and it only has a Log keyward with a message
```
*** Test Cases ***
TEST
    Log     This is testcase
```

### Executing tests

In the terminal of Pycharm execute below

```
robot Tests\TestCase1.robot
```

Executing multiple test case files

```
robot Tests\TestCase1.robot Tests\TestCase2.robot 
robot Tests
```

Making test suite i.e. declaring multiple test cases in same file
```
*** Test Cases ***
TEST1
    Log     This is testcase 1
TEST2
    Log     This is testcase 2

```

Randomizing the order of execution of tests
```
robot --randomize ALL Tests
```

### Tags
```
*** Test Cases ***
TEST1
    [tags] demo1
    Log     This is testcase 1
TEST2
    [tags] demo2
    Log     This is testcase 2

```

Then selecting demo1 tags test cases
```
robot --randomize ALL -i demo1 Tests
```
For selecting both demo1 and demo2 tags test cases
```
robot --randomize ALL -i demo1ANDdemo2 Tests
```
For selecting both demo1 or demo2 tags test cases
```
robot --randomize ALL -i demo1ORdemo2 Tests
```


### Analyzing results

If output report is green it means all tests passed, however if its red
that means at least 1 test failed.

log files log level can be changed with --loglevel with valid log levels are INFO, DEBUG, and TRACE.
To place all output files reprot,log and output into Output folder use -d option
```
robot --randomize ALL -i demo1ORdemo2 --loglevel INFO Tests
robot --randomize ALL -i demo1ORdemo2 --loglevel INFO -d Output Tests
```

### Variables setion
Variables can be declared and then accessed like below
```
*** Variables ***
${LOG_MESSAGE}  This is my log message.
*** Test Cases ***
TEST1
    [tags] demo1
    Log     ${LOG_MESSAGE}
```
List can be declared and accessed like below
```
*** Variables ***
@{MY_LIST}  test1 test2 test3
*** Test Cases ***
TEST1
    [tags] demo1
    Log     ${MY_LIST}
    Log     ${MY_LIST}[2]
```

Dictionary can be declared and access like below
```
*** Variables ***
&{DICTIONARY}   username=myuser  password=demo
*** Test Cases ***
TEST1
    [tags] demo1
    Log     ${DICTIONARY}[username]
    Log     ${DICTIONARY}[password]
```

### Keywords setion
To create your own keywords
```
*** Keywords ***
Log my output
    Log     This is my log output

*** Test cases ***
TEST
    Log my output
```

Passing arguments to keywords

```
*** Keywords ***
Log my output
    [Arguments]     ${msg}
    Log     This is my log message ${msg}

*** Test cases ***
TEST
    Log my output log msg is this.
```

### Resources files
Resources files declared shared keywords among multiple tests. Resource file does not have 
test cases section.
e.g. in Resources\resources.robot file
```
*** Settings ***

*** Keywords ***
Log my output
    [Arguments]     ${msg}
    Log     This is my log message ${msg}
*** Variables ***
```

Then in main test case file you can include resources as below and after that the keyword **Log my output** will be available
in the test file

```
*** Settings ***
Resource    ../Resources/resources.robot
```

## Rest API Testing

### Setup
Install required libraris
```
pip install requests
pip install robotframework-requests
pip install robotframework-jsonlibrary
```

### Create test case with GET
Public free API we are going to test is as below

https://resttesttest.com/#


Import libraries in settings
```
*** Settings ***
Documentation    This is GET request test case
Resource       ../Resources/resources.robot
Library     RequestsLibrary
```

Define Variables
```
*** Variables ***
${base_url}     https://httpbin.org
```

Create session towards the URL, then pass Get request onto the session and store the response in response varable. In the test case log output to the console to check the progress
```
*** Test Cases ***
Get_entry
    Create session  mysession   ${base_url}     verify=true
    ${response} =   Get on session     mysession   /get
    Log to console      ${response}
    Log to console      ${response.content}
    Log to console      ${response.headers}
```

output for response, response.content and resonse.headers will be as below:

.<Response [200]>
.b'{\n  "args": {}, \n  "headers": {\n    "Accept": "*/*", \n    "Accept-Encoding": "gzip, deflate", \n    "Host": "httpbin.org", \n    "User-Agent": "python-requests/2.31.0", \n    "X-Amzn-Trace-Id": "Root=1-654091f6-43d58fdb75
66750e1c553382"\n  }, \n  "origin": "103.151.43.91", \n  "url": "https://httpbin.org/get"\n}\n'
.{'Date': 'Tue, 31 Oct 2023 05:34:46 GMT', 'Content-Type': 'application/json', 'Content-Length': '307', 'Connection': 'keep-alive', 'Server': 'gunicorn/19.9.0', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Credentia
ls': 'true'}
'{
  "args": {},
  "headers": {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate",
    "Host": "httpbin.org",
    "User-Agent": "python-requests/2.31.0",
    "X-Amzn-Trace-Id": "Root=1-654091f6-43d58fdb7566750e1c553382"
  "origin": "103.151.43.91",
  "url": "https://httpbin.org/get"
}

Three types of validation is specified in the file, one for status code validation, another for a word present in body
and lastly, content type validation in the header.

Final file is TC1_GET_Request.robot

### Create test case with POST

In Post, body and headers needs to be passed which can be created with Collections create dictionary keyword.
```
*** Test Cases ***
Create_Something
    Create session  mysession   ${base_url}     verify=true
    ${body}=    create dictionary    username=user  password=passs
    ${header}=    create dictionary    Content-Type=application/json
    ${response} =   Post on session     mysession    /post      ${body}     ${header}
```

Log output of response.status_code and response.content is as below
200
.b'{\n  "args": {}, \n  "data": "", \n  "files": {}, \n  "form": {\n    "password": "passs", \n    "username": "user"\n  }, \n  "headers": {\n    "Accept": "*/*", \n    "Accept-Encoding": "gzip, deflate", \n    "Content-Length":
 "28", \n    "Content-Type": "application/x-www-form-urlencoded", \n    "Host": "httpbin.org", \n    "User-Agent": "python-requests/2.31.0", \n    "X-Amzn-Trace-Id": "Root=1-6540991b-7a9e63333119bd956e277a9e"\n  }, \n  "json": n
ull, \n  "origin": "103.151.43.91", \n  "url": "https://httpbin.org/post"\n}\n'


Final file is TC2_POST_Request.robot

### Create test case for JSON validation

json load from a file can be done with below method
```
    ${json_data}=       Load json from file     Data/jsondata.json
```
However, during API testing json will come as a response from API call.

Getting value of a particular json element and validating is done as below
```
${window_title_value}=      get value from json     ${json_data}        $.widget.window.title
should be equal    ${window_title_value[0]}   Sample Konfabulator Widget
```
Final file is TC3_JSON.robot
