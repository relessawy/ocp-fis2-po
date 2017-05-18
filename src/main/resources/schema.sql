drop table if exists orders;

create table orders (
  id integer NOT NULL AUTO_INCREMENT,
  item varchar(50) NOT NULL,
  price float,
  quantity integer,
  description varchar(30),
  cname varchar(30) NOT NULL,
  dcode varchar(10),
  origin varchar(15) NOT NULL DEFAULT 'Web',
  primary key (id)
);
