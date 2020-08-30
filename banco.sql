drop database lab5;
create database lab5;

use lab5;

CREATE TABLE cli_cliente(
	cli_id BIGINT NOT NULL AUTO_INCREMENT,
    dtype VARCHAR(255),
    nome VARCHAR(255),
    cpf VARCHAR(11),
    cnpj VARCHAR(19),
    endereco VARCHAR(255),
    CONSTRAINT pk_cli_cliente PRIMARY KEY(cli_id)
);

CREATE TABLE for_fornecedor(
	for_id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255),
    cnpj VARCHAR(19),
    CONSTRAINT pk_for_fornecedor PRIMARY KEY(for_id)
);

CREATE TABLE ite_item(
	ite_id BIGINT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255),
    preco double,
    for_id BIGINT,
    CONSTRAINT pk_ite_item PRIMARY KEY (ite_id),
    CONSTRAINT fk_for_fornecedor FOREIGN KEY (for_id)
    REFERENCES for_fornecedor(for_id)
);

CREATE TABLE ped_pedido(
	ped_id BIGINT NOT NULL AUTO_INCREMENT,
    cli_id BIGINT,
    CONSTRAINT pk_ped_pedido PRIMARY KEY(ped_id),
    CONSTRAINT fk_cli_cliente FOREIGN KEY(cli_id)
    REFERENCES cli_cliente(cli_id)
);

CREATE TABLE item_pedido(
	ped_id BIGINT NOT NULL,
    ite_id BIGINT NOT NULL,
    CONSTRAINT pk_item_pedido PRIMARY KEY(ped_id, ite_id),
    CONSTRAINT fk_ped_pedido FOREIGN KEY (ped_id)
    REFERENCES ped_pedido(ped_id),
    CONSTRAINT fk_ite_item FOREIGN KEY (ite_id)
    REFERENCES ite_item(ite_id)
);

CREATE TABLE pag_pagamento(
	pag_id BIGINT NOT NULL AUTO_INCREMENT,
    ped_id BIGINT,
    valor DOUBLE,
    CONSTRAINT pk_pag_pagamento PRIMARY KEY(pag_id),
    CONSTRAINT fk_pag_ped_pedido FOREIGN KEY (ped_id)
    REFERENCES ped_pedido(ped_id)
);

CREATE TABLE pag_pagamento_cartao(
	pag_id BIGINT NOT NULL AUTO_INCREMENT,
    parcelas INTEGER,
    CONSTRAINT pk_pag_pagamento_cartao PRIMARY KEY(pag_id)
);

CREATE TABLE pag_pagamento_dinheiro(
	pag_id BIGINT NOT NULL AUTO_INCREMENT,
    desconto DOUBLE,
    CONSTRAINT pk_pag_pagamento_dinheiro PRIMARY KEY(pag_id)
);

CREATE TABLE usr_usuario(
    usuario VARCHAR(255) NOT NULL PRIMARY KEY,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE roles(
    role_name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_roles PRIMARY KEY(role_name)
);

CREATE TABLE usr_has_roles(
    role_name VARCHAR(255) NOT NULL,
    usuario VARCHAR(255) NOT NULL,
    CONSTRAINT fk_usuario FOREIGN KEY (usuario) REFERENCES
    usr_usuario(usuario),
    CONSTRAINT fk_role FOREIGN KEY (role_name) REFERENCES
    roles(role_name),
    CONSTRAINT pk_roles PRIMARY KEY(role_name, usuario)
);

INSERT INTO roles values("ADMIN");
INSERT INTO roles values("DEFAULT");