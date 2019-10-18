USE Normalization1;
drop table if exists status;

CREATE TABLE status(
    status_ID int(11) NOT NULL auto_increment,
    status VARCHAR(25) NOT NULL,
    PRIMARY KEY (status_ID)
) AS
    SELECT  DISTINCT status
    FROM my_contacts
    WHERE status is NOT NULL
    ORDER BY status;

alter table my_contacts
    ADD COLUMN status_ID INT(11);


update my_contacts
    INNER JOIN status
    ON status.status = my_contacts.status
    SET my_contacts.status_ID = status.status_ID
    WHERE status.status IS NOT NULL;

ALTER TABLE my_contacts
DROP COLUMN status