# docker-openscada

[![Build Image](https://github.com/dudanov/docker-openscada/actions/workflows/build.yml/badge.svg)](https://github.com/dudanov/docker-openscada/actions/workflows/build.yml)
[![Docker Hub](https://ghcr-badge.egpl.dev/dudanov/openscada/size?label=Image%20Size&color=dodgerblue)](https://github.com/users/dudanov/packages/container/package/openscada)
[![Docker Hub](https://ghcr-badge.egpl.dev/dudanov/openscada/latest_tag?trim=major&label=GitHub%20Version&color=dodgerblue)](https://github.com/users/dudanov/packages/container/package/openscada)
[![Docker Hub](https://img.shields.io/docker/v/dudanov/openscada?label=Docker%20Hub%20Version&color=dodgerblue)](https://hub.docker.com/r/dudanov/openscada)
[![Docker Hub](https://img.shields.io/docker/stars/dudanov/openscada?label=Docker%20Hub%20Stars&color=dodgerblue)](https://hub.docker.com/r/dudanov/openscada)

This repository is used for automated building of [OpenSCADA](http://oscada.org) minimal docker image.

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

### Included modules
<table>
    <thead align="center">
        <tr>
            <th align="center">Subsystem</th>
            <th align="center">Module</th>
            <th align="center">In core</th>
        </tr>
    </thead>
    <tbody align="center">
        <tr>
            <td rowspan=5>BD</td>
            <td><a title="Allows to locate databases of the remote OpenSCADA stations to local ones." href="http://oscada.org/wiki/Special:MyLanguage/Modules/DBGate">DBGate</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides support of directories by LDAP." href="http://oscada.org/wiki/Special:MyLanguage/Modules/LDAP">LDAP</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides support of the DBMS MySQL." href="http://oscada.org/wiki/Special:MyLanguage/Modules/MySQL">MySQL</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides support of the DBMS PostgreSQL." href="http://oscada.org/wiki/Special:MyLanguage/Modules/PostgreSQL">PostgreSQL</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides support of the BD SQLite." href="http://oscada.org/wiki/Special:MyLanguage/Modules/SQLite">SQLite</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td rowspan=2>Transport</td>
            <td><a title="Provides sockets based transport. Support network and UNIX sockets. Network socket supports TCP, UDP and RAWCAN protocols." href="http://oscada.org/wiki/Special:MyLanguage/Modules/Sockets">Sockets</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides transport based on the secure sockets layer. OpenSSL is used and SSLv3, TLSv1, TLSv1.1, TLSv1.2, DTLSv1, DTLSv1_2 are supported." href="http://oscada.org/wiki/Special:MyLanguage/Modules/SSL">SSL</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td rowspan=5>Protocol</td>
            <td><a title="Provides support for the HTTP protocol for WWW-based user interfaces." href="http://oscada.org/wiki/Special:MyLanguage/Modules/HTTP">HTTP</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides implementation of the ModBus protocols. ModBus/TCP, ModBus/RTU and ModBus/ASCII protocols are supported." href="http://oscada.org/wiki/Special:MyLanguage/Modules/ModBus">ModBus</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides the protocol OPC-UA implementing into parts of client and server, as a separated library." href="http://oscada.org/wiki/Special:MyLanguage/Modules/OPC_UA">OPC_UA</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides own OpenSCADA protocol based at XML and the control interface of OpenSCADA." href="http://oscada.org/wiki/Special:MyLanguage/Modules/SelfSystem">SelfSystem</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides for creating your own user protocols on internal OpenSCADA language." href="http://oscada.org/wiki/Special:MyLanguage/Modules/UserProtocol">UserProtocol</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td rowspan=10>DAQ</td>
            <td><a title="Provides a block calculator." href="http://oscada.org/wiki/Special:MyLanguage/Modules/BlockCalc">BlockCalc</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Allows to locate data sources of the remote OpenSCADA stations to local ones." href="http://oscada.org/wiki/Special:MyLanguage/Modules/DAQGate">DAQGate</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides an implementation of DCON-client protocol. Supports I-7000 DCON protocol." href="http://oscada.org/wiki/Special:MyLanguage/Modules/DCON">DCON</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides a calculator and libraries engine on the Java-like language. The user can create and modify functions and their libraries." href="http://oscada.org/wiki/Special:MyLanguage/Modules/JavaLikeCalc">JavaLikeCalc</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides the pure logical level of the DAQ parameters." href="http://oscada.org/wiki/Special:MyLanguage/Modules/LogicLev">LogicLev</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides implementation of the ModBus protocols. ModBus/TCP, ModBus/RTU and ModBus/ASCII protocols are supported." href="http://oscada.org/wiki/Special:MyLanguage/Modules/ModBus">ModBus</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides the protocol OPC-UA implementing into parts of client and server, as a separated library." href="http://oscada.org/wiki/Special:MyLanguage/Modules/OPC_UA">OPC_UA</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides for support of data sources of Siemens PLCs by means of Hilscher CIF cards (using the MPI protocol) and LibnoDave library (or the own implementation) for the rest. Also there is supported the data sources of the firm Beckhoff for the protocol TwinCAT ADS/AMS due it working with data blocks also." href="http://oscada.org/wiki/Special:MyLanguage/Modules/Siemens">Siemens</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides an implementation of the client of SNMP-service." href="http://oscada.org/wiki/Special:MyLanguage/Modules/SNMP">SNMP</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides data acquisition from the OS. Supported OS Linux data sources: Uptime, Memory, CPU, etc." href="http://oscada.org/wiki/Special:MyLanguage/Modules/System">System</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td rowspan=2>Archive</td>
            <td><a title="The archiver module. Provides functions for messages and values archiving to DB." href="http://oscada.org/wiki/Special:MyLanguage/Modules/DBArch">DBArch</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="The archiver module. Provides functions for messages and values archiving to the file system." href="http://oscada.org/wiki/Special:MyLanguage/Modules/FSArch">FSArch</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td rowspan=4>UI</td>
            <td><a title="The main engine of the visual control area." href="http://oscada.org/wiki/Special:MyLanguage/Modules/VCAEngine">VCAEngine</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides the WEB-based configurator of OpenSCADA. The technologies are used: XHTML, CSS and JavaScript." href="http://oscada.org/wiki/Special:MyLanguage/Modules/WebCfgD">WebCfgD</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides for creating your own web-pages on internal OpenSCADA language." href="http://oscada.org/wiki/Special:MyLanguage/Modules/WebUser">WebUser</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Visual operation user interface, based on the WEB — front-end to the VCA engine." href="http://oscada.org/wiki/Special:MyLanguage/Modules/WebVision">WebVision</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
        <tr>
            <td rowspan=4>Special</td>
            <td><a title="Provides a library of the functions of compatibility with SCADA Complex 1 of the firm DIYA Ltd." href="http://oscada.org/wiki/Special:MyLanguage/Modules/FLibComplex1">FLibComplex1</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides a library of the standard mathematical functions." href="http://oscada.org/wiki/Special:MyLanguage/Modules/FLibMath">FLibMath</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides a library of the system functions of the user programming area of OpenSCADA." href="http://oscada.org/wiki/Special:MyLanguage/Modules/FLibSYS">FLibSYS</a></td>
            <td><ul><li>[x] </li></ul></td>
        </tr>
        <tr>
            <td><a title="Provides the group of tests to OpenSCADA and its modules." href="http://oscada.org/wiki/Special:MyLanguage/Modules/SystemTests">SystemTests</a></td>
            <td><ul><li>[ ] </li></ul></td>
        </tr>
    </tbody>
</table>

