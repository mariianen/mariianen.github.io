CREATE TABLE IF NOT EXISTS `CLIENTE` (
	`id_cliente` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(100) NOT NULL,
	`cpf` varchar(11) NOT NULL UNIQUE,
	`email` varchar(255) NOT NULL UNIQUE,
	`telefone` varchar(15),
	PRIMARY KEY (`id_cliente`)
);
CREATE TABLE IF NOT EXISTS `BRINQUEDO` (
	`id_brinquedo` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(120) NOT NULL,
	`descricao` varchar(500),
	`categoria` varchar(60) NOT NULL,
	`faixa_etaria` varchar(30) NOT NULL,
	`preco` decimal(10,2) NOT NULL,
	PRIMARY KEY (`id_brinquedo`),
	CONSTRAINT `chk_preco_brinquedo` CHECK preco > 0
);
CREATE TABLE IF NOT EXISTS `PEDIDO` (
	`id_pedido` int AUTO_INCREMENT NOT NULL UNIQUE,
	`data_pedido` date NOT NULL,
	`status_pedido` varchar(30) NOT NULL,
	`id_cliente` int NOT NULL,
	PRIMARY KEY (`id_pedido`)
);
CREATE TABLE IF NOT EXISTS `ITEM_PEDIDO` (
	`id_item_pedido` int AUTO_INCREMENT NOT NULL UNIQUE,
	`quantidade` int NOT NULL,
	`preco_unitario` decimal(10,2) NOT NULL,
	`id_pedido` int NOT NULL,
	`id_brinquedo` int NOT NULL,
	PRIMARY KEY (`id_item_pedido`),
	CONSTRAINT `chk_quantidade_positiva` CHECK quantidade > 0,
	CONSTRAINT `chk_preco_unitario` CHECK preco_unitario > 0
);
CREATE TABLE IF NOT EXISTS `PAGAMENTO` (
	`id_pagamento` int AUTO_INCREMENT NOT NULL UNIQUE,
	`forma_pagamento` varchar(30),
	`status_pagamento` varchar(30) NOT NULL,
	`valor_pago` decimal(10,2),
	`data_pagamento` date,
	`id_pedido` int NOT NULL UNIQUE,
	PRIMARY KEY (`id_pagamento`),
	CONSTRAINT `chk_valor_pago` CHECK valor_pago >= 0
);
CREATE TABLE IF NOT EXISTS `ESTOQUE` (
	`id_estoque` int AUTO_INCREMENT NOT NULL UNIQUE,
	`quantidade_disponivel` int NOT NULL,
	`data_atualizacao` datetime NOT NULL,
	`id_brinquedo` int NOT NULL UNIQUE,
	PRIMARY KEY (`id_estoque`),
	CONSTRAINT `chk_estoque_nao_negativo` CHECK quantidade_disponivel >= 0
);
ALTER TABLE `PEDIDO` ADD CONSTRAINT `PEDIDO_fk3` FOREIGN KEY (`id_cliente`) REFERENCES `CLIENTE`(`id_cliente`);
ALTER TABLE `ITEM_PEDIDO` ADD CONSTRAINT `ITEM_PEDIDO_fk3` FOREIGN KEY (`id_pedido`) REFERENCES `PEDIDO`(`id_pedido`);
ALTER TABLE `ITEM_PEDIDO` ADD CONSTRAINT `ITEM_PEDIDO_fk4` FOREIGN KEY (`id_brinquedo`) REFERENCES `BRINQUEDO`(`id_brinquedo`);
ALTER TABLE `PAGAMENTO` ADD CONSTRAINT `PAGAMENTO_fk5` FOREIGN KEY (`id_pedido`) REFERENCES `PEDIDO`(`id_pedido`);
ALTER TABLE `ESTOQUE` ADD CONSTRAINT `ESTOQUE_fk3` FOREIGN KEY (`id_brinquedo`) REFERENCES `BRINQUEDO`(`id_brinquedo`);
CREATE UNIQUE INDEX `uq_pedido_brinquedo` ON `ITEM_PEDIDO` (`id_pedido`, `id_brinquedo`);