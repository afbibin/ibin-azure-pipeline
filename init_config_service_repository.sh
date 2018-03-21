#!/bin/sh

##########################################################################
# Script initializes ENV variables which are responsible to access the
# specific Git repository which stores the backend system configuration
##########################################################################


# Git repository URL
export GIT_REPO=ssh://git@github.com/afbibin/backend-configuration


# Git branch is initialized with the value, based on the currently choosen test-environment
export GIT_BRANCH=master

#Git public key
GIT_PUBLIC_KEY=AAAAB3NzaC1yc2EAAAADAQABAAACAQDrxjdxPZQdVe2DK1+K6PGVWFhrEMWXnLNnQBc7FhBzBHmGeUWDlGiY8gjtKDJ3TF/y8YeN9KO3/YhA1N/PPJ5d+ow58hWxHyK9mx0Cg4YKCKXJN7f4EUPMKoVUbY+4Y/NFQuvF0tyYPEE3Myr980mzS8i7HbJGe8j/nocrJ4i+ndAJlmEsw8Ek8Jcfjy63oE1tBMN743qPrzI/qKveXqKUW1IsTvFFYO8MokYYNkV+mangBcJEID3Q+Zn/TL7KdNBtxfKH/jBMxtUCT7SyWjYWPR2GXpm5VXj9WxUzEKiWmXJ6jO845uWUQrVA3wxAf7ct7bPBLvPdV8qIg+GeDlZfvFWTJYG8IgDC/KVdOjxx83m1hHi4Aw/ap3ClJnHQLxVNhnDgxTZ7FkrSel1qdwwqJxQlhwT0V8fDLIHdS/FHVzxy0uuCTLcsOkwZhvAaEbwXmk2Od4lO9jY29/WN87L4A5FrOZq7cmd4BUaXAIKGGQto1h1+nK2Zqqi6Hx2rZw8xVQx7Z2S2rBRseYWZQ6BS5yHxCFQ2m0Im6RSavx0fBeH10eLqOJ+MInrq9uwJdEOAxS1SUqqpWRHHLaFkoWszfV/EOTZz5bIIaioWJTnL0pwwEBbiUT/o6SX2gB6Mx09/Be81x00+f3zMEpvjiV5Vi3PqLDeOR+ZaDNL/0kJALQ==

export GIT_PUBLIC_KEY

#Git private key
#The value is a multiline text, so we use a tric https://stackoverflow.com/questions/15429330/how-to-specify-a-multi-line-shell-variable
read -d '' GIT_PRIVATE_KEY << EOF || true
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-128-CBC,70887E32D3C1E3CDC8D57B4417884821

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
-----END RSA PRIVATE KEY-----
EOF
export GIT_PRIVATE_KEY
