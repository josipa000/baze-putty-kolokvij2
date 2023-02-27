create table sastojak (
    sifra int not null primary key auto_increment,
    naziv varchar(50)
)engine=innodb;

create table jedinica_mjere (
    sifra int not null primary key auto_increment,
    naziv varchar(50)
)engine=innodb;

create table normativ (
    sifra int not null primary key auto_increment,
    recept int,
    sastojak int,
    jedinica_mjere int,
    kolicina int
)engine=innodb;

create table recept (
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    opis varchar(50) not null,
    vrijeme_izrade datetime,
    kuhar int
)engine=innodb;

create table kuhar (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    prezime varchar(50),
    razina varchar(50)
)engine=innodb;

alter table normativ add foreign key(sastojak) references sastojak(sifra);
alter table normativ add foreign key(jedinica_mjere) references jedinica_mjere(sifra);
alter table normativ add foreign key(recept) references recept(sifra);
alter table recept add foreign key(kuhar) references kuhar(sifra);


delimiter $$
create function petina (broj int(11)) returns int
begin
return broj/5;
end;
$$
delimiter ;

--provjera, poziv funkcije

select petina(5); ili vec koji broj

delimiter $$
create trigger kuhar_insert after insert on kuhar for each row
begin 
insert into recept(naziv, opis, vrijeme_izrade, kuhar) 
values ('Kuharov recept', 'fini', '', new.sifra);
end;
$$
delimiter ;

insert into kuhar (ime, prezime, razina)
values ('Mato4', 'Matic4', 6);

select * from recept;

delimiter $$
create procedure brisiSastojak(sifraSastojka int)
begin 
delete from recept where sifra in (
    select distinct recept from normativ
    where sastojak=sifraSastojka);
    delete from normativ where sastojak=sifraSastojka;
end;
$$
delimiter ;

insert into sastojak(naziv)
values ('hehe');
insert into normativ(recept, sastojak)
values (1,1);
insert into normativ(recept, sastojak)
values (1,2);

call brisiSastojak(1);
select * from normativ;

--brisanje procedure
drop procedure brisiSastojak;

select * from kuhar;

--funkcija cjelobrojni tip podatka

DELIMITER $$
CREATE FUNCTION zadatak1(broj int) RETURNS int
begin
IF broj > 980 AND broj < 5098 THEN
    return broj;
ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unos mora biti između 980 i 5098';
END IF;

end;
$$
DELIMITER ;


--- ASDASD

delimiter $$
create procedure sretanBroj(broj int, ime VARCHAR(256))
begin 
    insert into lutrija (sretni_broj) values (zadatak1(broj));
    insert into zapisi (sadrzaj) values (CONCAT("Osoba ", ime, " je osvojila s sretnim brojem ", broj));
end;
$$
delimiter ;

delimiter $$
create trigger sretnibroj after update on lutrija for each row
begin 
insert into zapisi (sadrzaj) values ( concat( "Izvlačenje sa IDjem:", old.id, " je dobilo novi sretni broj ", new.sretni_broj, "umjesto ", old.sretni_broj )  );
end;
$$
delimiter ;