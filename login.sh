#!/bin/bash
# nombre : Francisco Céspedes
# correo : ncwapuntes@gmail.com / francisco@twpanel.com
# login automatico para revincular una cuenta al deck smdeck
# me crea las cookies
curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -L https://api.twitter.com/oauth/authenticate?oauth_token=i_dn4gAAAAAAE1ueAAABUxoa6us -c cookies.txt  > template.html
