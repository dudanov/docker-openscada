# docker-openscada

[![Build Image](https://github.com/dudanov/docker-openscada/actions/workflows/build.yml/badge.svg)](https://github.com/dudanov/docker-openscada/actions/workflows/build.yml)
[![Docker Hub](https://ghcr-badge.egpl.dev/dudanov/openscada/size?label=Image%20Size&color=dodgerblue)](https://github.com/users/dudanov/packages/container/package/openscada)
[![Docker Hub](https://ghcr-badge.egpl.dev/dudanov/openscada/latest_tag?trim=major&label=GitHub%20Version&color=dodgerblue)](https://github.com/users/dudanov/packages/container/package/openscada)
[![Docker Hub](https://img.shields.io/docker/v/dudanov/openscada?label=Docker%20Hub%20Version&color=dodgerblue)](https://hub.docker.com/r/dudanov/openscada)
[![Docker Hub](https://img.shields.io/docker/stars/dudanov/openscada?label=Docker%20Hub%20Stars&color=dodgerblue)](https://hub.docker.com/r/dudanov/openscada)

This repository is used for automated building of [OpenSCADA](http://oscada.org) minimal docker image.

### Included modules

1. DB
   * [DBGate](http://oscada.org/wiki/Special:MyLanguage/Modules/DBGate)
   * [LDAP](http://oscada.org/wiki/Special:MyLanguage/Modules/LDAP)
   * [MySQL](http://oscada.org/wiki/Special:MyLanguage/Modules/MySQL)
   * [PostgreSQL](http://oscada.org/wiki/Special:MyLanguage/Modules/PostgreSQL)
   * [SQLite](http://oscada.org/wiki/Special:MyLanguage/Modules/SQLite)
2. Transports
   * [Sockets](http://oscada.org/wiki/Special:MyLanguage/Modules/Sockets)
   * [SSL](http://oscada.org/wiki/Special:MyLanguage/Modules/SSL)
3. Transport protocols
   * [HTTP](http://oscada.org/wiki/Special:MyLanguage/Modules/HTTP)
   * [ModBus](http://oscada.org/wiki/Special:MyLanguage/Modules/ModBus)
   * [OPC_UA](http://oscada.org/wiki/Special:MyLanguage/Modules/OPC_UA)
   * [SelfSystem](http://oscada.org/wiki/Special:MyLanguage/Modules/SelfSystem)
   * [UserProtocol](http://oscada.org/wiki/Special:MyLanguage/Modules/UserProtocol)
4. DAQ
   * [BlockCalc](http://oscada.org/wiki/Special:MyLanguage/Modules/BlockCalc)
   * [DAQGate](http://oscada.org/wiki/Special:MyLanguage/Modules/DAQGate)
   * [DCON](http://oscada.org/wiki/Special:MyLanguage/Modules/DCON)
   * [JavaLikeCalc](http://oscada.org/wiki/Special:MyLanguage/Modules/JavaLikeCalc)
   * [LogicLev](http://oscada.org/wiki/Special:MyLanguage/Modules/LogicLev)
   * [ModBus](http://oscada.org/wiki/Special:MyLanguage/Modules/ModBus)
   * [OPC_UA](http://oscada.org/wiki/Special:MyLanguage/Modules/OPC_UA)
   * [Siemens](http://oscada.org/wiki/Special:MyLanguage/Modules/Siemens)
   * [SNMP](http://oscada.org/wiki/Special:MyLanguage/Modules/SNMP)
   * [System](http://oscada.org/wiki/Special:MyLanguage/Modules/System)
5. Archives-History
   * [DBArch](http://oscada.org/wiki/Special:MyLanguage/Modules/DBArch)
   * [FSArch](http://oscada.org/wiki/Special:MyLanguage/Modules/FSArch)
6. User interfaces
   * [VCAEngine](http://oscada.org/wiki/Special:MyLanguage/Modules/VCAEngine)
   * [WebCfgD](http://oscada.org/wiki/Special:MyLanguage/Modules/WebCfgD)
   * [WebUser](http://oscada.org/wiki/Special:MyLanguage/Modules/WebUser)
   * [WebVision](http://oscada.org/wiki/Special:MyLanguage/Modules/WebVision)
7. Specials
   * [FLibComplex1](http://oscada.org/wiki/Special:MyLanguage/Modules/FLibComplex1)
   * [FLibMath](http://oscada.org/wiki/Special:MyLanguage/Modules/FLibMath)
   * [FLibSYS](http://oscada.org/wiki/Special:MyLanguage/Modules/FLibSYS)
   * [SystemTests](http://oscada.org/wiki/Special:MyLanguage/Modules/SystemTests)

## Image

Supported Docker registries:
- Official Docker Hub: [dudanov/openscada](https://hub.docker.com/r/dudanov/openscada)
- GitHub Containers Registry: [ghcr.io/dudanov/openscada](https://github.com/users/dudanov/packages/container/package/openscada)

Following platforms for this image are available:
- linux/amd64
- linux/arm/v7
- linux/arm64

Pulling latest images from Docker Hub:
```console
$ docker pull dudanov/openscada:latest
```
or from GitHub Containers Registry:
```console
$ docker pull ghcr.io/dudanov/openscada:latest
```

Example run command (start container `srv01-scada` with hostname `srv01` and project in `oscada_projects_volume/srv01` directory):
```console
$ docker run -d --name=srv01-scada --hostname=srv01 --restart=always -v oscada_projects_volume:/stations -p 6502:6502 dudanov/openscada:latest
```

## Environment variables

* `LANG`: Language (default: `ru_RU.UTF-8`)
* `TZ`: The timezone assigned to the container (default: `Europe/Samara`)
