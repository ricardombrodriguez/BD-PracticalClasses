use p9g5
go

-- a)

CREATE VIEW authorTitles AS
SELECT pubs.dbo.titles.title, pubs.dbo.authors.au_fname, pubs.dbo.authors.au_lname FROM pubs.dbo.titles
JOIN pubs.dbo.titleauthor ON pubs.dbo.titles.title_id = pubs.dbo.titleauthor.title_id
JOIN pubs.dbo.authors ON pubs.dbo.titleauthor.au_id = pubs.dbo.authors.au_id

CREATE VIEW publisherEmployees AS
SELECT pub_name, fname, minit, lname FROM pubs.dbo.employee
LEFT JOIN pubs.dbo.publishers ON pubs.dbo.employee.pub_id = pubs.dbo.publishers.pub_id

CREATE VIEW storesTitles AS
SELECT stores.stor_name, titles.title FROM pubs.dbo.stores AS stores
INNER JOIN pubs.dbo.sales AS sales ON sales.stor_id = stores.stor_id
INNER JOIN pubs.dbo.titles AS titles ON titles.title_id = sales.title_id

CREATE VIEW businessTitles AS
SELECT titles.title_id, titles.title FROM pubs.dbo.titles AS titles
WHERE titles.type = 'Business'

--b)

SELECT * FROM authorTitles
WHERE au_fname = 'Cheryl' OR au_lname = 'Ringer'

SELECT * FROM publisherEmployees
INNER JOIN pubs.dbo.publishers AS publishers ON publishers.pub_name = publisherEmployees.pub_name
WHERE publishers.city = 'New York'

SELECT * FROM storesTitles
INNER JOIN pubs.dbo.stores AS stores ON stores.stor_name = storesTitles.stor_name
WHERE stores.state = 'CA'

--c)

CREATE VIEW storeAuthors AS
SELECT DISTINCT stor_name, au_fname, au_lname FROM storesTitles
JOIN authortitles ON authortitles.title = storesTitles.title
GROUP BY stor_name, au_fname, au_lname

-- d)
insert into businessTitles (title_id, title, type, pub_id, price, notes)
values('BDTst1', 'New BD Book','popular_comp', '1389', $30.00, 'A must-read for DB course.')

-- i. Não tivemos sucesso, porque quando criamos a VIEW não selecionamos todos os campos que estão presentes na instrução de inserção

-- ii.

ALTER VIEW businessTitles AS
SELECT titles.title_id, titles.title, titles.type, titles.pub_id, titles.price, titles.notes FROM pubs.dbo.titles AS titles
WHERE titles.type = 'Business'

-- iii. Por estarmos a usar o servidor do ieeta e não o local, não temos permissão de inserção. No entanto, sendo esse o único erro é porque a instrução já está correta