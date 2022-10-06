import os
import subprocess

user_name_key = os.environ.get("PARAM_GIT_USER_NAME")
user_email_key = os.environ.get("PARAM_GIT_USER_EMAIL")

email = os.environ.get(user_email_key)
name = os.environ.get(user_name_key)

subprocess.run(["git", "config", "user.name", f"{name}"])
subprocess.run(["git", "config", "user.name", f"{email}"])


subprocess.run(["git", "config", "user.name"])
subprocess.run(["git", "config", "user.email"])