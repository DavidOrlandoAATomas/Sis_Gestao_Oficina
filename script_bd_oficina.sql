create database if not exists oficina;
use oficina;
show tables;

-- Tabela cliente
create table custumer(
custumer_id int not null auto_increment,
fname varchar(30) not null,
surname varchar(30) not null,
tipo_doc varchar(20) not null,
num_doc varchar(20) not null,
telefone char(10) not null,
address varchar(45) not null,
constraint pk_custumer_id primary key (custumer_id, tipo_doc, num_doc)
);

-- tabela veículo
create table vehicle(
vehicle_id int not null auto_increment,
license_plate varchar(15) not null,
brand varchar(20) not null,
model varchar(30) not null,
v_year int not null,
vehicle_owner int not null,
constraint pk_vehicle_id primary key (vehicle_id, license_plate),
constraint unique_vehicle_license unique (license_plate),
constraint fk_vehicle_owner foreign key (vehicle_owner) references custumer(custumer_id)
);

-- tabela especialidade
create table specialty(
specialty_id int not null auto_increment,
specialty_name varchar(30) not null,
spacialty_desc longtext,
primary key (specialty_id)
);

-- tabela mecânico
create table mechanic(
mechanic_id int not null auto_increment,
fname varchar(20) not null,
surname varchar(20) not null,
specialty int not null,
address varchar(30) not null,
constraint pk_mechanic_id primary key (mechanic_id),
constraint fk_mechanic_specialty foreign key (specialty) references specialty(specialty_id)
);

-- tabela equipe
create table team(
team_id int not null auto_increment,
team_name varchar(20) not null,
responseble varchar(20) not null,
vehicle int not null,
constraint pk_team_id primary key (team_id, team_name),
constraint fk_team_vehicle foreign key (vehicle) references vehicle(vehicle_id)
);

-- tabela ordem de serviço
create table service_order(
order_id int not null auto_increment,
order_status enum("Pendente", "Em_Andamento", "Esperando_Peça", "Finalizada", "Cancelada") default "pendente",
order_date date not null,
concl_date date not null,
total decimal(10, 2) not null,
team int not null,
vehicle int not null,
primary key (order_id),
constraint fk_order_team foreign key (team) references team(team_id),
constraint fk_order_vehicle foreign key (vehicle) references vehicle(vehicle_id)
);

-- tabela de serviço
create table service(
service_id int not null auto_increment,
service_type varchar(20) not null,
service_desc varchar(255) not null,
subtotal decimal(10,2) not null,
custumer int not null,
primary key (service_id),
constraint fk_service_client foreign key (custumer) references custumer(custumer_id)
);

-- tabela peça
create table piece(
piece_id int primary key not null auto_increment,
pname varchar(20) not null,
ptype varchar(15) not null,
piece_desc varchar(255) not null,
quantity int not null,
unit_value decimal(10,2) not null
);

-- tabela autorização
create table authorization(
auth_id int not null auto_increment,
auth_type enum("Assisnatura", "Digital", "Verbal", "Email"),
auth_date date not null,
auth_value decimal(10,2) not null,
custumer int not null,
order_id int not null,
primary key (auth_id),
constraint fk_auht_custumer foreign key (custumer) references custumer(custumer_id),
constraint fk_auht_order foreign key (order_id) references service_order (order_id)
);

-- relacionamentos

-- relacão equipe e mecânico
create table team_mechanic(
team int not null,
mechanic int not null,
quantity int not null,
primary key (team,mechanic),
constraint fk_team foreign key (team) references team(team_id),
constraint fk_mechanic foreign key (mechanic) references mechanic(mechanic_id)
);

-- relação os e serviço
create table so_service(
order_id int not null,
service_id int not null,
quantity int not null,
unit_value decimal(10,2) not null,
primary key (order_id, service_id),
constraint fk_so_order_id foreign key (order_id) references service_order(order_id),
constraint fk_so_service foreign key (service_id) references service(service_id)
);

-- relação ordem e peça
create table so_piece(
order_id int not null,
piece_id int not null,
quantity int not null,
unit_value decimal(10,2) not null,
primary key (order_id, piece_id),
constraint fk_so_order foreign key (order_id) references service_order(order_id),
constraint fk_so_piece foreign key (piece_id) references piece(piece_id)
);