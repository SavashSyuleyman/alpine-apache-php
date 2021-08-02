#!/bin/sh

# Change Server Admin, Name, Document Root
sed -i 's/#ServerAdmin\ you@example.com/ServerAdmin\ you@example.com/' /etc/apache2/httpd.conf && \
sed -i 's/#ServerName\ www.example.com:80/ServerName\ www.example.com:80/' /etc/apache2/httpd.conf && \
sed -i 's#^DocumentRoot ".*#DocumentRoot "/htdocs"#g' /etc/apache2/httpd.conf && \
sed -i 's#Directory "/var/www/localhost/htdocs"#Directory "/htdocs"#g' /etc/apache2/httpd.conf && \
sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf && \

# Change TransferLog after ErrorLog
sed -i 's#^ErrorLog .*#ErrorLog "/dev/stderr"\nTransferLog "/dev/stdout"#g' /etc/apache2/httpd.conf && \
sed -i 's#CustomLog .* combined#CustomLog "/dev/stdout" combined#g' /etc/apache2/httpd.conf && \

# SSL DocumentRoot and Log locations
sed -i 's#^ErrorLog .*#ErrorLog "/dev/stderr"#g' /etc/apache2/conf.d/ssl.conf && \
sed -i 's#^TransferLog .*#TransferLog "/dev/stdout"#g' /etc/apache2/conf.d/ssl.conf && \
sed -i 's#^DocumentRoot ".*#DocumentRoot "/htdocs"#g' /etc/apache2/conf.d/ssl.conf && \
sed -i 's/#ServerAdmin\ you@example.com/ServerAdmin\ you@example.com/' /etc/apache2/conf.d/ssl.conf && \
sed -i 's/#ServerName\ www.example.com:443/ServerName\ www.example.com:443/' /etc/apache2/conf.d/ssl.conf && \

# Re-define LogLevel
sed -i 's#^LogLevel .*#LogLevel info#g' /etc/apache2/httpd.conf && \

# Enable commonly used apache modules
sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf && \
sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf && \
sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf && \

# Modify php memory limit and timezone
sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php8/php.ini && \
sed -i "s/^;date.timezone =$/date.timezone = \"Europe\/Stockholm\"/" /etc/php8/php.ini
