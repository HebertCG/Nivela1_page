#!/bin/bash

# Configurar el puerto para Tomcat
# Railway proporciona la variable $PORT dinámicamente
if [ -n "$PORT" ]; then
    echo "Configurando Tomcat para usar puerto $PORT"
    sed -i "s/8080/$PORT/g" /usr/local/tomcat/conf/server.xml
fi

# Iniciar Tomcat
exec catalina.sh run
