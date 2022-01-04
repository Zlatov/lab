
```sh
a2ensite lab.local.conf
a2dissite lab.local.conf
systemctl reload apache2
```

## Усановка

<pre class="prettyprint lang-sh">
sudo apt-get update
sudo apt-get install apache2
</pre>

<h2>Модули и нстройки</h2>
<h3>Где логи и настройки</h3>
<p><strong>Настройки</strong></p>
<p><code class="copyToClipboard">/etc/apache2/apache2.conf</code></p>
<p><code>/etc/apache2/sites-available/*.conf</code> файлы настроек виртуальных хостов</p>
<p><strong>Логи</strong></p>
<p><code>/var/log/apache2/access.log</code></p>
<p><code>/var/log/apache2/error.log</code></p>
<p><code>/var/log/apache2/other_vhosts_access.log</code></p>


<h3>Установка php5 mysql</h3>
<p>Теперь приконнектим к новоиспеченному апачу php5, вместе с библиотеками для работы с MySQL и графикой:</p>
<pre class="prettyprint lang-sh copyToClipboard">sudo apt-get install php5 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql php5-cli imagemagick mysql-server php5-gd php5-imagick</pre>
<p>Кстати, еще модуль <mark>php5-mysqlnd</mark> вместо <mark>php5-mysql</mark> для поддержки типа данных integer извлекаемых данных (с помощью PDO библиотеки PHP)</p>
<pre class="prettyprint lang-sh">
sudo apt-get install php5-mysqlnd
sudo service apache2 restart
</pre>

<p>владелец директорий - root-пользователь. Если мы хотим, чтобы обычные пользователи могли изменять файлы в веб-директориях, мы можем изменить их владельца:</p>
<pre>sudo chown -R $USER:$USER /var/www/example.com/public_html</pre>
<p>так же необходимо немного отредактировать права доступа, чтобы убедиться, что доступ на чтение разрешен к общей веб-директории и всем файлам и папкам, содержащимся в ней</p>
<pre>sudo chmod -R 755 /var/www</pre>

<p>а лучше</p>
<pre>sudo find dir/ -type d -exec chmod 755 {} \;
sudo find dir/ -type f -exec chmod 644 {} \;</pre>

<p>и еще лучше:</p>

<pre>sudo find . -type d ! -perm 755 -exec chmod 755 {} \;
sudo find . -type f ! -perm 644 -exec chmod 644 {} \;</pre>




<h3>Создание файлов виртуального хоста</h3>
<p>создаем и редактируем файл <code>/etc/apache2/sites-available/test.loc.conf</code></p>
<pre>
&lt;VirtualHost *:80>

	ServerName test.loc
	ServerAlias test.loc www.test.loc

	ServerAdmin zlatov@test.loc
	
	DocumentRoot /media/yadfeshhm/PROJECTS/my/test.loc/www
	
	&lt;Directory /media/yadfeshhm/PROJECTS/my/test.loc/www>
		#Options Indexes FollowSymLinks MultiViews
		#AllowOverride None
		#Order allow,deny
		#allow from all

		#Require all granted
		
		Options Indexes FollowSymLinks Includes
		AllowOverride All
		Order deny,allow
		Allow from all

	&lt;/Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

&lt;/VirtualHost>
</pre>

<p>Включение новых виртуальных хостов (a2ensite, a2dissite)</p>
<pre>sudo a2ensite test.loc.conf</pre>
<p>После необходимо перезапустить Apache, чтобы изменения вступили в силу</p>
<pre>sudo service apache2 restart</pre>

	
<p><code class="copyToClipboard">sudo nano /etc/hosts</code></p>
<p><code class="copyToClipboard">127.0.0.1	test.loc</code></p>

<hr>

<pre class="copyToClipboard">
&lt;VirtualHost *:80&gt;
	ServerName new.zenonline.local
	ProxyPreserveHost On
	ProxyPass / http://localhost:3001/
	ProxyPassReverse / http://localhost:3001/

	&lt;IfModule mod_rewrite.c&gt;
		RewriteEngine on
		RewriteRule ^.htaccess$ - [F]
		RewriteCond %{REQUEST_URI} ^/admin/files/strict_color.*$
		RewriteRule ^(.*)$ http://new.zenonline.ru$1 [R=301,L]
	&lt;/IfModule&gt;
&lt;/VirtualHost&gt;
</pre>

<hr>
<p>Не работает команда chmod или запись на NTFS пользователем</p>
<p>Нужно монтировать с опцией umask=0</p>
<p>NTFS не поддерживает разграничение прав пользователей в формате UNIX (всегда будет 700).</p>

<h3>Настройка базовой аутентификации</h3>
<h4>В виртуальном хосте</h4>
<pre>
&lt;VirtualHost *:80&gt;
	ServerName admin.zenonline.local
	ProxyPreserveHost On
	ProxyPass / http://localhost:3000/
	ProxyPassReverse / http://localhost:3000/
	&lt;Directory &quot;/home/iadfeshchm/projects/zenon/newforum/newforum&quot;&gt;
        AuthType Basic
        AuthName &quot;Restricted Content&quot;
        AuthUserFile /etc/apache2/sites-available/.htpasswd
        Require valid-user
	&lt;/Directory&gt;
&lt;/VirtualHost&gt;
</pre>
<h4>При проксировании</h4>
<!--
<VirtualHost *:80>
	ServerName admin.zenonline.local
	ProxyPreserveHost On
	ProxyPass / http://localhost:3000/
	ProxyPassReverse / http://localhost:3000/
	<Location />
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/sites-available/.htpasswd
        Require valid-user
	</Location>
</VirtualHost>
-->
<pre>
&lt;VirtualHost *:80&gt;
	ServerName admin.zenonline.local
	ProxyPreserveHost On
	ProxyPass / http://localhost:3000/
	ProxyPassReverse / http://localhost:3000/
	&lt;Location /&gt;
        AuthType Basic
        AuthName &quot;Restricted Content&quot;
        AuthUserFile /etc/apache2/sites-available/.htpasswd
        Require valid-user
	&lt;/Location&gt;
&lt;/VirtualHost&gt;
</pre>

<h3>Подключаем модуль Mod rewrite</h3>
<p>Перейдите в каталог /etc/apache2/mods-available и убедитесь, что там есть файл rewrite.load отвечающий за загрузку модуля Mod rewrite. Для этого выполните в консоли следующие команды:</p>

<pre>cd /etc/apache2/mods-available
ls</pre>
<p>В списке файлов должен присутствовать файл с именем rewrite.load.</p>

<p>Теперь перейдем в каталог /etc/apache2/mods-enabled и создадим символьную ссылку на файл rewrite.load. Для этого выполните команды:</p>

<pre>cd /etc/apache2/mods-enabled
sudo ln -s ../mods-available/rewrite.load rewrite.load</pre>


<p>Изменяем настройки виртуального хоста</p>

<pre>AllowOverride All</pre>

<p>и рестартим <code>udo service apache2 restart</code>.</p>

<h3>Проксирование, перенаправление порта</h3>
<p><strong>Добавление модуля proxy</strong></p>
<pre class="prettyprint lang-sh">
cd /etc/apache2/mods-available/
ls | grep prox
cd /etc/apache2/mods-enabled
sudo ln -s ../mods-available/proxy.load proxy.load
</pre>
<p><strong>Настройка перенаправления</strong></p>
<pre class="prettyprint lang-apache">
&lt;VirtualHost *:80&gt;
	ServerName admin.zenonline.local
	ProxyPreserveHost On
	ProxyPass / http://localhost:3000/
	ProxyPassReverse / http://localhost:3000/
&lt;/VirtualHost&gt; 
</pre>
<pre class="prettyprint lang-sh">
sudo service apache2 restart
</pre>
<p>Ошибка <code>No protocol handler was valid for the URL</code></p>
<pre class="prettyprint lang-sh">
sudo a2enmod proxy_http
sudo service apache2 restart
</pre>

<h3>After git clone</h3>
<pre>sudo chown -R iadfeshchm:www-data ./
sudo find . -type d ! -perm 775 -exec chmod 775 {} \;
sudo find . -type f ! -perm 664 -exec chmod 664 {} \;

0 000
1 001
2 010
3 011
4 100
5 101
6 110
7 111</pre>

<h2>Упарвление, параметры, настройки...</h2>
<h3>Старт/Стоп/Рестарт</h3>
<pre>/etc/init.d/apache2 {restart}{stop}{start}</pre>
<p>ну или что-то вроде</p>
<pre class="prettyprint lang-sh">
sudo service httpd &lt;restart|stop|start&gt;
sudo service apache2 &lt;restart|stop|start&gt;
</pre>
<h3>Узнать количество работающих виртуальных хостов</h3>
<pre>
# ... -S например что-то из этого:
httpd -S
apachectl -S
apache2 -S
apache2ctl -S
</pre>


<h2>Ошибки</h2>

<h3>AH00558: apache2: Could not reliably determine the server's fully qualified domain name...</h3>
<p>Добавляем строку в начало файла <code>/etc/apache2/apache2.conf</code> для того, чтобы избежать ошибки <code>AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message</code></p>
<pre>ServerName localhost</pre>


<h3>Ошибка AH01630: client denied by server configuration</h3>
<p>После обновления Ubuntu c 13.04 до 13.10 обновился и Apache до версии 2.4. Вместе с этим обновлением появилась ошибка: “AH01630: client denied by server configuration”, причём эта ошибка появилась в логах тех виртуальных хостов, на которых имелся файл .htaccess.</p>
<p>Решение этой проблемы следующее:</p>
<p>В конфигурационный файл виртуального хоста в секцию <code>&lt;Directory /></code> необходимо добавить строку</p>
<pre>Require all granted</pre>


<h3>Ошибка AH00035 because search permissions are missing on a component of the path ((13) Permission Denied)</h3>
<p><strong>Error 13 indicates a filesystem permissions problem. That is, Apache was denied access to a file or directory due to incorrect permissions. It does not, in general, imply a problem in the Apache configuration files.</strong> 
</p>
<p>In order to serve files, Apache must have the proper permission granted by the operating system to access those files. In particular, the
<tt>User</tt>
or
<tt>Group</tt>
specified in
<tt>httpd.conf</tt>
must be able to read all files that will be served and <em><strong>search the directory containing those files, along with all parent directories up to the root of the filesystem</strong></em>.</p>
<p>
	Typical permissions on a unix-like system for resources not owned by the
	<tt>User</tt>
	or
	<tt>Group</tt>
	specified in
	<tt>httpd.conf</tt>
	would be 644
	<tt>-rw-r--r--</tt>
	for ordinary files and 755
	<tt>drwxr-x-r-x</tt>
	for directories or CGI scripts. You may also need to check extended permissions (such as SELinux permissions) on operating systems that support them.
</p>
<p>
	If you are running 2.4, the AH error code may give you more information here.
</p>
<ul>
	<li>
		<p>
			<strong>AH00132</strong>
			: file permissions deny server access
		</p>
	</li>
	<li>
		<p>
			<strong>AH00035</strong>
			: access denied because search permissions are missing on a component of the path
		</p>
	</li>
</ul>
<p></p>
<p><strong>An Example</strong></p>
<p>
	Lets say that you received the
	<tt>Permission&nbsp;Denied</tt>
	error when accessing the file
	<tt>/usr/local/apache2/htdocs/foo/bar.html</tt>
	on a unix-like system.
</p>
<p>
	First check the existing permissions on the file:
</p>
<p>
	</p>
<pre>cd /usr/local/apache2/htdocs/foo
ls -l bar.htm</pre>
<p>
	Fix them if necessary:
</p>
<p>
</p>
<pre>chmod 644 bar.html</pre>
<p>
	Then do the same for the directory and each parent directory (
	<tt>/usr/local/apache2/htdocs/foo</tt>
	,
	<tt>/usr/local/apache2/htdocs</tt>
	,
	<tt>/usr/local/apache2</tt>
	,
	<tt>/usr/local</tt>
	,
	<tt>/usr</tt>
	):
</p>
<p>
	</p>
<pre>ls -la
chmod +x .
cd ..
# repeat up to the root</pre>
<p>
	On some systems, the utility
	<tt>namei</tt>
	can be used to help find permissions problems by listing the permissions along each component of the path:
</p>
<p>
</p>
<pre>namei -m /usr/local/apache2/htdocs/foo/bar.html</pre>
<p>
	If your system doesn't have namei, you can use parsepath. It can be obtained from
	<a>here</a>
	.
</p>
<p>
	If all the standard permissions are correct and you still get a
	<tt>Permission&nbsp;Denied</tt>
	error, you should check for extended-permissions. For example you can use the command
	<tt>setenforce&nbsp;0</tt>
	to turn off SELinux and check to see if the problem goes away. If so,
	<tt>ls&nbsp;-alZ</tt>
	can be used to view SELinux permission and
	<tt>chcon</tt>
	to fix them.
</p>
<p>
	In rare cases, this can be caused by other issues, such as a file permissions problem elsewhere in your apache2.conf file.   For example, a WSGIScriptAlias directive not mapping to an actual file.   The error message may not be accurate about which file was unreadable.
</p>
<p>
	<strong>DO NOT</strong>
	set files or directories to mode 777, even "just to test", even if "it's just a test server". The purpose of a test server is to get things right in a safe environment, not to get away with doing it wrong.  All it will tell you is if the problem is with files that actually exist.
</p>
<p></p>
<p><strong>CGI scripts</strong></p>
<p>
	Although the CGI script permission might look correct, the actual binary specified in the shebang might not have the proper permissions to be run. (Or some directory on its path, check with namei as explained above.)
</p>

<h3>Internal server error</h3>
<p>А в логах что-то в роде: <code>.htaccess: Invalid command 'RewriteEngine', perhaps misspelled or defined by a module not included in the server configuration</code> - тогда идем и ставим модуль Mod rewrite</p>







