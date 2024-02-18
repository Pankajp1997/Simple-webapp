# Simple-webapp
This is the simple webapp written in flask.

#### Always make sure that you have opened the inbound port which is mentioned in the app.py or in Dockerfile. This work can be done via AWS console and from ec2 security group. Do not give ALL traffic permission, try opening only the required port. 

# Run Flask App on AWS EC2 Instance
## Install python virtual environment 
```bash
sudo apt-get update
sudo apt-get install python3-venv
```
## Activate the new virtual environment in a new directory
## Create directory
```bash
mkdir flask-app
cd flask-app
```
## Create the virtual environment
```bash
python3 -m venv venv
```
## Activate the virtual environment 
```bash
source venv/bin/activate
```
## Install pip 
```bash
sudo apt-get install python3-pip
```
## Install Flask 
```bash
pip install Flask
```
## Verify the app works by executing the below command 
```bash
python3 app.py
```
#### Run Gunicorn WSGI server to serve the Flask Application When you “run” flask, you are actually running Werkzeug’s development WSGI server, which forward requests from a web server. Since Werkzeug is only for development, we have to use Gunicorn, which is a production-ready WSGI server, to serve our application.
## Install Gunicorn using the below command:
```python
pip install gunicorn
```
## Try Running the gunicorn 
```bash
gunicorn -b 0.0.0.0:8000 app:app
```
### Gunicorn is running (Ctrl + C to exit gunicorn)!

#### Use systemd to manage Gunicorn Systemd is a boot manager for Linux. We are using it to restart gunicorn if the EC2 restarts or reboots for some reason. We create a .service file in the /etc/systemd/system folder, and specify what would happen to gunicorn when the system reboots. We will be adding 3 parts to systemd Unit file — Unit, Service, Install

####  Unit — This section is for description about the project and some dependencies Service — To specify user/group we want to run this service after. Also some information about the executables and the commands. Install — tells systemd at which moment during boot process this service should start. With that said, create an unit file in the /etc/systemd/system directory
```bash
sudo vim /etc/systemd/system/flask-app.service
```
```python 
## Then add[Unit]
Description=Gunicorn instance for a simple flask-app
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/flask-app
ExecStart=/home/ubuntu/flask-app/venv/bin/gunicorn -b localhost:8000 app:app
Restart=always
[Install]
WantedBy=multi-user.target this into the file.
```
## Enable the service
```bash
sudo systemctl daemon-reload
sudo systemctl start flask-app
sudo systemctl enable flask-app
```
## Check the app is runnig with
```bash
curl http://localhost:8000
```
## Run Nginx Webserver to accept and route request to Gunicorn Finally, we set up Nginx as a reverse-proxy to accept the requests from the user and route it to gunicorn.
```bash
sudo apt-get install nginx -y
```
## Start the Nginx service and go to the Public IP address of your EC2 on the browser to see the default nginx landing page. 
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```
## Edit the default file in the sites-available folder.
```bash 
sudo vim /etc/nginx/sites-available/default
```
## Add the following code at the top of the file (below the default comments)
```bash
upstream flaskflask-app {
    server 127.0.0.1:8000;
}
```
## Add a proxy_pass to flaskflask-app at location /
```bash
proxy_pass http://flaskflask-app;
```
## Restart nginx 
```bash
sudo systemctl restart nginx
```
## There you go check and your application is live :)
