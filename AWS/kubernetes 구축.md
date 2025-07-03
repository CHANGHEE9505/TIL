# kubernetes 구축 -> container runtime 없음 -> containerd or cri-o 
## 기업형(운영 k8s)
- kubeadm init
- 대규모 -> kubespray 

- 개발,테스트용
    - kind(kubernetes in docker)
    - minikube, k3s
    - 바닐라 쿠버네티스






- master node 1 worker node 2 [* docker node + image registry]


- doker -> /var/lib/docker -> 별도의 디스크