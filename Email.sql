USE Normalization1;
drop table if exists email;

CREATE TABLE email(
    email_ID int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL,
    foreign key (email_ID) references my_contacts(UID)
) AS
    SELECT DISTINCT email
    FROM my_contacts
    WHERE email is NOT NULL
    ORDER BY email;

#ALTER TABLE my_contacts
#DROP COLUMN email