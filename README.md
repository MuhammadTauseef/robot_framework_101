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