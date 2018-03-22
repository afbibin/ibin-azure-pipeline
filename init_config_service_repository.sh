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
GIT_PUBLIC_KEY=AAAAB3NzaC1yc2EAAAADAQABAAABAQDTUGw+LoFAAdDVC/Tnquc+m3hMxwG/EgJgh5nPCycVNdYfSVDvV8nUTMluenNj+OIMO9eJjb5NNPARkQH1w2L+Nqt99FvK7RbGZcs9DdrNzV8/JB264C1gcm8LH71j8nMlIqK5AV6yZ6EspmAm4mLm73jvBaYSpys/7/10sW5Rd43wwEFhezF2XLzUGgINwrw4uzE7kf3IsroI91b0K0jdXv9hnKQcV+24K+pO9rcsYA+OmTfprG6YFgiUL64MF/lk5p+2Fim0MI1DIf9xspGCpApq1NRVQQa7aqYD+/XuX2VCFMjd9pTqDb2Zx82TcohqUljTZf0TrhYb39G8lgrL ibin@docker-ibin

export GIT_PUBLIC_KEY

#Git private key
#The value is a multiline text, so we use a tric https://stackoverflow.com/questions/15429330/how-to-specify-a-multi-line-shell-variable
read -d '' GIT_PRIVATE_KEY << EOF || true
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-128-CBC,7C6C111B2E5F22986B17E80F61A48F08

mgjZdHXj9RuM+Xy/mXKdrCRnf1N0gdW3YUdQFynKWYj+v/YOOh5Q3nLR6YzDsw2q
Wgrm1666aRX0ywWEd59NHhqJVRX87PxJY/2yVxbkOO17euB0Awy6cf6vBvaRWDhj
Ix4LXmkGdDLrf7Yz5Y33fOklHS0UbY5smZ82vBFoeDeJ+uwXzxOjgknjez8bQYvA
yE0VazK+CzEKM1EEuZCza6UPNlOQDysxSIpF7e5gqNrVbgoHOXZGLozZBJ7iJ52R
8Bzuaqz/vl4XSHaCM9ktwKkEevtVkQadlntz/iBxFNrWk0pdxX/j41DyYOAng7Pr
ts6CjbNevn1wGjZZDGzvHKOR72IZ+V56jx3hTmSLVWfSrkVe0KzeWiQ6p3pZlg7N
g4LAQJ6X8F0c3WhaYBVgTz1dA3+XsvCpD+TtTPfS452ZAH0AtzXqhBim4psRTt5V
vMkRrgiPFi9FbVNyEgyctXmedDUX0ZnpMpw23rpdr6fDTJdfvOGhR7zFnQrZ4akq
LoVHhM4uAh8DEhwg1Hs3VmrwDsVyVwQezQBgIj3kawF4HjlRAPhlBJKK9p3iUTLH
FcyIWMG2PJ7gqNaq5xIgg2Bvj9dPpM+D88Mq3gegDGVpn7OKu4Zth/L2hwr89lhS
reYHR1CFtOO36kJQ32WRAUGKWl7MMblmgXkRvHwMs2K9yg36vp+ndvC/D1VP+ICX
As4Sg7/fNOjH2yRpmXUgW1CCb0Ci4WCcrSJgrVDWZE93ktgqJSvNOClW0a8LpR65
ThRKGcUTB5Cv2zMvRIEk3Tz4Vr1eL4Eka4b1KDrY7MQm2zAKTSf3dxtlK0ywCyVW
sJqs9sZDipQqCWaRyTq35mc8OYu0nD9JKMFXISu4juQ8T+QIf51sXgQjNm1lI1Fo
oKjEGbGGES4MHhwjyy6FH8VvMkEfGB8wsGnEjJhfajoLoxCig3OTbucZ4/j7ZDxI
j2Qi8kXCLyaNFOFWv/oskXgeZLT96lkhdioDeoRftbyJ8sB2iA0mCvHAGcNPV56+
1aC+wLC0yMsWBUi19oEZ4sog4B+WOXP6hKi9R/LcPyZPnPucS7WYz8K+JpxwGEHa
b/33OKQtl9xHK7TNzSWBSIUOrUg2tHlhy7z27YeUQmk3kJjnRxaj+qsdiCTcrwNH
QNeycGDy+2Pu1mGvzy+ibL2cNCmRNZbXCbAJhNKHrd4l+kiy8rRGof5+dLcVeTL2
cRECYgBAbaVA9qaL/3OGqdDpeAEsSXrOWH7Pz22/GUpVYKHtm/L0Z3RStjxPvWMd
o2tEovcmrDQ9lVvU2Uyb5GdDG+doD2EeFH+4/YEGhDdFNRVsp/e4T/N03cedr1FK
C7vpfjMhzvoLhPC8t0BSYE/cTuZgsOM/uq888+ScISXwSW1AKpe9fuyzqVKr88JJ
C8oef884ugG5bBSq3LgvDWZe8gQ597RQ7meZVsd/BvYtNY3P9hvIjdNwbtfsCtzw
0cpe/2RJzZl0u7R8Y8lYZOb6scvdZ8f8Nl7/7uWHlFKIAcIlXNjeHAKMSrzt88z5
XmofpmncvaErbJq+LH1M9omdOjeeu2zb4mOjgyROK5x8HAmyck8vuQsNd4cRPaFf
-----END RSA PRIVATE KEY-----
EOF
export GIT_PRIVATE_KEY
