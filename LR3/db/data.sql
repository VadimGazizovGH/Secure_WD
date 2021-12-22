
INSERT INTO public.author (id, name) VALUES (1, 'Брайан Керниган');
INSERT INTO public.author (id, name) VALUES (2, 'Деннис Ритчи');
INSERT INTO public.author (id, name) VALUES (3, 'Уилсон Редмонд');
INSERT INTO public.author (id, name) VALUES (4, 'Эндрю Таненбаум');
INSERT INTO public.author (id, name) VALUES (5, 'Josiah L Carlson');

INSERT INTO public.book (id, name) VALUES (10, 'Язык программирования Go');
INSERT INTO public.book (id, name) VALUES (20, 'Язык программирования С');
INSERT INTO public.book (id, name) VALUES (30, 'Семь баз данных за семь недель');
INSERT INTO public.book (id, name) VALUES (40, 'Распределенные системы');
INSERT INTO public.book (id, name) VALUES (50, 'Redis in Action');

INSERT INTO public.books_by_authors (bid, aid, id) VALUES (10, 1, 1000);
INSERT INTO public.books_by_authors (bid, aid, id) VALUES (20, 1, 2000);
INSERT INTO public.books_by_authors (bid, aid, id) VALUES (20, 2, 3000);
INSERT INTO public.books_by_authors (bid, aid, id) VALUES (30, 3, 4000);
INSERT INTO public.books_by_authors (bid, aid, id) VALUES (40, 4, 5000);
INSERT INTO public.books_by_authors (bid, aid, id) VALUES (50, 5, 6000);