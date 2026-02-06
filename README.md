# ODROID M1S + Pantalla VU8S (800x480) - Guía de Configuración

Este repositorio contiene la configuración optimizada para usar un **ODROID M1S** con la pantalla **VU8S** bajo Ubuntu GNOME. 

## Características de esta configuración:
* **Entrada Directa (Autologin):** Inicia el escritorio sin pedir contraseña.
* **Estabilidad Total:** Evita la pantalla negra desactivando la aceleración GPU incompatible.
* **Fluidez:** Optimizado con `ShadowFB` y 24 bits para un rendimiento suave en CPU.
* **Teclado Virtual:** Configurado con `Onboard` para uso tipo tablet.

## Instrucciones de uso rápido:
Para instalar todo automáticamente en un ODROID nuevo, ejecuta:
```bash
wget https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/install.sh
chmod +x install.sh
./install.sh
