docker build -t chinedunsidinanya/multi-client:latest -t chinedunsidinanya/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t chinedunsidinanya/multi-server:latest -t chinedunsidinanya/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t chinedunsidinanya/multi-worker:latest -t chinedunsidinanya?multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push chinedunsidinanya/multi-client:latest
docker push chinedunsidinanya/multi-server:latest
docker push chinedunsidinanya/multi-worker:latest

docker push chinedunsidinanya/multi-client:$GIT_SHA
docker push chinedunsidinanya/multi-server:$GIT_SHA
docker push chinedunsidinanya/multi-worker:$GIT_SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=chinedunsidinanya/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=chinedunsidinanya/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=chinedunsidinanya/multi-worker:$GIT_SHA
