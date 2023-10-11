create table user
(
    userID       varchar(20)  not null
        primary key,
    userPassword varchar(128) not null,
    userName     varchar(30)  not null,
    userGender   varchar(20)  not null,
    userEmail    varchar(50)  not null
);

create table article
(
    bbsIndex     int          not null
        primary key,
    bbsContent   varchar(100) not null,
    bbsTitle     varchar(30)  not null,
    bbsAuthor    varchar(30)  not null,
    bbsDate      date         not null,
    availableInt int          not null
);
