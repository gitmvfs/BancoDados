drop table address;
drop table bank_card;
drop table brand;
drop table buyer;
drop table comments;
drop table contain;
drop table credit_card;
drop table debit_card;
drop table oorder;
drop table order_item;
drop table payment;
drop table deliver_to;
drop table manage;
drop table After_Sales_Service_At;
drop table product;
drop table save_to_shopping_cart;
drop table seller;
drop table servicepoint;
drop table store;
drop table users;


drop database eshop_correcao;

create database eshop_correcao;
use eshop_correcao;


create table users(
userid int  NOT NULL PRIMARY KEY AUTO_INCREMENT, 
nome varchar(20), 
phoneNumber char(12)
);

create table brand(
brandname varchar(50) NOT NULL PRIMARY KEY
);

create table buyer(
fk_userid int  NOT NULL PRIMARY KEY  AUTO_INCREMENT,
foreign key (fk_userid) references users (userid)
);

create table seller(
fk_userid int  NOT NULL PRIMARY KEY  AUTO_INCREMENT,
foreign key (fk_userid) references users (userid)
);

create table bank_card(
cardnumber CHAR(16) NOT NULL PRIMARY KEY,
expirydate date NOT NULL,
bank varchar(20)
);

create table credit_card(
fk_cardnumber CHAR(16) NOT NULL PRIMARY KEY, 
fk_userid int  NOT NULL,
organizationn varchar(30),
foreign key (fk_cardnumber) references bank_card (cardnumber),
foreign key (fk_userid) references users (userid)
);

create table debit_card(
fk_cardnumber CHAR(16) NOT NULL PRIMARY KEY, 
fk_userid int NOT NULL,
foreign key (fk_cardnumber) references bank_card (cardnumber),
foreign key (fk_userid) references users (userid)
);

create table store(
sid int NOT NULL PRIMARY KEY, 
nome varchar(30) NOT NULL, 
province varchar(20) NOT NULL,
city varchar(40) NOT NULL,
streetaddr varchar(40),
customergrade int, 
starttime date
);

create table product (
pid int NOT NULL PRIMARY KEY, 
fk_sid int NOT NULL, 
fk_brand varchar(50) NOT NULL,
nome varchar(120) NOT NULL,
typee varchar(25), 
modelnumber varchar(50),
color varchar(15), 
amount int DEFAULT NULL,
price decimal(6,2),
foreign key (fk_sid) references store (sid),
foreign key (fk_brand) references brand (brandname)
);

create table order_item(
itemid int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
fk_pid int NOT NULL, 
price decimal(6,2), 
creationtime date NOT NULL,
foreign key (fk_pid) references product (pid)
);

create table Orders(
ordernumber int NOT NULL PRIMARY KEY, 
paymentstatus enum('paid', 'unpaid'),
creationtime date NOT NULL, 
totalamount decimal(10,2)
);

create table address(
addrid int NOT NULL PRIMARY KEY, 
fk_userid int NOT NULL, 
nome varchar(50), 
contactphonenumber varchar(20),
city varchar(50), 
province varchar(100), 
streetaddr varchar(100),
postalcode char(12), 
foreign key (fk_userid) references users (userid)
);

create table comments(
creationtime date NOT NULL,
fk_userid int NOT NULL,
fk_pid int NOT NULL,
grade float,
content varchar(500),
primary key(creationtime, fk_userid, fk_pid),
foreign key (fk_userid) references users (userid),
foreign key (fk_pid) references product (pid)
);

create table servicePoint(
spid int NOT NULL PRIMARY KEY,
streetaddr varchar(100),
city varchar(40),
province varchar(50),
starttime varchar(20),
endtime varchar(20)
);

create table Save_to_Shopping_Cart(
fk_userid int NOT NULL,
fk_pid int NOT NULL,
addtime date NOT NULL,
quantity int,
primary key(fk_userid, fk_pid),
foreign key (fk_userid) references buyer (fk_userid),
foreign key (fk_pid) references product (pid)
);

create table Contain(
fk_ordernumber int NOT NULL,
fk_itemid int NOT NULL,
quantity int,
primary key(fk_orderNumber, fk_itemid),
foreign key (fk_ordernumber) references Orders (ordernumber),
foreign key (fk_itemid) references order_item (itemid)
);

create table Payment(
fk_ordernumber int NOT NULL,
fk_cardnumber CHAR(16) NOT NULL,
payTime date,
primary key(fk_ordernumber, fk_cardnumber),
foreign key (fk_ordernumber) references Orders (ordernumber),
foreign key (fk_cardnumber) references bank_card (cardnumber)
);

create table deliver_to(
fk_addrid int NOT NULL,
fk_ordernumber int NOT NULL,
timedelivered date,
primary key(fk_addrid, fk_ordernumber),
foreign key (fk_ordernumber) references Orders (ordernumber),
foreign key (fk_addrid) references address (addrid)
);

create table Manage(
fk_userid int  NOT NULL,
fk_sid int NOT NULL,
setuptime date,
primary key(fk_userid, fk_sid),
foreign key (fk_userid) references seller (fk_userid),
foreign key (fk_sid) references store (sid)
);

create table After_Sales_Service_At( 
fk_brandName varchar(20) NOT NULL,
fk_spid int NOT NULL,
primary key(fk_brandName, fk_spid),
foreign key (fk_brandname) references brand (brandname),
foreign key (fk_spid) references servicePoint (spid)
);



