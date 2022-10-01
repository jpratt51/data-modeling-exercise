CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    region TEXT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    regions_id INT,
    posts_id INT
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    users_id INT,
    locations_id INT,
    categories_id INT
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category TEXT NOT NULL
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    location TEXT NOT NULL
);

ALTER TABLE users ADD FOREIGN KEY (regions_id) REFERENCES regions(id);

ALTER TABLE users ADD FOREIGN KEY (posts_id) REFERENCES posts(id);

ALTER TABLE posts ADD FOREIGN KEY (users_id) REFERENCES users(id);

ALTER TABLE posts ADD FOREIGN KEY (locations_id) REFERENCES locations(id);

ALTER TABLE posts ADD FOREIGN KEY (categories_id) REFERENCES categories(id);

-- Testing database: VVVVV

INSERT INTO regions (name) VALUES ('Northeast'),('Southwest'),('West'),('Southeast'),('Midwest');

INSERT INTO users (name,regions_id) VALUES ('Greg',1),('Charlie',2),('Sally',3),('Mary',4),('Samantha',5);

INSERT INTO categories (category) VALUES ('For Sale'),('Job Offered'),('Job Wanted'),('Housing Offered'),('Housing Wanted'),('Item Wanted');

INSERT INTO locations (location) VALUES ('New York City, NY'),('Phoenix, AZ'),('Denver, CO'),('Jacksonville, FL'),('Des Moines, IA');

INSERT INTO posts (title,text,users_id,locations_id,categories_id) VALUES ('Line Cook','Line cook position at Grandpa Maxs Kitchen, starting wage $15/hr',1,1,2),('Bicycle For Sale','Trek mountain bike, great condition. Price: $400',2,2,1),('Freelance Software Engineer','10 years experience designing web platforms and apps for companies such as Apple and Microsoft. Contact me at 555-555-5555 or fake.email@gmail.com',3,3,3),('Room Rental','200sqft room with kitchenette, attached bathroom. Contact me at 555-555-5555 or fake.email@gmail.com',4,4,4),('LF Samurai Sword','Looking for Samurai Sword in mint condition to put on display. Price range is $500-$1,000. Contact me at 555-555-5555 or fake.email@gmail.com',5,5,6);

UPDATE users SET posts_id = 1 WHERE id=1;

UPDATE users SET posts_id = 2 WHERE id=2;

UPDATE users SET posts_id = 3 WHERE id=3;

UPDATE users SET posts_id = 4 WHERE id=4;

UPDATE users SET posts_id = 5 WHERE id=5;

-- Database tests:

SELECT users.name,regions.region,posts.title FROM users JOIN regions ON users.regions_id = regions.id JOIN posts ON posts.id = users.posts_id;

Result:

   name   |   name    |            title
----------+-----------+-----------------------------
 Greg     | Northeast | Line Cook
 Charlie  | Southwest | Bicycle For Sale
 Sally    | West      | Freelance Software Engineer
 Mary     | Southeast | Room Rental
 Samantha | Midwest   | LF Samurai Sword

SELECT posts.title,posts.text,users.name,locations.location,categories.category FROM posts JOIN users ON posts.users_id = users.id JOIN locations ON posts.locations_id = locations.id JOIN categories ON posts.categories_id = categories.id;

Result: 
            title            |                                                                        text                                                                        |   name   |     location      |    category
-----------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+----------+-------------------+-----------------
 Line Cook                   | Line cook position at Grandpa Maxs Kitchen, starting wage $15/hr                                                                                   | Greg     | New York City, NY | Job Offered
 Bicycle For Sale            | Trek mountain bike, great condition. Price: $400                                                                                                   | Charlie  | Phoenix, AZ       | For Sale
 Freelance Software Engineer | 10 years experience designing web platforms and apps for companies such as Apple and Microsoft. Contact me at 555-555-5555 or fake.email@gmail.com | Sally    | Denver, CO        | Job Wanted
 Room Rental                 | 200sqft room with kitchenette, attached bathroom. Contact me at 555-555-5555 or fake.email@gmail.com                                               | Mary     | Jacksonville, FL  | Housing Offered
 LF Samurai Sword            | Looking for Samurai Sword in mint condition to put on display. Price range is $500-$1,000. Contact me at 555-555-5555 or fake.email@gmail.com      | Samantha | Des Moines, IA    | Item Wanted
