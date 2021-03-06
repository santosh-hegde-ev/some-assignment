#!/bin/bash
set -e

source /edx/app/edxapp/venvs/edxapp/bin/activate

cd /edx/app/edxapp/edx-platform
mkdir -p reports

pip install -r requirements/edx/testing.txt

cd /ev-sa
pip uninstall ev-sa -y
pip install -e .

# Install codecov so we can upload code coverage results
pip install codecov

# output the packages which are installed for logging
pip freeze

# adjust test files for integration tests
cp /edx/app/edxapp/edx-platform/setup.cfg .
rm ./pytest.ini
mkdir test_root  # for edx

pytest ./ev_sa/tests/integration_tests.py --cov .
coverage xml
codecov
