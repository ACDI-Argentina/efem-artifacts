# Give4Forest - Instructivo de despliegue 

El despliegue de Give4Forest se realiza a través de contenedores Docker y Docker Compose.

El despliegue se presenta a continuación.

![Despliegue](despliegue.svg)

## Requerimientos

Para instalar la aplicación se requiere:

- [Git](https://git-scm.com/)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker compose](https://docs.docker.com/compose/install/)

> Las pruebas se han realizado sobre Ubuntu `20.04`, con Docker `19.03.8` y Docker Compose `1.25.0`.

## Procedimiento

### 1. Ejecutar nodo RSK

Las instrucciones oficiales se encuentran en el [portal de desarrollo de RSK](https://developers.rsk.co/rsk/node/install).

RSK cuenta con 3 redes:

  - *Desarrollo*: *Regtest*
  - *Testing*: *Testnet*
  - *Producción*: *Mainnet*

Para las redes de *Testing* y *Producción* existen nodos públicos que pueden ser utilizados.

En *Desarrollo* se recomienda iniciar un nodo privado RSK local de la siguiente manera:

```
docker-compose -f docker-compose.dev.rsk-node-regtest.yml up -d
```
Para detener el nodo y eliminar el contenedor debe ejecutarse lo siguiente:

```
docker-compose -f docker-compose.dev.rsk-node-regtest.yml down
```

> El contenedor debe eliminarse ya que se produce un error si se inicia el mismo contenedor nuevamente.

### 2. Desplegar smart contract

Se debe desplegar el smart contract de Give4Forest en el nodo de RSK iniciado localmente. Las instrucciones de desplegue en desarrollo se detallan [aquí](https://github.com/ACDI-Argentina/give-4-forest-contract/tree/master/apps/crowdfunding#desarrollo).

Las direcciones de los smart contracts desplegados deben actualizarse en la configuración, establecéndose las siguientes variables de ambiente:

  - REACT_APP_CROWDFUNDING_ADDRESS
  - REACT_APP_EXCHANGE_RATE_PROVIDER_ADDRESS
  - REACT_APP_TOKEN_RIF_ADDRESS
  - REACT_APP_TOKEN_DOC_ADDRESS

### 3. Descargar proyectos desde Github

Para la construcción de las imágenes de *give4forest-dapp* y de *give4forest-feathers*, se requiere descargar el código fuente desde los repositorios en Github. Los siguientes scrtips son de utilidad para este paso.

```bash
.\scripts\clone-give4forest-dapp.sh
.\scripts\clone-give4forest-feathers.sh
```

> Este paso solo es necesario en el caso de que se trabaje en un entorno de desarrollo. Para los demás ambientes, las imagenes de los contenedores se pueden obtener directamente desde [ACDI Dockerhub](https://hub.docker.com/u/acdi). 
> En el caso del servicio *efem-users-feathers* el mismo es ejecutado utilizando la imagen publicada en dockerhub, independientemente del entorno utilizado.

### 4. Configuración

Los archivos de configuración se encuentran montados en los contenedores en forma de [bind mount](https://docs.docker.com/storage/bind-mounts/). De esta forma es posible cambiar la configuración sin reconstruir las imágenes.

Adicional a los archivos de configuración, puede parametrizarse el archivo de ambiente `.env` para establecer el valor de variables de ambiente.

**Give4Forest Dapp**

Configurar el archivo `dapp/config/configuration.js`.

En el caso de la dapp, se inicia en modo `development`, por lo que los cambios son tomados tan pronto se modifique el archivo sin reiniciar el contenedor.

Configurar la url del servicio de usuarios usando la variable de entorno `REACT_APP_FEATHERJS_USERS_CONNECTION_URL`.

**Avalado Feathers**

Configurar el archivo `feathers/config/default.json`.

**Efem users service**

Configurar el archivo `efem-users-feathers/config/default.json`.

Configurar la conexión con la base de datos usando la variable de entorno `USERS_MONGO_DB`. Tomar de ejemplo la que se muestra en .env-example.

#### Configuración de DNS

Se deben agregar las siguientes entradas en el archivo */etc/hosts*.

```
127.0.0.1     give4forest-ipfs
127.0.0.1     give4forest-feathers
127.0.0.1     efem-users-service
127.0.0.1     avaldao-mongodb
```

Esto es para que los host de los contenedores sean accesibles por su nombre desde el host de desarrollo.

### 5. Ejecución

Al momento de ejecutar los contenedores, debe elegirse cual es el ambiente (`development`|`staging`|`production`) que se desea utilizar.

Por ejemplo, para iniciar el ambiente de `development`, el cual es utilizado para el desarrollo local, se debe ejecutar lo siguiente:

```bash
docker-compose -f docker-compose.dev.yml up
```

Esto inicia los contenedores en el orden adecuado.
En el caso de aquellos contenedores para los cuales no tenga una imágen en el registro local, se crearán utilizando los archivo `Dockerfiles` que se encuentran en los directorios especificados en la directiva `build` del servicio.

## Problemas conocidos

### Configuración de CORS en IPFS

La primera vez que se inicia el contenedor `give4forest-ipfs`, no cuenta con CORS habilitado. Si bien se han ejecutado los comandos para configurar las opciones, no toman efecto hasta que el contenedor es reiniciado. Por este motivo, es necesario ejecutar el comando *update.sh* que se encuentra en el directorio *ipfs*.

```bash
# Workaround por problema de configuración de CORS en IPFS (ejecutar solo una vez).
./ipfs/update.sh
```

## IPFS Pinning

Para utilizar el servicio de IPFS Pinning de Pinata es necesario configurar las siguientes variables de entorno en el archivo *.env*:

```
PINATA_API_KEY="your pinata api key"
PINATA_SECRET_API_KEY="your pinata secret api key"
```
Estas datos deben ser mantenidos fuera del versionado en Github.