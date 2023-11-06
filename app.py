from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        address = request.form['address']
        mobile = request.form['mobile']
        return render_template('result.html', name=name, email=email, address=address, mobile=mobile)
    return render_template('form.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
