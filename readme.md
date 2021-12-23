- Install Pre-Requisites
    1. Windows: 'pip install -U -r resources/requirements.txt'
    2. Install Visual Studio Code

- To Execute Test Cases
    1. In Headmode windows terminal
        - robot -d results\1 -P resouces -v BROWSER:chrome tests\
    2. In Headlessmode
        - robot -d results\1 -P resouces tests\

- To rerun failed Test cases
    1. robot --rerunfailed -d results\1\output.xml --output rerun.xml -P resouces tests\

- To merge rerun result
    1. rebot -d results\1 --merge results\1\output.xml results\1\rerun.xml