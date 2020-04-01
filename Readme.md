# One Login helper for AWS

A simple docker-enabled script to get temporary AWS CLI role creds via STS, using
[onelogin](https://www.onelogin.com/).

This implementation wraps [idralyuk's](https://github.com/idralyuk/samlapi_onelogin) project to deliver the working python script from within the container.

## Installation

1. Make sure you have setup a `~/.aws/credentials` file
1. If docker isn't installed, go [here](https://docs.docker.com/install/)
1. [Download](https://github.com/wisersolutions/one-login/releases) the one-login script and put it in your execution path
1. Setup aws credentials file and add a blank profile in `~/.aws/credentials` for *saml* `[saml]`
1. Copy the example `one-login.ini` to your `.aws` credentials directory and update the following information:

* `onelogin_client_id`: Obtain from `OneLogin API Credentials` in LastPass
* `onelogin_client_secret`: Obtain from `OneLogin API Credentials` in LastPass
* `onelogin_appid`: Obtain from `OneLogin API Credentials` in LastPass
* `Email`: Your wiser email address
* `AccountNameId`: A comma separated list of mappings of account ID's to custom names (Example: mobee-test::153055050930,mobee-prod::042216585923)


## Running

```bash
$ one-login
Password:
OTP Code (MFA): 123456

Please choose the role you would like to assume:
 [ 0 ]:  arn:aws:iam::012345678901:role/Admin
 [ 1 ]:  arn:aws:iam::234567890123:role/Admin
Selection:  0

-------------------------------------------------------------------
Your new access key pair has been stored in the AWS configuration file:
    /home/app/.aws/credentials (under the saml profile).
Note that it will expire at 2018-08-09 03:22:58+00:00.
To use this credential, call the AWS CLI with the --profile option
    (e.g. aws --profile saml ec2 describe-instances).
-------------------------------------------------------------------
```

Where:

* password: is your OneLogin password
* OTP Code: is the code you get for OneLogin in Google Authenticator or similar app
* Selection is the number of one of the roles presented to you

## Building

1. Clone this repo onto your workstation/host 
2. Build the project (requires make and docker)

```
make
```

Test it !
