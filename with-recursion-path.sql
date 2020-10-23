CREATE TABLE t (
    parent_id BIGINT,
    num BIGINT
);

INSERT INTO t (num, parent_id) VALUES (1, null);
INSERT INTO t (num, parent_id) VALUES (2, 1);
INSERT INTO t (num, parent_id) VALUES (3, 1);
INSERT INTO t (num, parent_id) VALUES (4, 2);
INSERT INTO t (num, parent_id) VALUES (5, 3);

WITH RECURSIVE _t AS
    (SELECT num,
            array[num] AS path,
            FALSE AS cycle
        FROM t
        WHERE parent_id is NULL
        UNION ALL
        SELECT t.num,
               _t.path || t.num AS path,
               t.num = ANY (_t.path) AS cycle
    FROM t INNER JOIN _t ON (_t.num = t.parent_id) AND NOT cycle)
SELECT num, path FROM _t

