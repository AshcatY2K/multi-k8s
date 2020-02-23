docker build -t igdevloper/multi-client:latest -t igdevloper/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t igdevloper/multi-server:latest -t igdevloper/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t igdevloper/multi-worker:latest -t igdevloper/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push igdevloper/multi-client:latest
docker push igdevloper/multi-server:latest
docker push igdevloper/multi-worker:latest

docker push igdevloper/multi-client:$SHA
docker push igdevloper/multi-server:$SHA
docker push igdevloper/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployment/client-deployment client=igdevloper/multi-client$SHA
kubectl set image deployment/server-deployment server=igdevloper/multi-server$SHA
kubectl set image deployment/worker-deployment worker=igdevloper/multi-worker$SHA