

-- 1. INNER JOIN: Members who borrowed and returned books
SELECT
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    r.return_date,
    r.fine
FROM Borrow b
INNER JOIN Members m ON b.member_id = m.member_id
INNER JOIN Books bk ON b.book_id = bk.book_id
INNER JOIN Returns r ON b.borrow_id = r.borrow_id;

-- 2. LEFT JOIN: All borrowed books (even if not returned)
SELECT
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    r.return_date,
    r.fine
FROM Borrow b
LEFT JOIN Members m ON b.member_id = m.member_id
LEFT JOIN Books bk ON b.book_id = bk.book_id
LEFT JOIN Returns r ON b.borrow_id = r.borrow_id;

-- 3. RIGHT JOIN Simulation: All returns with possible missing borrow info
SELECT
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    r.return_date,
    r.fine
FROM Returns r
LEFT JOIN Borrow b ON r.borrow_id = b.borrow_id
LEFT JOIN Members m ON b.member_id = m.member_id
LEFT JOIN Books bk ON b.book_id = bk.book_id;

-- 4. FULL JOIN Simulation: Combine borrow and return records
SELECT
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    r.return_date,
    r.fine
FROM Borrow b
LEFT JOIN Members m ON b.member_id = m.member_id
LEFT JOIN Books bk ON b.book_id = bk.book_id
LEFT JOIN Returns r ON b.borrow_id = r.borrow_id

UNION

SELECT
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    r.return_date,
    r.fine
FROM Returns r
LEFT JOIN Borrow b ON r.borrow_id = b.borrow_id
LEFT JOIN Members m ON b.member_id = m.member_id
LEFT JOIN Books bk ON b.book_id = bk.book_id;

-- 5. Extra: Members who haven't returned books yet
SELECT
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    b.due_date
FROM Borrow b
JOIN Members m ON b.member_id = m.member_id
JOIN Books bk ON b.book_id = bk.book_id
LEFT JOIN Returns r ON b.borrow_id = r.borrow_id
WHERE r.return_id IS NULL;
