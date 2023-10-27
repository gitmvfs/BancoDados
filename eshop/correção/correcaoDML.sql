-- A - Consultar todos os produtos existentes na loja;
select nome from product;

-- B -  Consultar os nomes de todos os usuários;
select nome from users;

-- C - Consultar as lojas que vendem produtos;
select sid, nome from store;

-- D - Consultar os endereços relacionando com os clientes;
select endereço.fk_userid as id, u.nome, endereço.streetaddr as rua from users as u
join address as endereço on u.userid = endereço.fk_userid
order by id;

-- E - Consultar todos os produtos do tipo laptop;
select nome, typee from product
where typee = "laptop"; 

-- F - Consultar o endereço, hora de inicio (start time) e hora final (end time) dos pontos de serviço da mesma cidade que o usuário cujo ID é 5.   
select servicepoint.streetaddr as addr_ServicePoint, servicepoint.starttime as hora_de_inicio, servicepoint.endtime as hora_final, servicepoint.city from users
join address on users.userid = address.fk_userid
inner join servicePoint on address.city = servicePoint.city
where userid = 5;

-- G - Consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart),considerando a loja com ID (sid) igual a 8.
select count(pid) as N_produtos from store
join product on product.fk_sid = store.sid
inner join save_to_shopping_cart on save_to_shopping_cart.fk_pid = product.pid
where sid = 8;
