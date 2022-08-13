FROM alpine:3.13.4

ARG WORDPRESS_URL=localhost/wordpress
ARG WORDPRESS_SITE_TITLE=Born2Code
ARG WORDPRESS_ADMIN_NAME=gunkim
ARG WORDPRESS_ADMIN_EMAIL=papawolf@kakao.com
ARG WORDPRESS_ADMIN_PASSWORD=password

ARG WORDPRESS_DATABASE=wordpress
ARG WORDPRESS_DATABASE_USER=gunkim
ARG WORDPRESS_DATABASE_PASS=password
ARG WORDPRESS_DATABASE_HOST=mariadb:3306

ARG WP_PATH=/var/www/html

RUN apk --no-cache upgrade && apk add \
	mariadb-client \
	php7 \
	php-fpm \
	php7-phar \
	php7-json \
	php-mysqli \
	wget

WORKDIR $WP_PATH
RUN wget -O wordpress.tar.gz https://wordpress.org/wordpress-5.7.tar.gz; \
	wget -O phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz;

RUN	mkdir wordpress; \
    chown -R www-data:www-data wordpress; \
	tar xvzf wordpress.tar.gz --directory ./wordpress --strip 1; \
	rm wordpress.tar.gz; \
	cp wordpress/wp-config-sample.php wordpress/wp-config.php; \
	sed -i "s/database_name_here/$WORDPRESS_DATABASE/g" wordpress/wp-config.php; \
	sed -i "s/username_here/$WORDPRESS_DATABASE_USER/g" wordpress/wp-config.php; \
	sed -i "s/password_here/$WORDPRESS_DATABASE_PASS/g" wordpress/wp-config.php; \
	sed -i "s/localhost/$WORDPRESS_DATABASE_HOST/g" wordpress/wp-config.php; \
	wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp/; \
	chmod +x /tmp/wp-cli.phar; \
	mv /tmp/wp-cli.phar /usr/local/bin/wp;


# RUN	mysql start; \
# RUN	wp core install --url=${WORDPRESS_URL} --title=${WORDPRESS_SITE_TITLE} --admin_name=${WORDPRESS_ADMIN_NAME} --admin_email=${WORDPRESS_ADMIN_EMAIL} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --allow-root --path='/var/www/html/wordpress' --quiet;
# 	wp theme install retrogeek --activate --allow-root --path=/var/www/html/wordpress --quiet; \
# 	wp theme delete twentysixteen --allow-root --path=/var/www/html/wordpress --quiet; \
# 	wp theme delete twentynineteen --allow-root --path=/var/www/html/wordpress --quiet; \
# 	wp theme delete twentytwenty --allow-root --path=/var/www/html/wordpress --quiet; \
# 	wp search-replace 'Just another WordPress site' 'Welcome to my first server' --allow-root --path=/var/www/html/wordpress --quiet; \
# 	wp search-replace 'Hello world!' "Don't Panic" --allow-root --path=/var/www/html/wordpress --quiet; \
# 	wp search-replace 'Welcome to WordPress. This is your first post. Edit or delete it, then start writing!' "Fasten your seat belt now! We are leaving soon!" --allow-root --path=/var/www/html/wordpress --quiet; \
# 	mysql stop; \

COPY ./run.sh /scripts/
RUN chmod -R 755 /scripts

ENTRYPOINT ["/scripts/run.sh"]
