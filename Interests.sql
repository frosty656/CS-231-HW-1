USE Normalization1;

DROP TABLE if EXISTS interests;

CREATE TABLE interests
(
    interest_ID int(11) UNSIGNED NOT NULL auto_increment,
    interest varchar(50) NOT NULL,
    PRIMARY KEY (interest_ID)
) AS

#Get first interest
SELECT DISTINCT substring_index(interests, ',',1) as interest
FROM my_contacts
WHERE interests IS NOT NULL

#Get second interest
UNION
SELECT DISTINCT substring_index(substring_index(interests, ', ', 2), ', ', -1) as interest
FROM my_contacts
WHERE interests IS NOT NULL

#Get third interest
UNION
SELECT DISTINCT substring_index(interests, ',', -1) as interest
FROM my_contacts
WHERE interests IS NOT NULL
ORDER BY interest;

DROP TABLE if EXISTS contacts_to_interests;

CREATE TABLE contacts_to_interests
(
    contact_ID int(11) UNSIGNED,
    interest_ID int (11) UNSIGNED,
    FOREIGN KEY (contact_ID) references my_contacts (UID),
    FOREIGN KEY (interest_ID) references interests (interest_ID)
);

INSERT into contacts_to_interests(contact_ID, interest_ID)
SELECT my_contacts.UID, interest.interest_ID
FROM my_contacts
         INNER JOIN interests interest
                    on substring_index(interests, ', ', 1) = interest.interest
WHERE interests IS NOT NULL
UNION
SELECT my_contacts.UID, i.interest_ID
FROM my_contacts
         INNER JOIN interests i
                    on substring_index(substring_index(interests, ', ', 2), ', ', -1) = i.interest
WHERE interests IS NOT NULL
UNION
SELECT my_contacts.UID, i.interest_ID
FROM my_contacts
         INNER JOIN interests i
                    on substring_index(interests, ', ', -1) = i.interest
ORDER BY UID, interest_ID;

ALTER TABLE my_contacts
DROP COLUMN interests