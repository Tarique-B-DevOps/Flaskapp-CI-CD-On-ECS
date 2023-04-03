# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory
WORKDIR /flask-helloapp

# Copy app content to container directory.
COPY . .

# install app dependencies
RUN pip3 install -r requirements.txt


# start the application 
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
