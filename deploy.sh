docker build -t shubham01/multi-client:latest shubham01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shubham01/multi-server:latest shubham01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shubham01/multi-worker:latest shubham01/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shubham01/multi-client:latest
docker push shubham01/multi-server:latest
docker push shubham01/multi-worker:latest
docker push shubham01/multi-client:$SHA
docker push shubham01/multi-server:$SHA
docker push shubham01/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=shubham01/multi-client:$SHA
kubectl set image deployments/server-deployment server=shubham01/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shubham01/multi-worker:$SHA