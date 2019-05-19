#!/bin/bash

#----------------------------------[ Copyright ]----------------------------------------+
#       Name: sovmint                                                                   |
#       Author: Bocharnikov Sergei                                                      |
#       E-mail: bocharnikov@dezigner.ru                                                 |
#       Source: https://github.com/bocharnikov/                                         |
#                                                                                       |
#       Files: sovmint.sh                                                               |
#       Build: 190519                                                                   |
#       Copyright: 2019 Bocharnikov Sergei                                              |
#--------------------------------[ License: MIT ]---------------------------------------+
#                                                                                       |
#---------------------------------------------------------------------------------------+
#       Permission is hereby granted, free of charge, to any person obtaining a copy    |
#       of this software and associated documentation files (the "Software"), to deal   |
#       in the Software without restriction, including without limitation the rights    |
#       to use, copy, modify, merge, publish, distribute, sublicense, and/or sell       |
#       copies of the Software, and to permit persons to whom the Software is           |
#       furnished to do so, subject to the following conditions:                        |
#       The above copyright notice and this permission notice shall be included in all  |
#       copies or substantial portions of the Software.                                 |
#       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      |
#       IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        |
#       FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     |
#       AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          |
#       LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   |
#       OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   |
#       SOFTWARE.                                                                       |
#---------------------------------------------------------------------------------------+

DIR=/mnt2/sovmint/

WGET_LOG=/mnt2/sovmint/sovmint_wget.log
OLD_URL=/mnt2/sovmint/sovmint_oldurl.log

echo "LetsGO!" >"${OLD_URL}"

GET_URL=`curl -s https://sovmint.ru/cennik/ | grep 'width="33%"' | egrep -o 'http://sovmint.ru/taganskij[0-9a-z-]*/' | sort -u | sed 's/http/https/'`


GET_PIC_1=`curl -s "$GET_URL" | grep -o "https[^>]*.jpg" | grep download | head -n 1`
GET_PIC_2=`curl -s "$GET_URL" | grep -o "https[^>]*.jpg" | grep download | tail -n 1`


while read line; do

    if [[ "$line" != "$GET_URL" ]];
	then
	wget -P $DIR --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36 OPR/60.0.3255.95" "$GET_PIC_1" "$GET_PIC_2" -a $WGET_LOG >> $WGET_LOG
    fi

done < "${OLD_URL}"

echo "${GET_URL}" > "${OLD_URL}"
