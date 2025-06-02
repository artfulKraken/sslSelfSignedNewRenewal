#!/bin/zsh
# Creates new 90 day selfsigned ssh key if one doesn not exist at certDir or renews if cert expires in
# in 30 days or less

certDir="/path/to/cert/directory/"
certName="cert.crt"
keyName="cert.key"

# identifying info for ssl cert.  enter info to add to cert or leave blank since it is self-signed cert
country=""
state=""
region=""
company=""
department=""
email=""

flgGoodCert=0

# Check if .cert and .key files exist and create them if they don't
if [[ -e "$certDir/${certName}" && -e "$certDir/${keyName}" ]] ; then
  # cmd to get expiration date in text format of current certificate
  certExpText=$(openssl x509 -noout -enddate -in $certDir/$certName | cut -f2 -d=)
  certExpDate=$(date -j -f "%b %d %T %Y %Z" "${certExpText}" "+%s")
  curDate=$(date "+%s" )
  daysLeft=$(( (certExpDate - curDate) / 86400))
  if [[ $daysLeft > 30 ]] ; then
    flgGoodCert=1
  fi
fi
echo $flgGoodCert
if [[ $flgGoodCert == 0 ]] ; then
  sudo openssl req -newkey rsa:4096 \
    -x509 \
    -sha256 \
    -days 90 \
    -nodes \
    -out ${certDir}/${certName}  \
    -keyout ${certDir}/${keyName} \
    -subj "/C=${country}/ST=${state}/L=${region}/O=${company}/OU=${department}/CN=${email}"
fi

