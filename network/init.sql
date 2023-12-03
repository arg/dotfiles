CREATE USER monica IDENTIFIED BY 'monica';
CREATE DATABASE monica;
GRANT ALL PRIVILEGES ON monica.* TO 'monica'@'%';

CREATE USER freshrss IDENTIFIED BY 'freshrss';
CREATE DATABASE freshrss;
GRANT ALL PRIVILEGES ON freshrss.* TO 'freshrss'@'%';

FLUSH PRIVILEGES;
