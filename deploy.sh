docker build -t befilosz/multi-client:latest -t befilosz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t befilosz/multi-server:latest -t befilosz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t befilosz/multi-worker:latest -t befilosz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push befilosz/multi-client:latest
docker push befilosz/multi-server:latest
docker push befilosz/multi-worker:latest

docker push befilosz/multi-client:$SHA
docker push befilosz/multi-server:$SHA
docker push befilosz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=befilosz/multi-server:$SHA
kubectl set image deployments/client-deployment client=befilosz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=befilosz/multi-worker:$SHA