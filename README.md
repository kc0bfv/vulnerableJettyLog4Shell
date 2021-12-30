# Jetty Vulnerable to Log4Shell

This is a configuration of the [Jetty webserver](https://github.com/kc0bfv/log4j_range) that's vulnerable to log4shell.  The docker image is published here: https://hub.docker.com/repository/docker/kc0bfv/vulnerablejettylog4shell

This gets used by the [log4j range project](https://github.com/kc0bfv/log4j_range).

It uses Jetty 11.0.7, and the v2.14.1 log4j libraries.

It uses openjdk 11, which actually has a mitigation for opening remote LDAP code... So this project disables that in the Dockerfile.

# Running

`docker run -d -p 8080:8080 --name jetty -t kc0bfv/vulnerablejettylog4shell`

If you've got Docker installed in Linux, that will start up a vulnerable Jetty instance on port 8080.

# License

Eclipse Jetty 11 is dual licensed under the Apache License 2.0 and Eclipse Public License 2.0.

Log4j is licensed under Apache License 2.0.

This project is under Apache License 2.0 too for simplicity's sake.
