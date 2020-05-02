docker build -t niallkenny/multi-client:latest -t niallkenny/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t niallkenny/multi-server:latest -t niallkenny/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t niallkenny/multi-worker:latest -t niallkenny/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push niallkenny/multi-client:latest
docker push niallkenny/multi-server:latest
docker push niallkenny/multi-worker:latest
docker push niallkenny/multi-client:$SHA
docker push niallkenny/multi-server:$SHA
docker push niallkenny/multi-worker:$SHA

kubectl apply ./k8s
kubectl set image deployments/client-deployment client=niallkenny/multi-client:$SHA
kubectl set image deployments/server-deployment server=niallkenny/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=niallkenny/multi-worker:$SHA
