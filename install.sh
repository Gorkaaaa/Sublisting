#!/bin/bash

echo -e "\e[34m[INFO]\e[0m Iniciando la instalación de dependencias necesarias..."

echo -e "\e[34m[INFO]\e[0m Descargando socialhunter..."
sudo wget https://github.com/utkusen/socialhunter/releases/download/v0.1.1/socialhunter_0.1.1_Linux_amd64.tar.gz -q
echo -e "\e[32m[OK]\e[0m socialhunter descargado."

echo -e "\e[34m[INFO]\e[0m Extrayendo el archivo descargado..."
sudo tar xzvf socialhunter_0.1.1_Linux_amd64.tar.gz -C /tmp >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m Archivo extraído."

echo -e "\e[34m[INFO]\e[0m Moviendo socialhunter a /usr/bin..."
sudo mv /tmp/socialhunter /usr/bin/socialhunter >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m socialhunter movido a /usr/bin."

echo -e "\e[34m[INFO]\e[0m Instalando golang..."
sudo apt install golang -y >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m golang instalado."

echo -e "\e[34m[INFO]\e[0m Instalando subfinder..."
sudo apt install subfinder -y >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m subfinder instalado."

echo -e "\e[34m[INFO]\e[0m Instalando amass..."
sudo apt install amass -y >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m amass instalado."

echo -e "\e[34m[INFO]\e[0m Instalando sublist3r..."
sudo apt install sublist3r -y >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m sublist3r instalado."

echo -e "\e[34m[INFO]\e[0m Instalando nuclei..."
sudo apt install nuclei -y >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m nuclei instalado."

echo -e "\e[34m[INFO]\e[0m Instalando httpx..."
sudo pip3 install httpx --break-system-packages >/dev/null 2>&1
echo -e "\e[32m[OK]\e[0m httpx instalado."

echo -e "\e[34m[INFO]\e[0m Instalación completada. Todos los paquetes necesarios están listos para usarse."
