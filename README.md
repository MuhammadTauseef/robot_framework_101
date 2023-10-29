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