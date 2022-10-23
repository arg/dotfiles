CREATE USER monica IDENTIFIED BY 'monica';
CREATE DATABASE monica;
GRANT ALL PRIVILEGES ON monica.* TO 'monica'@'%';

CREATE USER photoprism IDENTIFIED BY 'photoprism';
CREATE DATABASE photoprism;
GRANT ALL PRIVILEGES ON photoprism.* TO 'photoprism'@'%';

FLUSH PRIVILEGES;
