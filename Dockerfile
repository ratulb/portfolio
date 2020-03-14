#       Copyright 2017 IBM Corp All Rights Reserved

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM openliberty/open-liberty:microProfile1

RUN groupadd -g 999 adminusr && \
   useradd -r -u 999 -g adminusr adminusr
RUN chown adminusr:adminusr -R /opt/ol /logs /config
USER 999

COPY --chown=adminusr mariadb-java-client-2.4.1.jar /config/mariadb-java-client-2.4.1.jar
ADD --chown=adminusr \
  http://repo1.maven.org/maven2/com/ibm/mq/wmq.jmsra/9.1.0.0/wmq.jmsra-9.1.0.0.rar \
  /config/wmq.jmsra.rar
COPY --chown=adminusr key.jks /config/resources/security/key.jks
COPY --chown=adminusr keystore.xml /config/configDropins/defaults/keystore.xml
COPY --chown=adminusr server.xml /config/server.xml
COPY --chown=adminusr target/portfolio-1.0-SNAPSHOT.war /config/apps/Portfolio.war
