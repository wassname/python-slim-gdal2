##
# wassname/python-slim-gdal2
#
# This create a gdal2 image based on python:X-slim
FROM python:3.5.3-slim

# first install gdal
ENV ROOTDIR /usr/local/
ENV GDAL_VERSION 2.1.0

# Load assets
WORKDIR $ROOTDIR/

# Install basic dependencies
RUN apt-get update -y && apt-get install -y \
    software-properties-common \
    python-software-properties \
    build-essential \
    python-dev \
    python-numpy \
    libspatialite-dev \
    sqlite3 \
    libpq-dev \
    libcurl4-gnutls-dev \
    libproj-dev \
    libxml2-dev \
    libgeos-dev \
    libnetcdf-dev \
    libpoppler-dev \
    libspatialite-dev \
    libhdf4-alt-dev \
    libhdf5-serial-dev \
    wget \
 && mkdir -p src && cd src && wget http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz \
 && tar -xvf gdal-${GDAL_VERSION}.tar.gz && cd gdal-${GDAL_VERSION} \
 && ./configure --with-python --with-spatialite --with-pg --with-curl \
 && make && make install && ldconfig \
 && apt-get remove -y --purge \
     software-properties-common \
     python-software-properties \
     build-essential \
     python-dev \
     python-numpy \
     libspatialite-dev \
     sqlite3 \
     libpq-dev \
     libcurl4-gnutls-dev \
     libproj-dev \
     libxml2-dev \
     libgeos-dev \
     libnetcdf-dev \
     libpoppler-dev \
     libspatialite-dev \
     libhdf4-alt-dev \
     libhdf5-serial-dev \
     wget \
 && rm -Rf $ROOTDIR/src/* \
 && rm -rf /var/lib/apt/lists/*

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
