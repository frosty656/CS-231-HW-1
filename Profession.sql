USE Normalization1;
drop table if exists profession;

CREATE TABLE profession(
    profession_ID int(11) NOT NULL auto_increment,
    profession VARCHAR(25) NOT NULL,
    PRIMARY KEY (profession_ID)
) AS
    SELECT  DISTINCT profession
    FROM my_contacts
    WHERE profession is NOT NULL
    ORDER BY profession;

alter table my_contacts
    ADD COLUMN profession_ID INT(11),
    ADD FOREIGN KEY (profession_ID) REFERENCES profession(profession_ID);


update my_contacts
    INNER JOIN profession
    ON profession.profession = my_contacts.profession
    SET my_contacts.profession_ID = profession.profession_ID
    WHERE profession.profession IS NOT NULL;

ALTER TABLE my_contacts
DROP COLUMN profession
