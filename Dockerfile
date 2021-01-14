FROM ubuntu:20.04

# Seteamos la variable del timezone
# para que el sistema no nos pregunte por
# la zona.
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Instalamos todas las dependencias necesarias para instalar
# snowmix
RUN apt update && apt install -y build-essential automake make autoconf libtool g++ pkg-config \
  bc libpng-dev libsdl1.2-dev libpango1.0-dev tcl-dev tcl tk \
  bwidget liborc-0.4-dev libosmesa6-dev freeglut3-dev

RUN apt install -y python3-dev libpython3-dev

RUN apt install -y gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-alsa

# Seteamos el workdir a snowmix
WORKDIR /snowmix
COPY Snowmix-0.5.1.1.tar.gz .

#
# TODO: Ver si puedo bajarme los paquetes de gstreamer que comentan
# en la web de Snowmix
#
#RUN ./autogen.sh && \
#  make && \
#  make install && \
#  ldconfig
#
RUN tar -xvzf Snowmix-0.5.1.1.tar.gz && \
  cd Snowmix-0.5.1.1 && \
  aclocal && \
  autoconf && \
  libtoolize --force && \
  automake --add-missing && \
  ./configure --prefix=/usr/local && \
  make && \
  make install

ENV SNOWMIX_PREFIX=.snowmix
ENV SNOWMIX=/usr/local/lib/Snowmix-0.5.1.1
CMD snowmix ./snowmix.ini
