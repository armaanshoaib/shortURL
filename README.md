
# ShortURL

A URL shortening and retrieval application built with Java (JSP) and
MySQL using Docker Compose.

## Project Overview

This project demonstrates an architecture where a Tomcat web server
interacts with a MySQL database within an isolated Docker network. The
application allows users to generate short aliases for long URLs and
retrieve them later.

## Tech Stack

-   Frontend/Backend: Java Server Pages (JSP)
-   Web Server: Apache Tomcat 9.0+
-   Database: MySQL 8.0+
-   Containerization: Docker & Docker Compose
-   CI/CD: Docker Hub (Image: armaanshoaibas/shorturl-web:1.0)

## Project Structure

    .
    └── shortURL
        ├── docker-compose.yml
        └── web
            ├── Dockerfile
            ├── ROOT.war
            ├── generate.jsp
            ├── retrieve.jsp
            ├── WEB-INF/lib/

## Quick Start (Deployment)

### Prerequisites

-   Docker and Docker Compose installed.
-   Port 8080 (Web) and 3306 (DB) must be available.

### Steps to Run

1.  Clone the repository:

        git clone https://github.com/armaanshoaibas/shortURL.git
        cd shortURL

2.  Launch the stack:

        docker-compose up -d

3.  Access the Application: http://localhost:8080

## Configuration Details

### Database Connection

-   Host: db
-   Port: 3306
-   Credentials: root / root
-   Driver: com.mysql.cj.jdbc.Driver

### Data Persistence

We use a Named Volume (sql-nv):

    volumes:
      - sql-nv:/var/lib/mysql

## Development & Building

1.  Rebuild WAR:

        jar -cvf ROOT.war *

2.  Rebuild Docker Image:

        docker-compose build web

## Troubleshooting & FAQ

**Q: 500 Internal Server Error on first launch?**\
A: MySQL may take 15--20 seconds to initialize.

**Q: How to view DB manually?**\
A: Use TablePlus or MySQL Workbench at localhost:3306.

**Q: High CPU usage on EC2?**\
A: Ensure at least 1GB RAM and enable swap.

## Author

Armaan Shoaib\
- Docker Hub: [armaanshoaibas](https://hub.docker.com/repositories/armaanshoaibas)
- GitHub: [armaanshoaib](https://github.com/armaanshoaib)
