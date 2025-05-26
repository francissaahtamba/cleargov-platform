import os
import webbrowser
import time

# Change to the project directory (where manage.py is)
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# Wait a moment then open the app in the browser
time.sleep(2)
webbrowser.open("http://127.0.0.1:8000")

# Start the Django development server
os.system("python manage.py runserver")