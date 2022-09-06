!/bin/bash
#
# MicroGiro By: BIEL a.k.a tty025
#
# 09/05/2022
#
# Biel, Gui, Rudia

curl -s "https://fapi.binance.com/fapi/v1/exchangeInfo"|tr "," "\n"|grep "symbol"|cut -d":" -f2|cut -d'"' -f2|sort|uniq|grep -v "symbol"|grep "[A-Z]"|>
curl -s "https://fapi.binance.com/fapi/v1/exchangeInfo"|sed 's/]},{/\n\n\n\n\n/g' > .semi

echo ""
echo "PAR;TICKSIZE;SCALE;MINPRICE;MAXPRICE;MAXORDERS;MAXORDERSALGO;QTDMIN;QTDMAX"
echo ""

cat PARES|while read par; do
ticksize="$(cat .semi|grep "$par"|head -n 1|tr "\," "\n"|grep "tickSize"|head -n 1|cut -d":" -f2|cut -d'"' -f2)";
scale="$(cat .semi|grep "$par"|head -n 1|tr "\," "\n"|grep "pricePrecision"|head -n 1|cut -d":" -f2|cut -d'"' -f2)";
minprice="$(cat .semi|grep "$par"|head -n 1|tr "\," "\n"|grep "minPrice"|head -n 1|cut -d":" -f3|cut -d'"' -f2)";
maxprice="$(cat .semi|grep "$par"|head -n 1|tr "\," "\n"|grep "maxPrice"|head -n 1|cut -d":" -f2|cut -d'"' -f2)";
minqty="$(cat .semi|grep "$par"|head -n 1|tr "," "\n"|grep "minQty"|head -n 1|cut -d":" -f2|cut -d'"' -f2)";
maxqty="$(cat .semi|grep "$par"|head -n 1|tr "," "\n"|grep "maxQty"|head -n 1|cut -d":" -f2|cut -d'"' -f2)";

echo "$par;$ticksize;$scale;$minprice;$maxprice;200;10;$minqty;$maxqty"