show databases;

create database dbPadaria;

use dbPadaria;

create table Fornecedores (
	idFornecedor int primary key auto_increment,
    nomeFornecedor varchar(50) not null,
    cnpjFornecedor varchar(20) not null,
    telefoneFornecedor varchar(20),
    emailFornecedor varchar(50) not null unique,
    cep varchar(9),
    enderecoFornecedor varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into Fornecedores (nomeFornecedor, cnpjFornecedor, telefoneFornecedor, emailFornecedor, cep, enderecoFornecedor, numeroEndereco, bairro, cidade, estado) values 
("Roberto Giovanni", "27.300.524/0001-54", "(34) 99233-9206", "robertogiovanni@gmail.com", "04472-310", "Rua do Zero", "77", "Jd. Novo Pantanal", "São Paulo", "SP");

select * from Fornecedores;

create table Produtos (
    idProduto  int primary key auto_increment,
    nomeProduto varchar(50) not null,
    descricaoProduto text,
    precoProduto decimal (10,2) not null,
    estoqueProduto int not null,
    categoriaProduto enum ("Pães", "Bolos", "Confeitaria", "Salgados"),
    idFornecedor int not null,
    foreign key (idFornecedor) references Fornecedores (idFornecedor)
);

insert into Produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Bolo de Chocolate", "Fofinho, prático, rápido e delicioso: essa é realmente a melhor receita de bolo de chocolate do mundo!", "45.00", 10, "Bolos", 1);

insert into Produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Pão Francês", "O pãozinho é algo que não sai da dieta das pessoas. Seja no café da manhã, como acompanhamento antes de um almoço ou como lanche da tarde.", "0.50", 50, "Pães", 1);

select * from Produtos;
select * from Produtos where categoriaProduto = "Pães";
select * from Produtos where precoProduto < 50.00 order by precoProduto asc;

create table Clientes (
    idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    cpfCliente varchar(15) not null unique,
    telefoneCliente varchar(20),
    emailCliente varchar(50) unique,
    cep varchar(9),
    enderecoCliente varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into Clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado) values
("Marcelo Paulo Enrico Farias", "870.443.977-51", "(61) 99867-3225","marcelopaulo@gmail.com", "04472-310", "Rua Quatro", "88", "Água Chata", "Guarulhos", "SP");

select * from Clientes;

create table Pedidos (
    idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum ("Pendente", "Finalizado", "Cancelado"),
    idCliente int not null,
    foreign key (idCliente) references Clientes (idCliente)
);

insert into Pedidos (statusPedido, idCliente) values ("Pendente", 1);

select * from Pedidos;
select * from Pedidos inner join Clientes on Pedidos.idCliente = Clientes.idCliente;

create table itensPedidos (
	idItensPedidos int primary key auto_increment,
    idPedido int not null,
    idProduto int not null,
    foreign key (idPedido) references Pedidos (idPedido),
    foreign key (idProduto) references Produtos (idProduto),
    quantidade int not null
);

insert into itensPedidos (idPedido, idProduto, quantidade) values (1,1,2);
insert into itensPedidos (idPedido, idProduto, quantidade) values (1,2,3);

select Pedidos.idPedido, Produtos.idProduto, Clientes.nomeCliente, Produtos.nomeProduto, quantidade, Produtos.precoProduto
from (itensPedidos inner join Pedidos on itensPedidos.idPedido = Pedidos.idPedido)
inner join Produtos on itensPedidos.idProduto = Produtos.idProduto
inner join Clientes on Pedidos.idCliente = Clientes.idCliente;









