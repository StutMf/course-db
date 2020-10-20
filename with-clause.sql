CREATE TABLE set1 (
    id FLOAT
);
CREATE TABLE set2 (
    id FLOAT
);
INSERT INTO set1 (id)
VALUES (1);
INSERT INTO set1 (id)
VALUES (2);
INSERT INTO set1 (id)
VALUES (3);
INSERT INTO set1 (id)
VALUES (4);
INSERT INTO set1 (id)
VALUES (1);
INSERT INTO set1 (id)
VALUES (3);

INSERT INTO set2 (id)
VALUES (1);
INSERT INTO set2 (id)
VALUES (2);
INSERT INTO set2 (id)
VALUES (2);
INSERT INTO set2 (id)
VALUES (3);
INSERT INTO set2 (id)
VALUES (3);


SELECT (
    (
    SELECT COUNT(*)
    FROM (
    SELECT id from set1
    INTERSECT
    SELECT id from set2
    ) as intersectCount )::float4
        /
    ( SELECT COUNT(*)
    FROM (
    SELECT id from set1
    UNION
    SELECT id from set2
    ) as unionCount )
) AS ANSWER;
/*
WITH CTEDivide AS (
    SELECT COUNT(*)
    FROM (
    SELECT id from set1
    INTERSECT
    SELECT id from set2
    ),
) SELECT

WITH query1 AS (
    SELECT *
    FROM (
    SELECT id from set1
    INTERSECT
    SELECT id from set2
    ) as intersectCount )

    , query2 AS (
    SELECT *
    FROM (
    SELECT id from set1
    UNION
    SELECT id from set2
    ) as unionCount )
SELECT count(query1) / count(query2);
*/

/* WORKING "WITH" CLAUSE */
WITH query1 AS (
    SELECT COUNT(*)
    FROM (
    SELECT id from set1
    INTERSECT
    SELECT id from set2
    ) as intersectCount )

    , query2 AS (
    SELECT COUNT(*)
    FROM (
    SELECT id from set1
    UNION
    SELECT id from set2
    ) as unionCount )

    , answer AS (
        SELECT (
               (SELECT * FROM query1)::float4
               /
               (SELECT * FROM query2)
        )
)
SELECT * from answer;



