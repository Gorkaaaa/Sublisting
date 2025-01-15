#!/bin/bash

if [ -z "$1" ]; then
  echo -e "\e[31m[ERROR]\e[0m Uso: $0 <dominio>"
  exit 1
fi

DOMAIN=$1

echo -e "\e[34m[INFO]\e[0m Procesando el dominio: \e[32m$DOMAIN\e[0m"

echo -e "\e[34m[INFO]\e[0m Ejecutando subfinder..."
subfinder -all -d $DOMAIN -o domain1.txt --recursive >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m subfinder completado."

echo -e "\e[34m[INFO]\e[0m Ejecutando amass (límite: 30 minutos)..."
timeout 30m amass enum -d $DOMAIN > results 2>/dev/null
echo -e "\e[32m[OK]\e[0m amass completado."

echo -e "\e[34m[INFO]\e[0m Filtrando resultados de amass..."
grep -oP '\b([a-zA-Z0-9.-]+\.'$DOMAIN')\b' results > domain2.txt
echo -e "\e[32m[OK]\e[0m Filtrado de amass completado."

echo -e "\e[34m[INFO]\e[0m Ejecutando sublist3r..."
sublist3r -d $DOMAIN > results_sub 2>/dev/null
echo -e "\e[32m[OK]\e[0m sublist3r completado."

echo -e "\e[34m[INFO]\e[0m Filtrando resultados de sublist3r..."
grep -oP '\b([a-zA-Z0-9.-]+\.'$DOMAIN')\b' results_sub > domain3.txt
sed 's/^...//' domain3.txt > domain4.txt
echo -e "\e[32m[OK]\e[0m Filtrado de sublist3r completado."

echo -e "\e[34m[INFO]\e[0m Ejecutando crt.sh..."
curl -s "https://crt.sh/?q=%25.$DOMAIN&output=csv" | cut -d, -f5 | sort -u > domain5.txt
cat domain5.txt | sed 's/"//g' | sed 's/ CN=.*//g' | sed 's/^[ \t]*//;s/[ \t]*$//' | grep '\.'$DOMAIN > domain6.txt
echo -e "\e[32m[OK]\e[0m crt.sh completado."

echo -e "\e[34m[INFO]\e[0m Unificando resultados..."
cat domain1.txt domain4.txt domain2.txt domain6.txt | sort | uniq > domain
echo -e "\e[32m[OK]\e[0m Resultados unificados en 'domain'."

echo -e "\e[34m[INFO]\e[0m Ejecutando finder.py para verificar subdominios..."
python3 finder.py ./domain
echo -e "\e[32m[OK]\e[0m Ejecución de finder.py completada."

echo -e "\e[34m[INFO]\e[0m Eliminando archivos temporales..."
rm -f domain1.txt results domain2.txt results_sub domain3.txt domain4.txt domain5.txt domain6.txt
echo -e "\e[32m[OK]\e[0m Archivos temporales eliminados."

echo -e "\e[34m[INFO]\e[0m Proceso completado. Archivo final: \e[32mdomain\e[0m"
