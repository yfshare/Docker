FROM docker.io/redmine
RUN apt-get update \
    && apt-get install -y subversion subversion-tools apache2 libapache2-svn apache2-utils vim \
    && useradd apache

RUN echo '' >/tmp/main
COPY configure /

VOLUME /usr/src/redmine/files

RUN echo "[ ! -d \${SVN_DIR} ] && svnadmin create \${SVN_DIR}" >>/tmp/redmine_svn.sh \
    && echo "[ -d /Authconf ] && mv /Authconf \${SVN_ROOT}/ && sed -i \"s#^password-db \= passwd#password-db \= \${SVN_ROOT}\/Authconf\/passwd#g\" \${SVN_ROOT}/Authconf/svnserve.conf && sed -i \"s#^authz-db \= authz#authz-db \= \${SVN_ROOT}\/Authconf\/authz#g\" \${SVN_ROOT}/Authconf/svnserve.conf && \mv \${SVN_ROOT}/Authconf/svnserve.conf \${SVN_DIR}/conf/" >> /tmp/redmine_svn.sh \
    && echo "[ -f /dav_svn.conf ] && mv /dav_svn.conf /etc/apache2/mods-enabled/ && sed -i \"s#SVNPath SVN_DIR#SVNPath \${SVN_DIR}#g\" /etc/apache2/mods-enabled/dav_svn.conf && sed -i \"s#Location \/svn#Location \/\`echo \${SVN_DIR} | awk -F '/' '{print \$NF}'\`#g\" /etc/apache2/mods-enabled/dav_svn.conf && sed -i \"/Include the virtual host configurations/aServerName localhost\:80\" /etc/apache2/apache2.conf" >> /tmp/redmine_svn.sh \
    && echo "[ -f /svnpass ] &&  mv /svnpass /etc/apache2/.svnpass" >> /tmp/redmine_svn.sh \
    && echo "[ -f /dav_svn.authz ]&& mv /dav_svn.authz /etc/apache2/ && sed -i \"s#SVN_DIR#\`echo \${SVN_DIR} | awk -F '/' '{print \$NF}'\`#g\" /etc/apache2/dav_svn.authz" >> /tmp/redmine_svn.sh \
    && echo "[ -f /configuration.yml ] && \mv /configuration.yml /usr/src/redmine/config && sed -i \"s#domain\: 'DOMAIN'#domain\: '\${REDMINE_MAIL_DOMAIN}'#g\" /usr/src/redmine/config/configuration.yml && sed -i \"s#address\: \\\"MAIL_ADDRESS\\\"#address\: \\\"\${REDMINE_MAIL_ADDRESS}\\\"#g\" /usr/src/redmine/config/configuration.yml && sed -i \"s#user_name\: 'MAILADDR'#user_name\: '\${REDMINE_MAIL_USER}'#g\" /usr/src/redmine/config/configuration.yml && sed -i \"s#password\: 'PASSWORD'#password\: '\${REDMINE_MAIL_PASSWD}'#g\" /usr/src/redmine/config/configuration.yml" >> /tmp/redmine_svn.sh \
    && echo "chown apache:apache \${SVN_ROOT} -R && chown apache:apache /etc/apache2 -R" >> /tmp/redmine_svn.sh \
    && echo "/etc/init.d/apache2 start &" >> /tmp/redmine_svn.sh \
    && echo "svnserve -d -r \${SVN_ROOT} --log-file \${SVN_ROOT}/svn.log &" >>/tmp/redmine_svn.sh \
    && echo "sleep 5 && /docker-entrypoint.sh rails server -b 0.0.0.0 &" >>/tmp/redmine_svn.sh \
    && echo "tail -f /tmp/main" >>/tmp/redmine_svn.sh \
    && chmod +x /tmp/redmine_svn.sh

EXPOSE 3000 3690 80

ENTRYPOINT ["/bin/sh","/tmp/redmine_svn.sh"]