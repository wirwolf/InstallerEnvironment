<?php
ini_set("error_reporting", E_ALL & ~E_DEPRECATED);
define('projects_dir',"www/");
define('apache_dir',"/etc/apache2/");
define('apache_config_www_folder',"/home/\${APACHE_RUN_USER}/Web/www/");
define('host_delimiter',"#------------------APACHE 2 HOSTS UPDATER---DONT MODIFY THIS BLOCK-----------------");



$doneHosts = [];
foreach (new DirectoryIterator(apache_dir.'sites-available/') as $fileInfo) {
    if(!$fileInfo->isDot() and !in_array($fileInfo->getFilename(),['default-ssl','default'])) {
        exec('a2dissite '.$fileInfo->getFilename());
        echo "Remote host:".$fileInfo->getFilename() . "\n";
        unlink($fileInfo->getPathname());
    }
}

foreach (new DirectoryIterator(projects_dir) as $fileInfo) {
    if($fileInfo->isDot()) continue;
    $hostName = $fileInfo->getFilename();
    $hostConfig = '
<VirtualHost *:80>
  ServerAdmin admin@localhost
  ServerName  '.$hostName.'
  ServerAlias '.$hostName.'

  DocumentRoot '.apache_config_www_folder.$hostName.'/

  <Directory '.apache_config_www_folder.$hostName.'>
    Options +Indexes +FollowSymLinks
    Order allow,deny
    Allow from all
    AllowOverride All
    Require all granted
  </Directory>

  # Custom log file locations
  LogLevel warn
  ErrorLog  ${APACHE_LOG_DIR}/'.$hostName.'-error.log
  CustomLog ${APACHE_LOG_DIR}/'.$hostName.'-access.log combined

</VirtualHost>
';
    if(
        file_put_contents(apache_dir.'sites-available/'.$hostName.'.conf',$hostConfig) &&
        exec('a2ensite '.$hostName)
    )
    {
        echo "Add host:".$fileInfo->getFilename() . "\n";
        $doneHosts[] = $hostName;
    }
}

exec('service apache2 restart');

$hostsContent = explode("\n",file_get_contents('/etc/hosts'));
if($hostsContent[0]!== host_delimiter)
{
    array_unshift($hostsContent,
        host_delimiter,
        "127.0.0.1\t".implode(' ',$doneHosts),
        host_delimiter
    );
}
else
{
    $hostsContent[1] = "127.0.0.1\t".implode(' ',$doneHosts);
}
if(file_put_contents('/etc/hosts',implode("\n",$hostsContent)))
{
    echo "Host updated\n";
}
