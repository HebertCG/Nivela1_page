@echo off
REM Script para ejecutar el proyecto fácilmente
echo ========================================
echo   Ejecutando PAGINA_WEB con Tomcat 10
echo ========================================
echo.
echo Compilando y arrancando servidor...
echo.

cd /d "%~dp0"

REM Usar el Maven de NetBeans con Cargo plugin (Tomcat 10)
set MAVEN_CMD="C:\Program Files\NetBeans-20\netbeans\java\maven\bin\mvn.cmd"

%MAVEN_CMD% clean cargo:run

pause
