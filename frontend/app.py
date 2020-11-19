from application import app


if __name__ == '__main__':
    app.debug = True
    app.run(port=5000, host='0.0.0.0')
