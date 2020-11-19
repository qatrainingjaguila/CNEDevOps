FROM python:3.6
# Install apt dependencies
WORKDIR /files
# Copy contents into image
COPY . /files
# run req
RUN pip install -r /files/requirements.txt
# run pip dependencies
RUN pip install Flask flask-sqlalchemy pymysql pytest
#run tests

# Expose correct port
EXPOSE 5000
# Create an entrypoint
ENTRYPOINT ["python3","app.py"]
