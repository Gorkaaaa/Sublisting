# Sublisting
Automatiza la recolección y verificación de subdominios usando herramientas como subfinder, amass, sublist3r, httpx, y socialhunter. El repositorio incluye scripts de instalación y ejecución que obtienen, filtran y validan subdominios, con un output limpio y estético. Contribuciones bienvenidas.

Descripción del Proyecto

Este proyecto automatiza la recolección y verificación de subdominios utilizando herramientas como subfinder, amass, sublist3r, httpx y socialhunter. Incluye scripts que facilitan la obtención, filtrado y validación de subdominios, ofreciendo un resultado limpio y estéticamente organizado.
Archivos del Repositorio

    finder.py: Script en Python utilizado para verificar la accesibilidad de los subdominios recolectados.
    install.sh: Script de instalación para configurar todas las herramientas necesarias en tu entorno de trabajo.
    Sublisting.sh: Script de Bash que automatiza el proceso de recolección de subdominios mediante diversas herramientas.

Instalación

```
git clone https://github.com/Gorkaaaa/Sublisting.git
cd Sublisting
```

Ejecuta el script de instalación para configurar el entorno:

```
chmod +x install.sh
./install.sh
```

Ejecuta el script Sublisting.sh para recolectar y verificar los subdominios:

```
chmod +x Sublisting.sh
./Sublisting.sh <dominio>
```
