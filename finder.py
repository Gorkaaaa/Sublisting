import httpx
from colorama import Fore, Style, init
import re
import sys

# Inicializar colorama
init(autoreset=True)

# Verificar si se ha proporcionado el archivo de dominios como argumento
if len(sys.argv) < 2:
    print(f"{Fore.RED}[ERROR] No se proporcionó el archivo de dominios.{Style.RESET_ALL}")
    sys.exit(1)

file_path = sys.argv[1]

# Cargar los dominios desde el archivo
with open(file_path, "r") as file:
    domains = file.readlines()

# Limpiar los dominios (eliminar saltos de línea y espacios)
domains = [domain.strip() for domain in domains]

# Función para validar si el dominio tiene caracteres válidos
def is_valid_format(domain):
    if not domain or any(c in domain for c in "\n\r\t"):
        return False
    if not re.match(r"^[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}$", domain):  # Verificar formato básico de dominio
        return False
    return True

# Listas para almacenar los dominios válidos e inválidos
valid_domains = []
invalid_domains = []

# Crear un cliente httpx
client = httpx.Client()

# Función para verificar si un dominio es accesible
def is_valid_domain(domain):
    url_https = f"https://{domain}"
    url_http = f"http://{domain}"
    
    try:
        response = client.get(url_https, timeout=5)
        if response.status_code != 200:
            return False
        print(f"{Fore.GREEN}[INFO] {domain} es válido (https){Style.RESET_ALL}")
        valid_domains.append(domain)
    except httpx.RequestError:
        try:
            response = client.get(url_http, timeout=5)
            if response.status_code != 200:
                return False
            print(f"{Fore.GREEN}[INFO] {domain} es válido (http){Style.RESET_ALL}")
            valid_domains.append(domain)
        except httpx.RequestError:
            print(f"{Fore.RED}[ERROR] {domain} no es válido.{Style.RESET_ALL}")
            invalid_domains.append(domain)
            return False
    return True

# Comprobar cada dominio
print(f"{Fore.YELLOW}[INFO] Iniciando la verificación de dominios...{Style.RESET_ALL}")
for domain in domains:
    if not is_valid_format(domain):
        print(f"{Fore.RED}[ERROR] {domain} tiene un formato inválido o caracteres no imprimibles.{Style.RESET_ALL}")
        invalid_domains.append(domain)
        continue

    print(f"{Fore.CYAN}[INFO] Verificando {domain}...{Style.RESET_ALL}")
    is_valid_domain(domain)

# Guardar los dominios válidos e inválidos en archivos
with open("valid_domains.txt", "w") as file:
    for domain in valid_domains:
        file.write(domain + "\n")

# Imprimir resultados finales
print(f"{Fore.YELLOW}[INFO] Proceso terminado.{Style.RESET_ALL}")
print(f"{Fore.GREEN}[INFO] Los dominios válidos están en 'valid_domains.txt'.{Style.RESET_ALL}")
