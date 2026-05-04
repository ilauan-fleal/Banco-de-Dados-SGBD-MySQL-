-- Active: 1777211280809@@localhost@3306@estaleiro_navios

#Criando banco de dados

CREATE DATABASE Estaleiro_Navios;

#Criando tabela cliente

CREATE TABLE Estaleiro_Navios.cliente(
    cod_cliente INT NOT NULL AUTO_INCREMENT,
    nome_empresa VARCHAR(30) NOT NULL,
    cnpj VARCHAR(25) NOT NULL,
    nome_cliente VARCHAR(10) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    PRIMARY KEY(cod_cliente)

);

#Criando tabela para telefone

CREATE TABLE Estaleiro_Navios.telefone(
    ddd VARCHAR(2) NOT NULL,
    cod_pais VARCHAR(2) NOT NULL,
    tipo VARCHAR(5) NOT NULL,
    numero VARCHAR(9) NOT NULL
);


#Criando tabela para email

CREATE TABLE Estaleiro_Navios.email(
    endereco_eletronico VARCHAR(20) NOT NULL,
    dominio VARCHAR(4) NOT NULL
);



#Criando tabela para endereço

CREATE TABLE Estaleiro_Navios.endereco(
    uf VARCHAR(2) NOT NULL,
    cidade VARCHAR(10) NOT NULL,
    cep VARCHAR(9) NOT NULL

);

#Criando tabela com chave estrangeira, referenciada, a partir da chave primária: cod_cliente.

CREATE TABLE Estaleiro_Navios.identificador_cliente(
    fk_cod_cliente INT,
    FOREIGN KEY(fk_cod_cliente) REFERENCES Estaleiro_Navios.cliente(cod_cliente)
);

#Criando uma tabela, para os funcionários

CREATE TABLE Estaleiro_Navios.funcionario(
    cod_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(10) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_admissao DATE NOT NULL,
    PRIMARY KEY(cod_funcionario)
);


#Criando tabela, para o cargo

CREATE TABLE Estaleiro_Navios.cargo(
    cod_cargo INT NOT NULL AUTO_INCREMENT,
    horas_semanais TIME NOT NULL,
    salario FLOAT NOT NULL,
    nome_cargo VARCHAR(10),
    PRIMARY KEY(cod_cargo)
);

#Criando mais uma tabela associada ao cargo exercido::

CREATE TABLE Estaleiro_Navios.bonificacao(
    diaria FLOAT NOT NULL,
    mensal FLOAT NOT NULL,
    fk_funcionario_cargo_cod_funcionario INT , FOREIGN KEY(fk_funcionario_cargo_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_funcionario_cargo_cod_cargo INT, FOREIGN KEY(fk_funcionario_cargo_cod_cargo) REFERENCES Estaleiro_Navios.cargo(cod_cargo)
)



#Criando tabela para caracterizar a relação funcionário-cargo

CREATE TABLE Estaleiro_Navios.funcionario_cargo(

    fk_cod_funcionario INT, FOREIGN KEY(fk_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_cod_cargo INT, FOREIGN KEY(fk_cod_cargo) REFERENCES Estaleiro_Navios.cargo(cod_cargo)
);



#Criando tabela, para embarcação

CREATE TABLE Estaleiro_Navios.embarcacao(
    numero_certificado INT AUTO_INCREMENT,
    tipo VARCHAR(10) NOT NULL,
    data_fabricacao VARCHAR(8) NOT NULL,
    PRIMARY KEY(numero_certificado)
);


#Criando tabela, para especificação das embarcações

CREATE TABLE Estaleiro_Navios.especificacao(
    peso FLOAT NOT NULL,
    altura FLOAT NOT NULL,
    capacidade_carga FLOAT NOT NULL,
    capacidade_ocupantes INT NOT NULL
);

#Criando tabela, para os projetos

CREATE TABLE Estaleiro_Navios.projeto(
    identificador_unico_projeto INT AUTO_INCREMENT,
    nome VARCHAR(11) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    orcamento FLOAT NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino_prevista DATE NOT NULL,
    data_termino_real DATE NOT NULL,
    PRIMARY KEY(identificador_unico_projeto),
    fk_cod_funcionario INT , FOREIGN KEY(fk_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario)




);







#Mais uma tabela somente de chaves estrangeiras.

CREATE TABLE Estaleiro_Navios.cliente_projeto_venda_embarcacao(
    fk_cod_cliente INT, FOREIGN KEY(fk_cod_cliente) REFERENCES Estaleiro_Navios.cliente(cod_cliente),
    fk_numero_certificado_embarcacao INT, FOREIGN KEY(fk_numero_certificado_embarcacao) REFERENCES Estaleiro_Navios.embarcacao(numero_certificado),
    fk_projeto_identificador_unico INT, FOREIGN KEY(fk_projeto_identificador_unico) REFERENCES Estaleiro_Navios.projeto(identificador_unico_projeto)

);


#Uma nova tabela, só que dessa vez, contendo apenas uma chave estrangeira!

CREATE TABLE Estaleiro_Navios.projeto_partes_reutilizadas_descartadas(
    fk_projeto_identificador_unico INT, FOREIGN KEY(fk_projeto_identificador_unico) REFERENCES Estaleiro_Navios.projeto(identificador_unico_projeto)  

);

#Criando tabela para partes descartadas do projeto!

CREATE TABLE Estaleiro_Navios.partes_descartadas(
    fracoes FLOAT NOT NULL,
    total INT NOT NULL

);

#Criando tabela para partes reutilizadas do projeto!

CREATE TABLE Estaleiro_Navios.partes_reutilizadas(
    fracoes FLOAT NOT NULL,
    total INT NOT NULL

);


#Criando tabela, para equipamentos

CREATE TABLE Estaleiro_Navios.equipamentos(
    cod_produto INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(10) NOT NULL,
    tipo VARCHAR(5) NOT NULL,
    data_inicio_de_uso DATE NOT NULL,
    data_fim_de_uso DATE NOT NULL,
    PRIMARY KEY(cod_produto)

);


#Criando uma tabela para o setor


CREATE TABLE Estaleiro_Navios.setor(
    cod_setor INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(10) NOT NULL,
    descricao VARCHAR(25) NOT NULL,
    PRIMARY KEY(cod_setor)

);

#Mais uma tabela para relação funcionário-compra

CREATE TABLE Estaleiro_Navios.funcionario_compra(
    fk_funcionario_cargo_cod_funcionario INT, FOREIGN KEY(fk_funcionario_cargo_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_equipamentos_cod_produto INT , FOREIGN KEY(fk_equipamentos_cod_produto) REFERENCES Estaleiro_Navios.equipamentos(cod_produto),
    hora TIME NOT NULL,
    dia DATE NOT NULL
);


#Mais uma tabela para relação funcionário-trabalha

CREATE TABLE Estaleiro_Navios.funcionario_trabalha(
    fk_funcionario_cargo_cod_funcionario INT, FOREIGN KEY(fk_funcionario_cargo_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_setor_cod_setor INT, FOREIGN KEY(fk_setor_cod_setor) REFERENCES Estaleiro_Navios.setor(cod_setor)

);

#Mais uma tabela para relação funcionário-supervisor

CREATE TABLE Estaleiro_Navios.funcionario_supervisionar(
    fk_funcionario_cargo_cod_funcionario INT, FOREIGN KEY(fk_funcionario_cargo_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_funcionario_cargo_cod_cargo INT, FOREIGN KEY(fk_funcionario_cargo_cod_cargo) REFERENCES Estaleiro_Navios.cargo(cod_cargo)

);

#Mais uma tabela para relação funcionário-gestor

CREATE TABLE Estaleiro_Navios.funcionario_gerir(
    fk_funcionario_cargo_cod_funcionario INT , FOREIGN KEY(fk_funcionario_cargo_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_funcionario_cargo_cod_cargo INT, FOREIGN KEY(fk_funcionario_cargo_cod_cargo) REFERENCES Estaleiro_Navios.cargo(cod_cargo),
    fk_setor_cod_setor INT, FOREIGN KEY(fk_setor_cod_setor) REFERENCES Estaleiro_Navios.setor(cod_setor)

);

#Aqui é construída uma tabela, para a relação funcionário-cargo-setor-bonificação.

CREATE TABLE Estaleiro_Navios.funcionario_cargo_setor_bonificacao(
    fk_funcionario_cargo_cod_funcionario INT, FOREIGN KEY(fk_funcionario_cargo_cod_funcionario) REFERENCES Estaleiro_Navios.funcionario(cod_funcionario),
    fk_funcionario_cargo_cod_cargo INT, FOREIGN KEY(fk_funcionario_cargo_cod_cargo) REFERENCES Estaleiro_Navios.cargo(cod_cargo),
    fk_setor_cod_setor INT, FOREIGN KEY(fk_setor_cod_setor) REFERENCES Estaleiro_Navios.setor(cod_setor),
    data_de_nascimento INT(8) NOT NULL,
    data_de_admissao INT(8) NOT NULL,
    nome VARCHAR(10) NOT NULL,
    nome_do_cargo VARCHAR(20) NOT NULL,
    salario FLOAT(2) NOT NULL,
    horas_semanais TIME NOT NULL,
    descricao VARCHAR(20) NOT NULL,
    diaria FLOAT(2) NOT NULL,
    mensal FLOAT(2) NOT NULL
);

