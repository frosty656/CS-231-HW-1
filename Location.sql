USE Normalization1;

UPDATE my_contacts
SET location = 'San Francisco, CA'
WHERE location = 'San Fran, CA';

drop table if exists location;

CREATE TABLE location
(
    location_ID int(11)     NOT NULL auto_increment,
    location    VARCHAR(25) NOT NULL,
    PRIMARY KEY (location_ID)
) AS
SELECT DISTINCT location
FROM my_contacts
WHERE location is NOT NULL
ORDER BY location;

alter table my_contacts
    ADD COLUMN location_ID INT(11),
    ADD FOREIGN KEY (location_ID) REFERENCES location(location_ID);

update my_contacts
    INNER JOIN location
    ON location.location = my_contacts.location
SET my_contacts.location_ID = location.location_ID
WHERE location.location IS NOT NULL;

ALTER TABLE my_contacts
DROP COLUMN location
