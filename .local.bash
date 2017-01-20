export EDITOR='vim'

function scortch_docker {
  set -v;
  pushd;
  boot2docker down && boot2docker up && docker stop $(docker ps -qa) && docker rm $(docker ps -qa) && galley cleanup --unprotectStateful && cd /crashlytics/dockerfiles && git pull && cd /crashlytics/galley && git pull && galley pull www.dev && galley pull www.test && galley pull www.test.cucumber;
  popd;
  set +v;
}

function runwwwci {
  set -v
  pushd;
  boot2docker up && \
  cd /crashlytics/www && \
  galley run -s . www.test rake spec && \
  galley run -s . www.test.cucumber rake cucumber:sdk && \
  galley run -s . -a legacy www.test rake && \
  galley run -s . -a legacy www.test.cucumber cucumber -p crashlytics;
  popd;
  set +v
}

###### Sublime alias
alias sublime=/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl


### Functions for setting and getting environment variables from the OSX keychain ###
### Adapted from https://www.netmeister.org/blog/keychain-passwords.html ###

# Use: keychain-environment-variable SECRET_ENV_VAR
function keychain-environment-variable () {
    security find-generic-password -w -a ${USER} -D "environment variable" -s "${1}"
}

# Use: set-keychain-environment-variable SECRET_ENV_VAR
#   provide: super_secret_key_abc123
function set-keychain-environment-variable () {
    [ -n "$1" ] || print "Missing environment variable name"

    # Note: if using bash, use `-p` to indicate a prompt string, rather than the leading `?`
    read -sp "Enter Value for ${1}: " secret

    ( [ -n "$1" ] && [ -n "$secret" ] ) || return 1
    security add-generic-password -U -a ${USER} -D "environment variable" -s "${1}" -w "${secret}"
}

export AWS_ACCESS_KEY_ID=$(keychain-environment-variable AWS_ACCESS_KEY_ID);
export AWS_SECRET_ACCESS_KEY=$(keychain-environment-variable AWS_SECRET_ACCESS_KEY);
export LDAP_PASSWORD=$(keychain-environment-variable LDAP_PASSWORD);