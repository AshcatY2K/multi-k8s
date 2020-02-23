docker build -t igdeveloper/multi-client:latest -t igdeveloper/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t igdeveloper/multi-server:latest -t igdeveloper/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t igdeveloper/multi-worker:latest -t igdeveloper/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push igdeveloper/multi-client:latest
docker push igdeveloper/multi-server:latest
docker push igdeveloper/multi-worker:latest

docker push igdeveloper/multi-client:$SHA
docker push igdeveloper/multi-server:$SHA
docker push igdeveloper/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployment/client-deployment client=igdeveloper/multi-client$SHA
kubectl set image deployment/server-deployment server=igdeveloper/multi-server$SHA
kubectl set image deployment/worker-deployment worker=igdeveloper/multi-worker$SHA