FROM alpine AS builder

#ARG CFLAGS="-g -D__MUSL__"
ARG CFLAGS="-Os -DNODEBUG -fpic -ffunction-sections -Wl,--gc-sections -fno-asynchronous-unwind-tables -Wl,--strip-all"
ARG CPPFLAGS=${CFLAGS}
ARG CXXFLAGS=${CFLAGS}

RUN apk --no-cache add \
        # Build tools
        build-base \
        curl \
        gettext-dev \
        libtool \
        pcre-dev \
        pkgconf \
        sqlite \
        zlib-dev \
        # DB.SQLite
        sqlite-dev \
        # DB.MySQL
        mariadb-connector-c-dev \
        # DB.PostgreSQL
        libpq-dev \
        # DAQ.Siemens
        linux-headers \
        # DAQ.JavaLikeCalc
        bison \
        # UI.Vision, UI.WebVision, Special.FLibSYS
        fftw-dev \
        # DAQ.OPC_UA, Transport.SSL, Special.FLibSYS
        openssl-dev \
        # DB.LDAP
        openldap-dev \
        # DAQ.SNMP
        net-snmp-dev \
        # LibGD
        libpng-dev \
        libjpeg-turbo-dev \
    # Downloading sources and building latest LibGD
    && URL=$(curl -skSL 'https://api.github.com/repos/libgd/libgd/releases/latest' | sed -n '/url.*tar\.xz/{s/.*\(https:.*tar.xz\).*/\1/p}') \
    && curl -o /tmp/libgd.tar.xz -L "${URL}" \
    && mkdir -p /tmp/libgd \
    && tar  xf /tmp/libgd.tar.xz -C /tmp/libgd --strip-components=1 \
    && cd /tmp/libgd \
    && ./configure \
        --prefix=/usr \
        --without-x \
        --with-zlib \
        --with-png \
        --without-freetype \
        --without-raqm \
        --without-fontconfig \
        --with-jpeg \
        --without-liq \
        --without-xpm \
        --without-tiff \
        --without-webp \
        --without-heif \
        --without-avif \
    && make -j$(nproc) \
    && make install \
    # Downloading and extracting OpenSCADA sources
    && URL="http://ftp.oscada.org/OpenSCADA/Work" \
    && ARCHIVES=$(curl "${URL}/SrcTar.files") \
    && mkdir -p /tmp/openscada \
    && for fn in $ARCHIVES; do \
        curl -o "/tmp/$fn" "$URL/$fn" && { \
        [[ $fn == *-res-* ]]; \
        tar xf "/tmp/$fn" -C /tmp/openscada --strip-components=$?; }; \
    done; \
    # Patching OpenSCADA for build with musl LibC
    cd /tmp/openscada \
    && find . -name ieee754.h | while read fn; do \
        sed \
            -e 's/^__BEGIN_DECLS$/#ifdef __cplusplus\nextern "C" {\n#endif/g' \
            -e 's/^__END_DECLS$/#ifdef __cplusplus\n}\n#endif/g' \
            -i $fn; \
    done; \
    #sed -e '/^#include <ldap\.h>$/i #include <sys/time.h>' -i ./src/moduls/bd/LDAP/mod_ldap.cpp; \
    #sed -e '/^#include <stdint\.h>$/a #include <sys/types.h>' -i ./src/tsys.h; \
    #sed -e '/optDescr();/{n;x;d;};x;1d;p;${x;p;}' -n -i ./src/moduls/daq/FT3/FT3_prt.h; \
    #sed '/^#if !__GLIBC_PREREQ(2,4)$/ s/$/ || __MUSL__/' -i ./src/resalloc.h; \
    #sed '/^#if !__GLIBC_PREREQ(2,4)$/ s/$/ || __MUSL__/' -i ./src/resalloc.cpp; \
    # Building and installing OpenSCADA
    ./configure \
        --prefix=/app \
        --bindir=/app/bin \
        --libdir=/app/lib \
        --datadir=/app/share \
        --localedir=/app/locales \
        --sysconfdir=/stations \
        --disable-static \
        --disable-CoreLibVersion \
        --enable-LibGD \
        --enable-SQLite=incl \
        --enable-MySQL \
        --enable-PostgreSQL \
        --disable-FireBird \
        --disable-DBF \
        --enable-DBGate=incl \
        --disable-ODBC \
        --enable-LDAP \
        --enable-JavaLikeCalc=incl \
        --enable-LogicLev=incl \
        --enable-BlockCalc \
        --enable-DAQGate=incl \
        --enable-System \
        --enable-ModBus \
        --enable-DCON \
        --enable-OPC_UA \
        --disable-MMS \
        --enable-SNMP \
        --disable-ICP_DAS \
        --enable-Siemens \
        --disable-DiamondBoards \
        --disable-Comedi \
        --disable-SoundCard \
        --disable-BFN \
        --disable-SMH2Gi \
        --disable-AMRDevs \
        --disable-Fastwel \
        --disable-FT3 \
        --disable-GPIO \
        --enable-FSArch \
        --enable-DBArch \
        --enable-Sockets=incl \
        --enable-Serial=incl \
        --enable-SSL=incl \
        --enable-SelfSystem=incl \
        --enable-UserProtocol=incl \
        --enable-HTTP \
        --enable-VCAEngine \
        --disable-QTStarter \
        --disable-QTCfg \
        --disable-Vision \
        --disable-WebKit \
        --disable-Phonon \
        --disable-WebCfg \
        --enable-WebCfgD \
        --enable-WebVision \
        --enable-WebUser \
        --enable-FLibSYS=incl \
        --enable-SystemTests \
        --enable-FLibMath=incl \
        --enable-FLibComplex1=incl \
    && make -j$(nproc) \
    && make install \
    # Post-install shrinking
    && cd /app \
    && rm -rf /tmp/* \
    && rm -rf \
        etc \
        include \
        bin/openscada?* \
        share/applications \
        share/icons \
        share/openscada/AGLKS \
        share/openscada/Boiler \
        lib/pkgconfig \
    && find . -type f -name '*.la' -delete \
    && find . -type f -name '*.a' -delete \
    && cd share/openscada/icons \
    && rm -f \
        vision_*.png \
        AGLCS.png \
        AGLKS.png \
        BD.DBF.png \
        BD.FireBird.png \
        Boiler.png \
        DAQ.BFN.png \
        DAQ.Comedi.png \
        DAQ.DiamondBoards.png \
        DAQ.ICP_DAS.png \
        DAQ.SMH2Gi.png \
        DAQ.SoundCard.png \
        UI.QTCfg.png \
        UI.QTStarter.png \
        UI.Vision.png \
        UI.WebCfg.png \
        openscada_AGLKS.png \
        openscada_Boiler.png \
        АГЛКС.png \
        Котел.png

# Copy icons
COPY icons/ /app/share/openscada/icons/

# Final image
FROM alpine

RUN apk --no-cache add \
        libstdc++ \
        musl-locales \
        tzdata \
        pcre \
        libpcre16 \
        libpcre32 \
        zlib \
        libintl \
        sqlite-libs \
        mariadb-connector-c \
        libpq \
        libldap \
        libcrypto3 \
        net-snmp-libs \
        libssl3 \
        fftw-double-libs \
        libpng \
        libjpeg-turbo

# Copy builded minimal libgd
COPY --from=builder /usr/lib/libgd.so* /usr/lib/
# Copy OpenSCADA
COPY --from=builder /app/ /app/
# Set locale
ENV LANG=${LANG:-ru_RU.UTF-8}
# Set timezone
ENV TZ=${TZ:-Europe/Samara}

VOLUME /stations
WORKDIR /stations
# Run OpenSCADA. Disable project locking (PID is always 1, with --init - 7). System messages to stdout and message archive.
# Set project name to container hostname. Full path of the project (work) directory: "/stations/${HOSTNAME}".
ENTRYPOINT /app/bin/openscada --projUserDir=/stations --projName=${HOSTNAME} --projLock=0 --log=10
#ENTRYPOINT ["/app/bin/openscada", "--statName=station", "--config=/station/oscada.xml", "--projLock=0", "--log=10"]
