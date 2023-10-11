# online-community-website

## Welcome to the online community website!
This is a traditional bulletin board system recreated with Java Eclipse and Tomcat Apache Server. 
Users may create account/log in to write, delete, edit, and browse articles conveniently.

Currently implemented:
- SHA-512 hashing for saving user password to database
- Search by author, content, and title
- Customizable view with drop-down
- Timestamp when writing/editing articles

To be implemented:
- Change request method to POST for security
- Visually pleasing UI and CSS in separate file (currently inline CSS)
- Cohesive relational database with addition of foreign key

## To initialize database
Users and articles database is supported by MySQL. Run the DDL script titled "database.sql" to create users and articles tables.

## To run
After initializing the database, download rest of the files, run bbs.jsp in Java Eclipse environment. 
Make sure to modify dbURL, dbUsername, and dbPassword according to the local database setting.  

