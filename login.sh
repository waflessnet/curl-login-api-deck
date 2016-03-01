#!/bin/bash
# nombre : Francisco Céspedes
# correo : ncwapuntes@gmail.com / francisco@twpanel.com
# login automatico para revincular una cuenta al deck smdeck

if [ -z $1 ] ; then
	echo "favor ingrese nombre de deck"
	exit;
else
DECK=$1
fi
if [ -z $2 ] ; then
	echo "favor ingrese nombre del usuario"
	exit;
else
USER=$2
fi
if [ -z $3 ] ; then
	echo "favor ingrese clave de twitter"
	exit;
else
PASSWORD=$3
fi 

URL_TOKEN=$(curl -s -X POST --data "_deck=$DECK&_url=true" -L  http://smdeck.ayg.cl/td/deck -c cookiesSmdeck.txt)

echo "1"
echo $URL_TOKEN
if [ "$URL_TOKEN" == "El deck que ha ingresado no Existe" ] ; then
    echo "Este deck no existe *--------------------------------------------*"
    exit;
fi

#echo $PASSWORD
#exit

curl  -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -L $URL_TOKEN -c cookies.txt  > template.html
AUTHENTICITY_TOKEN=$(grep -i 'authenticity_token' template.html | grep -oE "(\value=\".*\")" | sed 's/value=//g' | tr -d '"')
REDIRECT_AFTER_LOGIN=$(grep -i 'redirect_after_login' template.html | grep -oE "(\value=\".*\")" | sed 's/value=//g' | tr -d '"')
OAUTH_TOKEN=$(grep -i 'name="oauth_token"' template.html | grep -oE "(\value=\".*\")" | sed 's/value=//g' | tr -d '"')
LANG=$(grep -i 'name="lang"' template.html | grep -oE "(\value=\".*\")" | sed 's/value=//g' | tr -d '"')
ACTION="https://api.twitter.com/oauth/authorize"
SUBMIT="Autorizar"

echo "AUTHENTICITY_TOKEN = $AUTHENTICITY_TOKEN"
echo "REDIRECT_AFTER_LOGIN = $REDIRECT_AFTER_LOGIN"
echo "OAUTH_TOKEN = $OAUTH_TOKEN"
echo "LANG = $LANG"
#login con twitter.
echo "2"
curl  -X POST  --data "authenticity_token=$AUTHENTICITY_TOKEN&redirect_after_login=$REDIRECT_AFTER_LOGIN&oauth_token=$OAUTH_TOKEN&lang=$LANG&session[username_or_email]=$USER&session[password]=$PASSWORD&submit=&$SUBMIT" -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/65    33.18.5" -L $ACTION -b cookies.txt >redireccion.html

#login en plataforma
echo "3"
URL_PLATAFORMA=$(grep -i 'href=' redireccion.html | grep -oE "(\href=\".*\")" | grep -i oauth_verifier | sed 's/href=//g' | tr -d '"')
curl -X GET $URL_PLATAFORMA -b cookiesSmdeck.txt > salida.html

