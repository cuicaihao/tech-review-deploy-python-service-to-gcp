echo "Please enter your Project ID:"
read PROJECT_ID
echo "Project ID is: $PROJECT_ID"

# Check if PROJECT_ID is empty
if [ -z "$PROJECT_ID" ]
then
    echo "Project ID cannot be empty. Exiting."
    exit 1
fi

# step 1: BUILD and Push Docker Image
docker build . -t australia-southeast1-docker.pkg.dev/${PROJECT_ID}/docker-registry/hello-app:latest
# docker run -p 8080:8080 australia-southeast1-docker.pkg.dev/${PROJECT_ID}/docker-registry/hello-app:latest

# step 2: Push the docker image to the repository
docker push australia-southeast1-docker.pkg.dev/${PROJECT_ID}/docker-registry/hello-app:latest

# step 3: Deploy the app to Google Cloud Run requiring authentication
gcloud run deploy hello-app \
    --image=australia-southeast1-docker.pkg.dev/${PROJECT_ID}/docker-registry/hello-app:latest \
    --platform=managed \
    --region=australia-southeast1 \
    --service-account=langchain-app-cr@${PROJECT_ID}.iam.gserviceaccount.com \
    --port=8080