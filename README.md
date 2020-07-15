# El futuro está en el monte - Instructivo de despliegue 
Debido a la cantidad de partes que componen la solución, cada una con sus distintos requisitos de dependencias, se decidió utilizar [docker  compose](https://docs.docker.com/compose/) para realizar el despliegue de la misma.
Docker compose se basa en contenedores, los cuales contienen una parte de la solución junto con las dependencias requeridas por esa parte. Esto nos da como ventaja que podamos ejecutar, sin tener que instalar las dependencias de forma local, lo cual podría originar conflictos si ya tenemos otras versiones de las mismas. 

## Recursos definidos en docker-compose
#### Contenedores
La solución está compuesta por los siguientes contenedores:
* efem-dapp
* efem-feathers
* efem-ipfs
* efem-rsk
* efem-mongodb 

Las imágenes a partir de las cuales se crean estos contenedores, se indican en el diagrama a continuación.
![EFEM Despliegue](despliegue.svg)

#### Volúmenes
Tanto **efem-ipfs** como **efem-mongodb** necesitan persistir datos más allá del ciclo de vida del contenedor. Es decir, si el contenedor se detiene por algún motivo, sería deseable no perder los datos almacenados hasta el momento. Se utilizan tres vólumenes, dos para ipfs, y uno para mongodb. Es posible administrarlos utilizando ``docker volume``. En el caso de querer borrarlos, simplemente usamos ``docker-compose down -v``.
#### Redes
Por defecto, docker-compose crea una red virtual y conecta a todos los contenedores especificados en el mismo archivo. Gracias a esto los contenedores pueden referirse entre si utilizando un esquema de nombres. A modo de ejemplo efem-feathers, puede configurar la conexión a la base datos, utilizando la url ``mongodb://efem-mongodb:27017/``
donde *efem-mongodb* es el nombre del contenedor, y docker se encargará de resolverlo automáticamente.


## Dependencias

Para poder ejecutar los contenedores es necesario tener instalado [**docker**](https://docs.docker.com/get-docker/) y [**docker-compose**](https://docs.docker.com/compose/install/).

Las pruebas se han realizado sobre Ubuntu 20.04, con Docker **19.03.8** y docker-compose  **1.25.0**. También es necesario contar con git para poder clonar los repositorios necesarios.

## Configuración del ambiente

Por workaround al problema de resolución de nombres, se deben agregar las siguientes entradas en el archivo */etc/hosts*.

```
127.0.0.1     efem-ipfs
127.0.0.1     efem-feathers
```

## Prerequisitos
Para la construcción de las imágenes de dapp y de feathers, es necesario obtener el código fuente desde los repositorios en github, para eso usamos los scripts fetch-dapp y fetch-feathers, los cuales clonan la rama efem-dev en directorios locales.
```bash
./fetch-dapp.sh
./fetch-feathers.sh
```
Una vez descargado el código fuente podemos continuar con la creación de las imágenes.

## Ejecución
Para iniciar los contenedores ejecutamos lo siguiente:
```bash
docker-compose up -d
# Workaround por problema de configuración de CORS en IPFS.
./ipfs/update.sh
```
Esto iniciará todos los contenedores del esquema, en un orden adecuado. En el caso de aquellos contenedores para los cuales no tenga una imágen en el registro local, procederá a la creación de las mismas utilizando los Dockerfiles que se encuentren en los directorios especificados en  la directiva build del servicio. Esto puede tomar algo de tiempo la primera vez que lo ejecutemos, especialmente en el caso de dapp y feathers que son los dos contenedores que más dependencias instalan a partir de npm.

## Despliegue de smart contracts

Una vez que los servicios se encuentren levantados, es necesario desplegar el smart contract de Crowdfunding según sus instrucciones de [despliegue](https://github.com/ACDI-Argentina/efem-aragon-apps/tree/efem-dev/apps/crowdfunding#despliegue).

Una vez completado el despliegue, debe tomarse la dirección de la App Crowdfunding:

```
Aragon deploy
 . . .
Crowdfunding deploy
 - Libraries
   . . .
 - Crowdfunding: 0x05A55E87d40572ea0F9e9D37079FB9cA11bdCc67
 . . .
 - Initialized
```

Y configurar la siguiente variable según el ambiente:

- *dapp/config/configuration.js#crowdfundingAddress*

En el caso de desarrollo, el cambio será reflejado en la dapp sin necesidad de reiniciar su contenedor.

## Configuración de dapp y feathers

Ambos contenedores obtienen su configuración a partir de dos archivos.
En el caso de dapp, lo hace a través del archivo **dapp/config/configuration.js** , mientras que feathers utiliza el archivo **feathers/config/default.json**.

Estos archivos se encuentran montados en los contenedores en forma de [bind mount](https://docs.docker.com/storage/bind-mounts/). De esta forma  podemos cambiar la configuración sin necesidad de reconstruir las imágenes.
En el caso de la dapp, como se inicia en modo development, los cambios serán tomados tan pronto modifiquemos el archivo sin necesidad de reiniciar el contenedor. 
## Problemas conocidos
### CORS en ipfs
La primera vez que se inicia el contenedor efem-ipfs, no tiene CORS habilitado. Si bien se han ejecutado los comandos para configurar las opciones, no toman efecto hasta que el contenedor es reiniciado. Por este motivo, es necesario ejecutar el comando update.sh que se encuentra en el directorio ipfs.
```bash
./ipfs/update.sh
```
### Resolución de nombres de contenedores en host
Si bien los contenedores al estar conectados a la misma red, pueden comunicarse a través de sus nombres, esto no es válido para el host sobre el cúal se ejecutan los contenedores.
La solución temporal fue agregar asociaciones en /etc/hosts los nombres de los contenedores hacia localhost. 

```
127.0.0.1     efem-ipfs
127.0.0.1     efem-feathers

```
Este esquema se usa **solo de forma local con fines de desarrollo**. En el ambiente productivo, se ejecutarán los contenedores en distintos servidores, los cuales tendrán asociados nombres de dominio.
