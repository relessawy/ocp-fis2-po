# OpenShift FIS 2.0 Purchase Order (Example) Application

This FIS (Fuse Integration Services) application exposes a RESTful API for retrieving and storing *Purchase Orders* in a MySQL database server.  This is a Spring Boot application which runs within an embedded Apache Tomcat Web Server.

**Important Notes:**
- It is assumed that OpenShift platform is already running, if not you can find details on how to [Install OpenShift](https://docs.openshift.com/container-platform/3.3/install_config/index.html).
- Your system should be configured for Fabric8 Maven Workflow, if not you can find a [Get Started Guide](https://access.redhat.com/documentation/en/red-hat-jboss-middleware-for-openshift/3/single/red-hat-jboss-fuse-integration-services-20-for-openshift/)
- The Red Hat MySQL xPaaS product should already be installed and running on your OpenShift installation. A simple way to run a MySQL service is following the documentation of the MySQL xPaaS image for OpenShift related to the `mysql-ephemeral` template.
- This is a Spring Boot FIS 2.0 application and was tested on a OpenShift Container Platform v3.3 installation. This application should work on OpenShift CP v3.3 or higher.

### S2I Binary Workflow
Follow the steps below to deploy this application from a command window with OpenShift Client Tools installed.  The S2I binary workflow allows developers to rapidly develop FIS applications in an iterative manner - Develop -> Build -> Test -> Deploy.

The application can be built with

    mvn clean install

The application can be built and deployed using a single goal:

    $ mvn fabric8:deploy -Dmysql-service-username=<username> -Dmysql-service-password=<password>

Substitute appropriate values for 'username' and 'password' fields in the maven command above.  The `username` and `password` system properties correspond to the credentials used when deploying the MySQL database service.

To list all the running pods:

    oc get pods

Then find the name of the pod that runs this application, and output the logs from the running pods with:

    oc logs <name of pod>

You can also use the OpenShift [web console](https://docs.openshift.com/container-platform/3.3/getting_started/developers_console.html#developers-console-video) to manage the running pods, and view logs and much more.

### S2I Source and Application Template Workflow

An application template allows developers and IT Operations staff to deploy FIS applications to OpenShift by filling out a form in the OpenShift console and allows them to adjust deployment parameters.  The S2I Source and Application Template workflow allows IT Operations staff to rapidly deploy and promote FIS applications across multiple regions - Test -> Pre-Production -> Production.

First, download the `kubernetes.json` file from this GitHub repository to a machine with OpenShift Client Tools installed on it.

Next, login to the OpenShift Web Console and create a new project.  Click "Add to Project" button in the OpenShift console and select the template titled `fis2-spring-boot-camel-rest-sql`.

Make sure you specify the location of this GitHub project in the `GIT_REPO` field and specify the appropriate values for the MySQL database server `username` and `password`.  Then click on the **Create** application button on the bottom of the web page.

### Accessing the Purchase Order Application REST API 

As soon as the application is started, 10 purchase orders are inserted into the backend (MySQL) database.  The inserted purchase orders are numbered starting from id=1 to id=10.  When the application is running, a REST API is made available to list, create, update and delete purchase orders.

**NOTE**: The hostname (route) might vary depending upon your OpenShift setup. Use the command `oc get routes` to determine the hostname to be used in the REST API URL.

The REST API exposed by this FIS application can be accessed by using the _context-path_ (or Base Path) `purchase/`.  The REST API endpoint's exposed are as follows.

**`URI Template` : HTTP VERB : DESCRIPTION**
- `orders`: GET : To list all available purchase orders in the backend database.
- `orders/{id}`: GET : To get order details by `order id`.
- `orders` : POST : To create a new purchase order.  The API consumes and produces orders in `JSON` format.
- `orders/{id}` : PUT : To update a new purchase order. The API consumes and produces orders in `JSON` format.
- `orders/{id}` : DELETE : To delete a purchase order.

You can access the Purchase Order REST API from your Web browser, e.g.:

- <http://<hostname_route_url>/purchase/orders>
- <http://<hostname_route_url>/purchase/orders/1>

### Swagger API

The documentation for the REST API's exposed by this Purchase Order application can be accessed by using the _context-path_ `purchase/api-doc`, e.g.:

- <http://<hostname_route_url>/purchase/api-doc>

