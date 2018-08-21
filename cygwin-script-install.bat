@ECHO OFF
REM -- Automates cygwin installation
REM -- Source: Randy Lerma https://github.com/RandyRLerma/cygwin-script-install.git
REM -- Partially Based on: https://gist.github.com/wjrogers/1016065 and https://github.com/rtwolf/cygwin-auto-install 
 
SETLOCAL

ECHO ***********************************************
ECHO *****      SETTING INSTALLATION PATH      *****
ECHO ***********************************************
REM -- Create installation directory to execute this executing batch file. Configure paths.
MKDIR C:\cygwin\
SET SITE=http://cygwin.mirrors.pair.com/
SET ROOTDIR=C:/cygwin
CD %ROOTDIR%
ECHO *
ECHO *
REM -- Use Invoke-WebRequest to download latest cygwin
ECHO ***********************************************
ECHO *****      DOWNLOADING LATEST CYGWIN      *****
ECHO ***********************************************
%WINDIR%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "& {Invoke-WebRequest https://cygwin.com/setup-x86_64.exe -OutFile setup.exe;}"
ECHO *
ECHO *
ECHO ***********************************************
ECHO *****    SETTING INSTALLATION PACKAGES    *****
ECHO ***********************************************
REM -- These are the packages we will install as needed in your environments (in addition to the default packages you can add here what you need!)
SET PACKAGES=mintty,wget,ctags,diffutils,git,git-completion,git-svn,stgit,mercurial,_update-info-dir,binutils,bzip2,ca-certificates,crypt,csih,curl,cvs,cvsps,cygrunsrv,cygwin-devel,dejavu-fonts,diffutils,expect,font-adobe-dpi75,font-alias,font-encodings,font-misc-misc,fontconfig,gamin,git,git-cvs,git-gui,git-svn,gitk,groff,gsettings-desktop-schemas,less,libapr1,libaprutil1,libargp,libasn1_8,libattr1,libblkid1,libbz2_1,libcatgets1,libcom_err2,libcrypt0,libcurl4,libdb5.3,libedit0,libexpat1,libext2fs2,libfam0,libffi6,libfontconfig-common,libfontconfig1,libfontenc1,libfreetype6,libgcc1,libgdbm4,libglib2.0_0,libgmp10,libgssapi3,libgssapi_krb5_2,libheimbase1,libheimntlm0,libhx509_5,libICE6,libiconv,libiconv2,libidn11,libintl8,libiodbc2,libk5crypto3,libkafs0,libkrb5_26,libkrb5_3,libkrb5support0,liblzma5,libmetalink3,libmpfr4,libmysqlclient18,libncursesw10,libneon27,libnghttp2_14,libopenldap2_4_2,libp11-kit0,libpcre1,libpipeline1,libpng16,libpopt-common,libpopt0,libpq5,libproxy1,libpsl5,libroken18,libsasl2_3,libserf1_0,libsigsegv2,libSM6,libsmartcols1,libsqlite3_0,libssh2_1,libssp0,"libstdc++6",libtasn1_6,libunistring2,libuuid-devel,libuuid1,libwind0,libwrap0,libX11_6,libXau6,libXaw7,libxcb1,libXdmcp6,libXext6,libXft2,libXmu6,libXpm4,libXrender1,libXss1,libXt6,libyaml0_2,luit,lynx,man,mc,mkfontdir,mkfontscale,mysql-common,openssh,p11-kit,p11-kit-trust,popt,perl,perl-Carp,perl-DBD-SQLite,perl-DBI,perl-Error,perl-Scalar-List-Utils,perl-TermReadKey,perl-URI,perl-YAML,perl_autorebase,perl_base,python,python-tkinter,rsync,ruby,ruby-json,ruby-rake,ruby-rdoc,shared-mime-info,subversion,subversion-perl,subversion-python,subversion-ruby,subversion-tools,tcl,tcl-tix,tcl-tk,tcsh,texinfo,tzcode,unzip,vim,vim-common,wget,whois,xorg-x11-fonts-dpi75,xterm,xxd,xz,zip,zlib0
ECHO *
ECHO *
REM -- These are necessary for apt-cyg install. DO NOT CHANGE!! Duplicates will be ignored during cygwin installation process.
SET PACKAGES=%PACKAGES%,wget,tar,gawk,bzip2,subversion
ECHO *
ECHO * 
REM -- This will kick the installation of cygwin. 
REM -- "setup" is the downloaded cygwin installation binary renamed to 'setup.exe' 
ECHO ***********************************************
ECHO *****     INSTALLING DEFAULT PACKAGES     *****
ECHO ***********************************************
setup --quiet-mode --no-desktop --download --local-install --no-verify -s %SITE% -l "%ROOTDIR%" -R "%ROOTDIR%"
ECHO *
ECHO *
ECHO ***********************************************
ECHO *****     INSTALLING CUSTOM PACKAGES      *****
ECHO ***********************************************
setup -q -d -D -L -X -s %SITE% -l "%ROOTDIR%" -R "%ROOTDIR%" -P %PACKAGES%
ECHO *
ECHO * 
REM -- Provide the Installed Packages
ECHO ***********************************************
ECHO *****     CYGWIN INSTALLED PACKAGES       *****
ECHO ***********************************************
ECHO  - %PACKAGES%
ECHO *
ECHO *
ECHO ***********************************************
ECHO *****   CYGWING INSTALLATION COMPLETED    *****
ECHO ***********************************************
ECHO *
ECHO *
REM -- apt-cyg is a Cygwin package manager. It includes a command-line installer for Cygwin which cooperates with Cygwin Setup and uses the same repository.
REM -- apt-cyg source: https://github.com/transcode-open/apt-cyg
ECHO ***********************************************
ECHO ***** APT-CYG IS A CYGWIN PACKAGE MANAGER *****
ECHO *****    HIT ENTER TO INSTALL APT-CYG     *****
ECHO ***********************************************
PAUSE
ECHO *
ECHO *
ECHO ***********************************************
ECHO *****    INSTALLING APT-CYG  PACKAGES     *****
ECHO ***********************************************
ECHO *
ECHO *
set PATH=%ROOTDIR%/bin;%PATH%
%ROOTDIR%/bin/bash -l -c "%ROOTDIR%/bin/lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg"
%ROOTDIR%/bin/bash -l -c "%ROOTDIR%/bin/install apt-cyg /bin"
%ROOTDIR%/bin/bash -l -c "%ROOTDIR%/bin/apt-cyg --version"
ECHO ***********************************************
ECHO *****    APT-CYG INSTALLATION COMPLETED   *****
ECHO ***********************************************
ECHO *
ECHO *
ECHO ***********************************************
ECHO *****      INSTALLATION COMPLETED        *****
ECHO ***********************************************

ENDLOCAL
 
PAUSE
EXIT /B 0
