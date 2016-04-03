# На всякий случай
export HOME_USER=user
 
sudo service apache2 stop
 
sudo cat > /etc/apache2/envvars  <<EOF
# envvars - default environment variables for apache2ctl
 
# this won't be correct after changing uid
unset HOME
 
# for supporting multiple apache2 instances
if [ "\${APACHE_CONFDIR##/etc/apache2-}" != "\${APACHE_CONFDIR}" ] ; then
    SUFFIX="-\${APACHE_CONFDIR##/etc/apache2-}"
else
    SUFFIX=
fi
 
# Since there is no sane way to get the parsed apache2 config in scripts, some
# settings are defined via environment variables and then used in apache2ctl,
# /etc/init.d/apache2, /etc/logrotate.d/apache2, etc.
export APACHE_RUN_USER=$HOME_USER
export APACHE_RUN_GROUP=$HOME_USER
# temporary state file location. This might be changed to /run in Wheezy+1
export APACHE_PID_FILE=/var/run/apache2/apache2\$SUFFIX.pid
export APACHE_RUN_DIR=/var/run/apache2\$SUFFIX
export APACHE_LOCK_DIR=/var/lock/apache2\$SUFFIX
# Only /var/log/apache2 is handled by /etc/logrotate.d/apache2.
export APACHE_LOG_DIR=/home/\${APACHE_RUN_USER}/Web/log\$SUFFIX
 
## The locale used by some modules like mod_dav
export LANG=C
## Uncomment the following line to use the system default locale instead:
#. /etc/default/locale
 
export LANG
 
## The command to get the status for 'apache2ctl status'.
## Some packages providing 'www-browser' need '--dump' instead of '-dump'.
#export APACHE_LYNX='www-browser -dump'
 
## If you need a higher file descriptor limit, uncomment and adjust the
## following line (default is 8192):
#APACHE_ULIMIT_MAX_FILES='ulimit -n 65536'
 
## If you would like to pass arguments to the web server, add them below
## to the APACHE_ARGUMENTS environment.
#export APACHE_ARGUMENTS=''
 
## Enable the debug mode for maintainer scripts.
## This will produce a verbose output on package installations of web server modules and web application
## installations which interact with Apache
#export APACHE2_MAINTSCRIPT_DEBUG=1
EOF
 
sudo a2dissite 000-default
 
sudo cat > /etc/apache2/sites-available/000-default.conf  << EOF
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
 
    DocumentRoot /home/\${APACHE_RUN_USER}/Web/www/localhost
 
    <Directory /home/\${APACHE_RUN_USER}/Web/www/localhost>
      Options +Indexes +FollowSymLinks
      Order allow,deny
      Allow from all
      AllowOverride All
      Require all granted
    </Directory>
 
        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <Directory "/usr/lib/cgi-bin">
                AllowOverride None
                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all
        </Directory>
 
       
 
        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
 
sudo cat > /etc/apache2/sites-available/default-ssl.conf <<EOF
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerAdmin webmaster@localhost
 
        DocumentRoot /home/\${APACHE_RUN_USER}/Web/www/localhost
 
        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
 
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
 
        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
 
        #   SSL Engine Switch:
        #   Enable/Disable SSL for this virtual host.
        SSLEngine on
 
        #   A self-signed (snakeoil) certificate can be created by installing
        #   the ssl-cert package. See
        #   /usr/share/doc/apache2/README.Debian.gz for more info.
        #   If both key and certificate are stored in the same file, only the
        #   SSLCertificateFile directive is needed.
        SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem
        SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
 
        #   Server Certificate Chain:
        #   Point SSLCertificateChainFile at a file containing the
        #   concatenation of PEM encoded CA certificates which form the
        #   certificate chain for the server certificate. Alternatively
        #   the referenced file can be the same as SSLCertificateFile
        #   when the CA certificates are directly appended to the server
        #   certificate for convinience.
        #SSLCertificateChainFile /etc/apache2/ssl.crt/server-ca.crt
 
        #   Certificate Authority (CA):
        #   Set the CA certificate verification path where to find CA
        #   certificates for client authentication or alternatively one
        #   huge file containing all of them (file must be PEM encoded)
        #   Note: Inside SSLCACertificatePath you need hash symlinks
        #                to point to the certificate files. Use the provided
        #                Makefile to update the hash symlinks after changes.
        #SSLCACertificatePath /etc/ssl/certs/
        #SSLCACertificateFile /etc/apache2/ssl.crt/ca-bundle.crt
 
        #   Certificate Revocation Lists (CRL):
        #   Set the CA revocation path where to find CA CRLs for client
        #   authentication or alternatively one huge file containing all
        #   of them (file must be PEM encoded)
        #   Note: Inside SSLCARevocationPath you need hash symlinks
        #                to point to the certificate files. Use the provided
        #                Makefile to update the hash symlinks after changes.
        #SSLCARevocationPath /etc/apache2/ssl.crl/
        #SSLCARevocationFile /etc/apache2/ssl.crl/ca-bundle.crl
 
        #   Client Authentication (Type):
        #   Client certificate verification type and depth.  Types are
        #   none, optional, require and optional_no_ca.  Depth is a
        #   number which specifies how deeply to verify the certificate
        #   issuer chain before deciding the certificate is not valid.
        #SSLVerifyClient require
        #SSLVerifyDepth  10
 
        #   SSL Engine Options:
        #   Set various options for the SSL engine.
        #   o FakeBasicAuth:
        #        Translate the client X.509 into a Basic Authorisation.  This means that
        #        the standard Auth/DBMAuth methods can be used for access control.  The
        #        user name is the \`one line' version of the client's X.509 certificate.
        #        Note that no password is obtained from the user. Every entry in the user
        #        file needs this password: \`xxj31ZMTZzkVA'.
        #   o ExportCertData:
        #        This exports two additional environment variables: SSL_CLIENT_CERT and
        #        SSL_SERVER_CERT. These contain the PEM-encoded certificates of the
        #        server (always existing) and the client (only existing when client
        #        authentication is used). This can be used to import the certificates
        #        into CGI scripts.
        #   o StdEnvVars:
        #        This exports the standard SSL/TLS related \`SSL_*' environment variables.
        #        Per default this exportation is switched off for performance reasons,
        #        because the extraction step is an expensive operation and is usually
        #        useless for serving static content. So one usually enables the
        #        exportation for CGI and SSI requests only.
        #   o OptRenegotiate:
        #        This enables optimized SSL connection renegotiation handling when SSL
        #        directives are used in per-directory context.
        #SSLOptions +FakeBasicAuth +ExportCertData +StrictRequire
        <FilesMatch "\.(cgi|shtml|phtml|php)$">
                SSLOptions +StdEnvVars
        </FilesMatch>
        <Directory /usr/lib/cgi-bin>
                SSLOptions +StdEnvVars
        </Directory>
 
        #   SSL Protocol Adjustments:
        #   The safe and default but still SSL/TLS standard compliant shutdown
        #   approach is that mod_ssl sends the close notify alert but doesn't wait for
        #   the close notify alert from client. When you need a different shutdown
        #   approach you can use one of the following variables:
        #   o ssl-unclean-shutdown:
        #        This forces an unclean shutdown when the connection is closed, i.e. no
        #        SSL close notify alert is send or allowed to received.  This violates
        #        the SSL/TLS standard but is needed for some brain-dead browsers. Use
        #        this when you receive I/O errors because of the standard approach where
        #        mod_ssl sends the close notify alert.
        #   o ssl-accurate-shutdown:
        #        This forces an accurate shutdown when the connection is closed, i.e. a
        #        SSL close notify alert is send and mod_ssl waits for the close notify
        #        alert of the client. This is 100% SSL/TLS standard compliant, but in
        #        practice often causes hanging connections with brain-dead browsers. Use
        #        this only for browsers where you know that their SSL implementation
        #        works correctly.
        #   Notice: Most problems of broken clients are also related to the HTTP
        #   keep-alive facility, so you usually additionally want to disable
        #   keep-alive for those clients, too. Use variable "nokeepalive" for this.
        #   Similarly, one has to force some clients to use HTTP/1.0 to workaround
        #   their broken HTTP/1.1 implementation. Use variables "downgrade-1.0" and
        #   "force-response-1.0" for this.
        BrowserMatch "MSIE [2-6]" \
                nokeepalive ssl-unclean-shutdown \
                downgrade-1.0 force-response-1.0
        # MSIE 7 and newer should be able to use keepalive
        BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown
 
    </VirtualHost>
</IfModule>
 
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF
 
sudo a2ensite 000-default
 
sudo mkdir /home/$HOME_USER/Web
sudo mkdir /home/$HOME_USER/Web/www
sudo mkdir /home/$HOME_USER/Web/www/localhost
sudo mkdir /home/$HOME_USER/Web/log
sudo mkdir /home/$HOME_USER/Web/debug/
sudo mkdir /home/$HOME_USER/Web/debug/profiler
sudo mkdir /home/$HOME_USER/Web/debug/trace
 
sudo service apache2 start
