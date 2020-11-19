FROM python:3.6
# Copy contents into image
COPY . .
# run req
RUN pip install -r requirements.txt
# run pip dependencies
RUN pip install Flask flask-sqlalchemy pymysql
# Expose correct port
EXPOSE 5001
# Create an entrypoint
ENTRYPOINT ["python3","app.py"]
