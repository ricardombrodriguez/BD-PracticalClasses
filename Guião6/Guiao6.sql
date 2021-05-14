-- Guião 6

--a

SELECT * FROM authors

--b

SELECT au_fname, au_lname, phone FROM authors

--c
SELECT au_fname, au_lname, phone FROM authors ORDER BY au_fname ASC, au_lname ASC

--d

SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone FROM authors ORDER BY au_fname ASC, au_lname ASC

--e

SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone FROM authors WHERE state='CA' and au_lname!='Ringer' ORDER BY au_fname ASC, au_lname ASC 

--f

SELECT * FROM publishers WHERE pub_name LIKE '%Bo%'

--g

SELECT DISTINCT pub_id FROM titles WHERE type='business'

--h

SELECT pub_name, SUM(ytd_sales) FROM publishers AS pub JOIN titles AS tit ON pub.pub_id = tit.pub_id GROUP BY pub_name

--i

SELECT pub_name, title, SUM(qty) FROM publishers AS pub JOIN titles AS tit ON pub.pub_id = tit.pub_id JOIN sales ON tit.title_id = sales.title_id GROUP BY pub_name, title ORDER BY pub_name ASC

--j

SELECT title FROM titles INNER JOIN publishers ON titles.pub_id = publishers.pub_id WHERE publishers.pub_name = 'Bookbeat'

--k

SELECT au_fname + ' ' + au_lname as au_name FROM authors WHERE au_id IN (SELECT au_id FROM titleauthor JOIN titles ON titleauthor.title_id=titles.title_id  GROUP BY au_id HAVING COUNT(titles.type)>1 )

--l

SELECT type, pub_id, AVG(price) AS avg_price, SUM(ytd_sales) AS total_sales FROM titles GROUP BY type, pub_id

-- m)

SELECT type, MAX(advance) as maximo, AVG(advance) as media FROM titles
GROUP BY type
HAVING MAX(advance) >= 1.5 * AVG(advance)

-- n)

SELECT x.title_id, x.title, x.au_fname, x.price, x.royalty, x.royaltyper, ((x.price * (x.royalty * x. royaltyper)) / 10000) AS receivedperbook, (SUM(sales.qty) * ((x.price * (x.royalty * x. royaltyper)) / 10000)) AS received, SUM(sales.qty) AS quantity
FROM (
    SELECT titles.title_id, titles.title, authors.au_id, authors.au_fname, authors.au_lname, titleauthor.royaltyper, titles.price, titles.royalty FROM titles
    INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
    INNER JOIN authors ON authors.au_id = titleauthor.au_id
) AS x
INNER JOIN sales ON x.title_id = sales.title_id
GROUP BY x.title_id, x.title, x.au_fname, x.price, x.royalty, x.royaltyper, ((x.royalty * x.royaltyper)), ((x.price * (x.royalty * x. royaltyper)) / 10000)
ORDER BY x.title

-- o)

SELECT titles.title, titles.ytd_sales, (titles.price * titles.ytd_sales) AS facturacao, ((titles.ytd_sales * titles.price * titles.royalty) / 100) AS auths_revenue, ((titles.ytd_sales * titles.price * (100 - titles.royalty)) / 100) AS publisher_revenue
FROM titles
ORDER BY titles.title

-- p)

SELECT titles.title, titles.ytd_sales, CONCAT(authors.au_fname, ' ', authors.au_lname) AS author, ((titles.ytd_sales * titles.price * ((titles.royalty * titleauthor.royaltyper) / 100)) / 100) AS auths_revenue, ((titles.ytd_sales * titles.price * (100 - titles.royalty)) / 100) AS publisher_revenue
FROM titles
INNER JOIN titleauthor ON titleauthor.title_id = titles.title_id
INNER JOIN authors ON authors.au_id = titleauthor.au_id
ORDER BY titles.title

-- q)

SELECT stores.stor_name, COUNT(DISTINCT sales.title_id) as diff_books_sold
FROM stores
INNER JOIN sales ON sales.stor_id = stores.stor_id
FULL OUTER JOIN titles ON titles.title_id = sales.title_id
GROUP BY stores.stor_name
HAVING  COUNT(DISTINCT sales.title_id) >= (SELECT COUNT(DISTINCT title_id) FROM titles)

-- r)

SELECT stores.stor_id, stores.stor_name, SUM(sales.qty) as total_quantity FROM sales
INNER JOIN stores ON stores.stor_id = sales.stor_id
GROUP BY stores.stor_id, stores.stor_name
HAVING SUM(sales.qty) >= (SELECT AVG(total_quantity) 
                          FROM (SELECT sum(sales.qty) as total_quantity FROM sales
                    INNER JOIN stores ON stores.stor_id = sales.stor_id
                GROUP BY stores.stor_id, stores.stor_name) x )

    -- s)

    SELECT titles.title FROM 
        (SELECT stores.stor_name,sales.title_id FROM stores
        JOIN sales ON stores.stor_id = sales.stor_id
        WHERE stores.stor_name = 'Bookbeat') AS s
    RIGHT JOIN titles ON s.title_id = titles.title_id
    WHERE stor_name IS NULL

-- t)

SELECT pub_name, stor_name
FROM publishers,stores
GROUP BY pub_name, stor_name,pub_id)
EXCEPT
SELECT DISTINCT tmp3.pub_name, tmp3.stor_name  FROM stores
RIGHT JOIN
SELECT tmp2.pub_name,tmp2.pub_id,tmp2.stor_name,tmp2.title_id, sales.stor_id FROM sales 
RIGHT JOIN
(SELECT tmp.pub_name,tmp.pub_id,tmp.stor_name,titles.title_id FROM
titles RIGHT JOIN 
(SELECT pub_name,pub_id, stor_name
FROM publishers,stores
GROUP BY pub_name, stor_name,pub_id) AS tmp
ON titles.pub_id = tmp.pub_id) AS tmp2 
ON sales.title_id= tmp2.title_id) AS tmp3
ON stores.stor_id = tmp3.stor_id
WHERE stores.stor_name = tmp3.stor_name
ORDER BY pub_name
