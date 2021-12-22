create table books_by_authors
(
	id integer not null
		constraint books_by_authors_pk
			primary key,
	aid integer
		constraint fk_a
			references author,
	bid integer
		constraint fk_b
			references book
);