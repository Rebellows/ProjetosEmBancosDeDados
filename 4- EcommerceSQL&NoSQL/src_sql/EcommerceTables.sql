CREATE TABLE Cliente (
    id_cliente NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nome VARCHAR2(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
);

CREATE TABLE Endereco (
    id_endereco NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    cep VARCHAR2(10) NOT NULL,
    numero NUMBER NOT NULL,
    complemento VARCHAR2(50),
    id_cliente NUMBER NOT NULL,
    CONSTRAINT pk_endereco PRIMARY KEY (id_endereco),
    CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Pedido (
    id_pedido NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    data_hora DATE NOT NULL,
    forma_pgto VARCHAR2(10) NOT NULL,
    id_cliente NUMBER NOT NULL,
    id_endereco NUMBER NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_pedido_endereco FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco),
    CONSTRAINT chk_forma_pgto CHECK (forma_pgto IN ('Cartão', 'Boleto', 'Pix'))
);

CREATE TABLE Transportadora (
    id_transportadora NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nome VARCHAR2(75) NOT NULL,
    email VARCHAR2(50),
    CONSTRAINT pk_transportadora PRIMARY KEY (id_transportadora)
);

CREATE TABLE Categoria (
    id_categoria NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nome VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE Produto (
    id_produto NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nome VARCHAR2(100) NOT NULL,
    preco NUMBER(10, 2) NOT NULL,
    id_categoria NUMBER NOT NULL,
    CONSTRAINT pk_produto PRIMARY KEY (id_produto),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Avaliacao (
    id_avaliacao NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    id_cliente NUMBER NOT NULL,
    id_produto NUMBER NOT NULL,
    nota FLOAT NOT NULL,
    comentario VARCHAR2(250),
    CONSTRAINT pk_avaliacao PRIMARY KEY (id_avaliacao),
    CONSTRAINT fk_avaliacao_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_avaliacao_produto FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Pedido_has_produto (
    id_pedprod NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    id_transportadora NUMBER NOT NULL,
    id_produto NUMBER NOT NULL,
    id_pedido NUMBER NOT NULL,
    quantidade NUMBER NOT NULL,
    data_entrega DATE NOT NULL,
    status_entrega VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_pedprod PRIMARY KEY (id_pedprod),
    CONSTRAINT fk_pedprod_transportadora FOREIGN KEY (id_transportadora) REFERENCES Transportadora(id_transportadora),
    CONSTRAINT fk_pedprod_produto FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    CONSTRAINT fk_pedprod_pedido FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    CONSTRAINT chk_status_entrega CHECK (status_entrega IN ('Pendente', 'Enviado', 'Entregue'))
);