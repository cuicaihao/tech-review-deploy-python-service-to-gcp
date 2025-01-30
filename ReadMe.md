# Tech Review: How to Deploy Python Service to Google Cloud Platform 

This repository demonstrates how to deploy a simple Python Flask web application to Google Cloud Platform services, including App Engine and Cloud Run.


## Experiments Conducted:

-  ✅ Running local Python source code.
-  ✅ Building and running Docker locally.
-  ✅ Deploying Flask App to Cloud Run / App Engine from source.
-  ✅ Deploying Flask App to App Engine using a standard instance.
-  ✅ Deploying Flask App to App Engine using a flexible environment (Docker).
-  ✅ Building, pushing, and deploying Flask App to Cloud Run using Cloud Build.


## Quick Start Guide

1. Create a local Python environment at `.venv` using Python 3.11 and the requirements specified in `hello_app/requirements.txt`. 
    - TIPS: If you use VS Code, press `Cmd+Shift+P`, search `Python: Create Environment...`,  and follow the prompts.
      - Select Python 3.11.xxx.xxx
      - Check the suggested requirements.txt.
      - Restart you terminal (`Ctrl+Shift+`).
    - Alternatively, you can use the `make` commands s1 and s2.
2. Set up your `gcloud cli`, You can find the installation steps [here](https://cloud.google.com/sdk/docs/install)
3. Activate the appropriate GCP project using commands like:
    - `gcloud config configurations list` 
    - `gcloud cofig configurations activate YOUR_CONFIG_NAME`
4. Run `make` in the terminal to view the existing rules.

    You will get a list of commands to support quick runs.
    | Rule                                 | Description                                        |
    | ------------------------------------ | -------------------------------------------------- |
    | s1_create_environment                | Step 1: Create python virtual environment          |
    | s2_requirements                      | Step 2: Install requirements                       |
    | s3_test                              | Step 3: Local Test                                 |
    | s4_local_run                         | Step 4: Local Run                                  |
    | s5_deploy_to_app_engine_from_source  | Step 5: Deploy the Model to App Engine from Source |
    | s6_deploy_to_cloud_run_from_source   | Step 6: Deploy the Model to Cloud Run from Source  |
    | s7_local_docker_build_and_run        | Step 7: Local docker build and run                 |
    | s8_deploy_to_app_engine_using_docker | Step 8: Deploy to App Engine using docker          |
    | s9_deploy_to_cloud_run_using_docker  | Step 9: Deploy to Cloud Run using docker           |


Note
- Find more details in `makefile`. 
- The default COMPUTE_DEFAULT_REGION is `australia-southeast1`, modify the code to suit your gcloud settings.
- Remember to Enable google Cloud Run and App Engine services for s5-s9; and create service account for the best practice.

 ## Example: Local Flask Run

After setting the  `venv` , start the flask app by the following cmd:

```bash
make s4_local_run 
```
You should see results like 

```bash
source .venv/bin/activate && python hello_app/main.py
 * Serving Flask app 'main'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8080
 ...
Press CTRL+C to quit
127.0.0.1 - - [20/May/2024 10:23:42] "GET / HTTP/1.1" 200 -
```

You can copy and paste the following links to test the flask app:

| Page/Func | URL                                   |
| --------- | ------------------------------------- |
| Home      | http://127.0.0.1:8080/                |
| About     | http://127.0.0.1:8080/about/          |
| Contact   | http://127.0.0.1:8080/contact/        |
| Hello     | http://127.0.0.1:8080/hello/YOUR_NAME |
| API       | http://127.0.0.1:8080/api/data        |

## Reference
1. [Install the Google Cloud CLI](https://cloud.google.com/sdk/docs/install-sdk)
2. [App Engine documentation](https://cloud.google.com/appengine/docs)
3. [App Engine standard environment](https://cloud.google.com/appengine/docs/standard)
4. [App Engine Flexible Environment](https://cloud.google.com/appengine/docs/flexible/python/runtime)
5. [Cloud Run documentation](https://cloud.google.com/run/docs)
6. [Quickstart: Deploy a Python service to Cloud Run](https://cloud.google.com/run/docs/quickstarts/build-and-deploy/deploy-python-service)
7. [Build applications or websites quickly on a fully managed platform](https://cloud.google.com/run?hl=en#websites-and-web-applications)
8. [Cloud Build](https://cloud.google.com/build/docs/overview)
9. [Cloud Build Trigger / CI/CD](https://cloud.google.com/build/docs/triggers)
10. [Deploying to Cloud Run using Cloud Build ](https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run)
11. [Deploying to App Engine](https://cloud.google.com/build/docs/deploying-builds/deploy-appengine)


---
END