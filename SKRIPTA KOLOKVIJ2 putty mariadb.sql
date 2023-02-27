create table odjel (
    sifra int not null primary key auto_increment,
    naziv varchar(50)  not null,
    broj_soba int


) engine=innodb;

create table doktor (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    prezime varchar(50),
    specijalizacija varchar(50),
    oib varchar(13),
    odjel int 



 ) engine=innodb;

 create table pacijent (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    prezime varchar(50),
    adresa varchar(50),
    oib varchar(13),
    doktor int

) engine=innodb;

create table medicinski_karton (
    sifra int not null primary key auto_increment,
    datum_pregleda datetime,
    dijagnoza varchar(50),
    pacijent int


) engine=innodb;

drop

create table posjetitelj (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    prezime varchar(50),
    adresa varchar(50),
    telefonski_broj varchar(50)


)engine=innodb;

create table posjeta (
sifra int not null primary key auto_increment,
datum datetime,
pacijent int,
posjetitelj int,
max_trajanje_minute int

) engine=innodb;

alter table doktor add foreign key(odjel) references odjel(sifra);
alter table pacijent add foreign key(doktor) references doktor(sifra);
alter table medicinski_karton add foreign key(pacijent) references pacijent(sifra);
alter table posjeta add foreign key(pacijent) references pacijent(sifra);
alter table posjeta add foreign key(posjetitelj) references posjetitelj(sifra);

 select * from information_schema.table_constraints
where table_schema = 'jgalic_21_20' and constraint_type =
'FOREIGN KEY';

delimiter $$
create function prvoVelikoSlovo (ulaz varchar(50)) returns varchar (255)
begin
return upper (left(ulaz,1));
end;
$$
delimiter ;

--provjera funckcija
select ime_funckije (parametri);

delimiter $$
create trigger odjel_insert after insert on odjel for each row
begin 
insert into doktor(ime, prezime, specijalizacija, oib, odjel) 
values ('voditelj', '', '', '', new.sifra);
end;
$$
delimiter ;
--provjera triggera u paketu hehe
insert into odjel (naziv, broj_soba)
values ('kirurgija', 4);

select * from doktor;

delimiter $$
create procedure brisiPosjetitelja(in spacijenta int)
begin 
delete from posjeta where pacijent=spacijenta;
delete from posjetitelj where sifra not in (
   select distinct pacijent from posjeta
);
end;
$$
delimiter ;

--provjera
unijet dva posjetitelja, dva pacijenta, dvije posjetitelj onda obrisi posjete jednog pacijenta