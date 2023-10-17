CREATE DATABASE eshop;

USE eshop;

CREATE TABLE  IF NOT EXISTS users(
userid 	varchar(5) primary key,
name	varchar(40) NOT NULL,				
phoneNumber char(12) NOT NULL
);

CREATE TABLE IF NOT EXISTS buyer(
	userid varchar(5), 
    foreign key (userid)  references users(userid)
);

CREATE TABLE IF NOT EXISTS seller(
	userid varchar(5), 
    foreign key (userid)  references users(userid)
);

CREATE TABLE IF NOT EXISTS address(
	addrid varchar(5),
    userid varchar(5),
	name varchar(40),
    contactPhoneNumber char(12),
    city varchar(30),
    province varchar(30),
    street varchar(40),
    postalCode char(7),
    
    foreign key (userid)  references users(userid)
);

alter table address modify addrid varchar(5) primary key;

CREATE TABLE IF NOT EXISTS creditcard(
	cardnumber char(19) primary key,
    userid varchar(5),
    organization varchar(20),
    
    foreign key (userid)  references users(userid)
);

CREATE TABLE IF NOT EXISTS debitcard(
	cardnumber char(19) primary key,
    userid varchar(5),
    
    foreign key (userid)  references users(userid)
);

CREATE TABLE IF NOT EXISTS bankcard(
	cardNumber char(15) primary key,
	expirydate char(9) NOT NULL,
    bank varchar(25) not null
);

CREATE TABLE IF NOT EXISTS store(
	sid varchar(5) primary key ,
    name varchar(40) not null,
    province varchar(40) not null,
    city varchar(40) not null,
    streetAddr varchar(40) not null,
    customerGrade int not null default 5,
    startTime date not null,
    
    check(customerGrade > 0 and customerGrade < 6)
    
);

CREATE TABLE IF NOT EXISTS Brand(
	brandName varchar(40) primary key
);

CREATE TABLE IF NOT EXISTS ServicePoint (
	spid varchar(5) primary key,
    streetAddr varchar(40) not null,
    city varchar(40) not null,
    province varchar(40) not null,
    startTime varchar(10) not null,
    endTime varchar(10) not null
    
);

CREATE TABLE IF NOT EXISTS Product(
	pid varchar(5) primary key,
    sid varchar(5) not null,
    brand varchar(40) not null,
    name varchar(50) not null,
	type varchar(40) not null,
    modelNumber varchar(30) not null,
    color varchar(25) not null,
	amount int not null,
    price decimal (8,3),
    
    
    foreign key (sid) references store(sid)
    
);

alter table Product modify
	name varchar(100) not null;

CREATE TABLE IF NOT EXISTS OrderItem (
	itemid varchar(5) primary key,
    pid varchar(5) not null,
    price decimal(8,3),
    creationTime date not null,
    
    foreign key (pid) references Product(pid)

);

CREATE TABLE IF NOT EXISTS Comments(
	creationTime date not null,
    userid varchar(5) not null,
    pid varchar(5) not null,
    grade float not null,
    content varchar(500),
    
    foreign key (userid) references buyer(userid),
    foreign key (pid) references Product(pid)
);

CREATE TABLE IF NOT EXISTS Save_to_Shopping_Cart (
	userid varchar(5) not null,
    pid varchar(5) not null,
    addTime date not null,
    quantity int not null,
    
    foreign key (userid) references buyer(userid),
    foreign key (pid) references Product (pid)

);

CREATE TABLE IF NOT EXISTS Manage(
	userid varchar(5) not null,
    sid varchar(5) not null,
    setUpTime date not null,
    
    foreign key (userid) references seller(userid),
    foreign key (sid) references Store(sid)
    
);

-- Esta dando erro na chave composta, realmente é composta?

CREATE TABLE IF NOT EXISTS After_Sales_Service_At(
	brandName varchar(20) not null,
    spid varchar(5),
    
    foreign key (spid) references ServicePoint(spid),
	primary key (brandName,spid)
);


CREATE TABLE IF NOT EXISTS Orders(
	orderNumber varchar(5) primary key,
    paymentStatus varchar(10) not null,
    creationTime date not null,
    totalAmount int not null,
    
    check( paymentStatus in ('Paid','Unpaid'))
    
);

alter table Orders modify orderNumber int;

-- Era pra fazer composta neste tb?

CREATE TABLE IF NOT EXISTS Contain(
	orderNumber int not null,
    itemid varchar(5) not null,
    quantity int not null,
    
    foreign key (itemid) references OrderItem(itemid),
    primary key (orderNumber, itemid, quantity)
    
);

CREATE TABLE IF NOT EXISTS deliver_to(
	addrid varchar(5) not null,
    orderNumber int not null,
    TimeDelivered  date not null,
    
    foreign key (addrid) references address(addrid),
    foreign key (orderNumber) references Orders(orderNumber)
    );
    
-- Não sei qual dos dois referenciar no Payment então fui de cardbank
    
CREATE TABLE IF NOT EXISTS Payment(
	orderNumber int not null,
    cardNumber char(19) not null,
    payTime date not null,
    
    foreign key (orderNumber) references Orders(orderNumber),
    foreign key (cardNumber) references creditcard(cardNumber)
);

drop table Payment;