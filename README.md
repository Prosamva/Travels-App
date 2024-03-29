# Travels App
## Summer Clouds Travels Service

### Web Application
**Summer Clouds Travels Service** is a web application developed using _ReactJS, NodeJS, Express &amp; MySQL_.
This application is developed to make use of various popular web frameworks, libraries, and cloud services. The application is designed for educational purposes, so for simplicity, little emphasis is put on business logic to meet absolute standards and strict constraints. The application saves the user's data based on the user's facial identity. The registrations/bookings of the user can be visited by verifying their facial identity.

### Cloud
Various cloud services provided by AWS in the free tier are used. The application is deployed on an *AWS EC2* Ubuntu virtual machine instance. The static website and NodeJS server are deployed and served by an *NGINX* web server. The application uses *AWS Rekognition* service for facial recognition and verification features. The database used is provided by *AWS RDS*.
<br><br>
<img src="screenshots/architecture.png" width="700px" alt="Architecture">

### Database
A *MySQL* database is used for this web application. The database is deployed on *AWS Relational Database Service (RDS)*.
#### Database description
- A country bus company owns several buses. A bus is characterized by its id number, no. of chairs, options (AC, Automatic, PS), and brand name.
- Each bus is allocated to a particular route, although some may have several buses. Each route is described by KM, start point, endpoint and duration.
- Each route can pass through many towns.
- A town may be situated along several routes. We keep track of unique names and station names in each town.
- One or more drivers are allocated to one route during a period. The system keeps the information about the driver's name, mobile number, hire date, basic salary, and job grade.
- The system keeps the information about any changes in the allocations of the drivers to the routes and the last route assigned to each driver.
- A customer can book a slot in multiple buses. Customer is identified by their facial identity.

#### Database Design
<img src="screenshots/db-design.png" width="700px" alt="Database Design">

#### Database Sample Snapshot
<img src="screenshots/db-snapshot.png" width="700px" alt="Database Sample Snapshot">

### Website Screenshots
<img src="screenshots/home1.png" width="250px">
<img src="screenshots/home2.png" width="250px">
<img src="screenshots/home3.png" width="250px">
<img src="screenshots/register.png" width="250px">
<img src="screenshots/home4.png" width="250px">
<img src="screenshots/verify.png" width="250px">
<img src="screenshots/loading.png" width="250px">
<img src="screenshots/details.png" width="250px">
