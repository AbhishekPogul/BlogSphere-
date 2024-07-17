# BlogSphere-

BlogSphere is a blog application built with Java Servlets, JSP, and MySQL. This README provides a guide on how to set up and run the project using Java 8 and Tomcat 8.5.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- **Java 8 JDK**: [Download and install Java 8 JDK](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html)
- **Apache Tomcat 8.5**: [Download and install Tomcat 8.5](https://tomcat.apache.org/download-80.cgi)
- **MySQL**: [Download and install MySQL](https://dev.mysql.com/downloads/installer/)
- **Maven** (Optional, if using Maven for dependency management)(this is maven project)

add below dependency for Bcypt 
 <dependencies>
    <dependency>
      <groupId>org.mindrot</groupId>
      <artifactId>jbcrypt</artifactId>
      <version>0.4</version>
    </dependency>
    <!-- Add more dependencies as needed -->
  </dependencies>

  in mysql command prompt execute below queries
  
  
  CREATE DATABASE blogsphere;

USE blogsphere;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role ENUM('Admin', 'Viewer')
);

CREATE TABLE blog_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image LONGBLOB,
    video LONGBLOB,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

in sql cmd for increasing max_allowed_packet
SHOW VARIABLES LIKE 'max_allowed_packet';       //first check
SET GLOBAL max_allowed_packet = 256*1024*1024;
SHOW VARIABLES LIKE 'max_allowed_packet     //verify

try to upload videos and images less than 50mb

for youtube shorts  download use this link  :https://publer.io/tools/youtube-short-downloader
you can upload any  images from google

