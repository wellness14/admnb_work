@echo off
set CLASSPATH=D:\MyProjects\apache-tomcat-9.0.8-windows-x64\apache-tomcat-9.0.8\lib\servlet-api.jar;D:\MyProjects\apache-tomcat-9.0.8-windows-x64\apache-tomcat-9.0.8\lib\log4j-1.2.17.jar
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\UserInfo.java
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\UserDB.java
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\Initializer.java
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\NoticeHeader.java
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\Notice.java
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\Tags.java
rem javac -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\Message.java

javac -Xlint -encoding UTF-8 -cp ..\WEB-INF\classes;%CLASSPATH% -d ..\WEB-INF\classes src\*.java
rem echo %ERRORLEVEL%
if %ERRORLEVEL%==0 goto RESTART
goto END

:RESTART
pushd ..\..\..\bin
call shutdown
timeout /t 2
call startup
popd

:END

