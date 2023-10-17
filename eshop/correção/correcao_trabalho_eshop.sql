-- DROP DATABASE eshop_turma_b;


USE eshop_turma_b;

DROP TABLE delivery_to;
DROP TABLE contain;
DROP TABLE payment;
DROP TABLE manage;
DROP TABLE save_to_shopping_cart;
DROP TABLE after_sales_service_at;


DROP TABLE address;
DROP TABLE orders;
DROP TABLE orderItem;
DROP TABLE creditCard;
DROP TABLE debitCard;
DROP TABLE bankCard;
DROP TABLE seller;
DROP TABLE comments;
DROP TABLE buyer;
DROP TABLE users;
DROP TABLE product;
DROP TABLE store;
DROP TABLE servicePoint;
DROP TABLE brand;

-- criação do banco de dados
DROP DATABASE eshop_turma_b;

CREATE DATABASE IF NOT EXISTS eshop_turma_b;

USE eshop_turma_b;

-- criação de entidades

CREATE TABLE  IF NOT EXISTS users(
	userid 	int auto_increment,
	name	varchar(40) NOT NULL,				
	phoneNumber varchar(12), 
	PRIMARY KEY (userid)
);

CREATE TABLE buyer(
	userid int not null auto_increment,
    
    primary key (userid),
    foreign key (userid) references users(userid)
);

CREATE TABLE seller(
	userid int not null auto_increment,
    
    primary key (userid),
    foreign key (userid) references users(userid)
);

CREATE TABLE bankCard(
	cardNumber char(19) NOT NULL,
    expirydate date NOT NULL,
    bank varchar(25) not null,
	PRIMARY KEY (cardNumber)
);

CREATE TABLE creditCard(
	cardNumber CHAR(19) NOT NULL,
    userid INT NOT NULL,
    organization VARCHAR(50),
    
    PRIMARY KEY (cardNumber),
    FOREIGN KEY (cardNumber) references bankCard(cardNumber),
    FOREIGN KEY(userid) references users(userid)
    );

CREATE TABLE debitCard(
	cardNumber CHAR(19) NOT NULL,
    userid INT NOT NULL,
 
    PRIMARY KEY (cardNumber),
    FOREIGN KEY (cardNumber) references bankCard(cardNumber),
    FOREIGN KEY(userid) references users(userid)
    );
    
CREATE TABLE store(
	sid			int auto_increment,
    name 		VARCHAR(50) NOT NULL,
    province	VARCHAR(35),
	city 		varchar(40),
    street		VARCHAR(40),
    customerGrade INT,
    startTime DATE,
    
    PRIMARY KEY(sid)
);

CREATE TABLE brand(
	brandName varchar(50) primary key
);

CREATE TABLE product(
	pid INT NOT NULL,
    sid INT NOT NULL,
    name VARCHAR(120) NOT NULL,
	brandName VARCHAR(50) NOT NULL,
    type 	VARCHAR(50),
    amount	INT default null,
	price 	decimal(8,2) NOT NULL,
    color 	VARCHAR(20),
    modelNumber VARCHAR(50),
    
    PRIMARY KEY(pid),
    FOREIGN KEY (sid) references store(sid),
    FOREIGN KEY (brandName) references brand(brandName)
    
);

CREATE TABLE orderItem(
	itemid 	int not null auto_increment,
    pid 	int not null,
    price decimal(8,2),
    creationTime time not null,
    
    primary key (itemid),
    foreign key (pid) references product(pid)
);

CREATE TABLE orders (
	orderNumber int NOT NULL,
    paymentState ENUM('Paid','Unpaid'),
    creationTime TIME NOT NULL,
    totalAmount decimal(10,2),
	
    PRIMARY KEY (orderNumber)
);

CREATE TABLE address(
	addrid int not null,
    userid int not null,
    name	varchar(50),
    concactPhoneNumber varchar(20),
    city varchar(100),
    province 	varchar(100),
    street	varchar(100),
    postCode varchar(12),
    
    PRIMARY KEY (addrid),
	FOREIGN KEY (userid) references users(userid)
);


CREATE TABLE comments(
    creationTime date not null ,
    userid int not null,
    pid int not null,
    grade float,
    content varchar(500) not null,
    
    primary key(creationTime, userid, pid),
    foreign key (userid) references users(userid),
	foreign key (pid) references product(pid)
);

CREATE TABLE servicePoint(
	spid INT NOT NULL,
    street 	varchar(100) NOT NULL,
    city varchar(50),
    provencieis varchar(20),
    startTime  varchar(20),
    endTime varchar(20),
    
    PRIMARY KEY(spid)
);

CREATE TABLE saveToShoppingCart(
	userid int not null,
    pid int not null,
    addTime date not null,
    quantity int not null,
    
    PRIMARY KEY( userid,pid),
    foreign key(userid) references users(userid),
    foreign key(pid) references product(pid)
);

CREATE TABLE cointain(
	orderNumber int not null,
    itemid int not null,
    quantity int,
    
    PRIMARY KEY (orderNumber,itemid),
    FOREIGN KEY (itemid) references orderItem(itemid),
    FOREIGN KEY (orderNumber) references orders(orderNumber)
);


CREATE TABLE payment(
	orderNumber INT NOT NULL,
    cardNumber CHAR(16) NOT NULL,
    payTime DATE NOT NULL,
    
    primary key (orderNumber, cardNumber),
    foreign key (orderNumber) references orders(orderNumber),
    foreign key (cardNumber) references bankcard(cardNumber)
);

CREATE TABLE deliverTo(
	addrid INT NOT NULL,
    orderNumber INT NOT NULL,
    timeDelivered date,
    
    PRIMARY KEY (addrid, orderNumber),
    foreign key (addrid) references address(addrid),
    foreign key (orderNumber) references orders(orderNumber)
);

CREATE TABLE manage (
    userid             INT NOT NULL,
    sid                 INT NOT NULL,
    setUpTime             DATE,
    
    PRIMARY KEY(userid,sid),
    FOREIGN KEY(userid) REFERENCES seller(userid),
    FOREIGN KEY(sid) REFERENCES store (sid)
);

 

CREATE TABLE After_Sales_Service_At(
    brandName         VARCHAR(20) NOT NULL,
    spid             INT NOT NULL,
    
    PRIMARY KEY(brandName, spid),
    FOREIGN KEY(brandName) REFERENCES brand (brandName),
    FOREIGN KEY(spid) REFERENCES servicePoint(spid)
);