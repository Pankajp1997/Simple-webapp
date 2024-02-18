# Adding Base Image for the applictaion to run 
FROM python:3.9
# Making the directory to store all our application code inside the container 
WORKDIR /app
# Copy the requirements inside the contanier 
COPY requirements.txt .
# Installing the required parameters/tool from the requirements.txt with the help of pip 
RUN pip install --no-cache-dir -r requirements.txt
# copy all from local directory to the container Workdirectory 
COPY . .
# expose the port on which the application will listen on container 
EXPOSE 5000
# Run the application with the CMD(command). 
CMD ["python", "app.py"]
