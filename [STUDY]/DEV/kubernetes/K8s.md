# Kubernetes Cluster 환경 구축 및 관리

이 문서는 3-node Kubernetes 클러스터 초기화 및 Amazon EKS 환경 구성에 대한 내용을 요약합니다.

## 1. 3-Node Kubernetes 클러스터 초기화 (kubeadm)

### 1.1. Kubernetes 클러스터 초기화 (Master Node)

`kubeadm init` 명령을 사용하여 마스터 노드를 초기화합니다. `--pod-network-cidr`는 Pod 네트워크의 IP 주소 범위를 지정하며, `--apiserver-advertise-address`는 API 서버가 수신 대기할 IP 주소를 설정합니다.

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.101
```
초기화가 완료되면, 일반 사용자 계정으로 `kubectl`을 사용할 수 있도록 설정합니다.

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

node1, node2에 sudo 붙여서
```
kubeadm join 192.168.56.101:6443 --token mrhkzk.yqynjvsez8vdpdfw \
        --discovery-token-ca-cert-hash sha256:079ebf5564b57a6fe09d6018fee7e8a2328f3d17bf1fb6662f501cc62b461855

```
### 1.2. Pod 네트워크 배포 (CNI 설치)

Kubernetes 클러스터 내 Pod 간 통신을 위해 CNI(Container Network Interface) 플러그인을 설치해야 합니다. `kubenet`은 기본 CNI이지만 기능이 제한적이므로, Calico와 같은 3rd-party CNI를 사용하는 것이 일반적입니다.

**Calico 설치 예시:**

Calico YAML 파일 다운로드:
```bash
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/calico.yaml
```
```
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/calico.yaml

```
```
sed -i 's/192.168.0.0\/16/10.244.0.0\/16/g' calico.yaml
```
```
kubectl apply -f calico.yaml
```
```
kubectl delete pods -n kube-system -l k8s-app=calico-node
kubectl delete pods -n kube-system -l k8s-app=calico-kube-controllers
```
여기까지 모두 초기화

### 1.3. Worker Node 클러스터 조인

워커 노드를 클러스터에 조인하려면 마스터 노드에서 생성된 `kubeadm join` 명령을 사용합니다. 이 명령은 토큰과 CA 인증서 해시를 포함합니다.

**토큰 확인 및 재생성:**

기존 토큰을 확인하거나 만료된 경우 새로운 토큰을 생성할 수 있습니다.
```bash
# 기존 토큰 목록 확인
kubeadm token list

# 새로운 토큰 생성 및 조인 명령어 출력 (만료 기간 없음)
kubeadm token create --ttl 0 --print-join-command
```

**Worker Node 조인 예시:**

```bash
sudo kubeadm join <Master_Node_IP>:6443 --token <token> --discovery-token-ca-cert-hash <hash>
```

### 1.4. `kubectl` 자동 완성 및 Alias 설정

`kubectl` 사용 편의성을 위해 자동 완성 기능을 설정하고 자주 사용하는 명령에 대한 alias를 지정할 수 있습니다.

```bash
# bash-completion 설치
sudo apt install bash-completion -y

# kubectl 자동 완성 설정
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
complete -F _start_kubectl k

# 자주 사용하는 kubectl alias 설정 (예시)
alias k=kubectl
alias kg='kubectl get'
alias kc='kubectl create'
alias ka='kubectl apply'
alias kr='kubectl run'
alias kd='kubectl delete'
```

### 1.5. 클러스터 상태 확인

```bash
# 노드 상태 확인
kubectl get nodes

# 모든 네임스페이스의 Pod 상태 확인
kubectl get po -A
```

## 2. Amazon EKS (Elastic Kubernetes Service) 환경 구성

Amazon EKS는 AWS 클라우드에서 Kubernetes를 실행하는 관리형 서비스입니다.

### 2.1. Amazon EKS 소개

*   AWS에서 Kubernetes 컨트롤 플레인의 가용성 및 확장성을 관리합니다.
*   컨테이너 스케줄링, 애플리케이션 가용성, 클러스터 데이터 저장 등의 작업을 담당합니다.
*   AWS 네트워킹 및 보안 서비스와 통합되어 AWS 인프라의 성능, 규모, 신뢰성을 활용할 수 있습니다.

### 2.2. `kubectl` 및 `eksctl` 설치

Amazon EKS 클러스터를 관리하기 위해 `kubectl`과 `eksctl` CLI 도구가 필요합니다.

**`kubectl` 설치 (Linux 예시):**

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

**`eksctl` 설치 (Linux 예시):**

```bash
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

### 2.3. Amazon EKS 클러스터 생성 (`eksctl`)

`eksctl create cluster` 명령을 사용하여 EKS 클러스터를 생성합니다. 이 과정은 10~15분 정도 소요될 수 있습니다.

```bash
eksctl create cluster \
  --name dev-cluster \
  --nodegroup-name dev-nodes \
  --node-type t3.medium \
  --nodes 3 \
  --nodes-min 1 \
  --nodes-max 4 \
  --managed \
  --version 1.27 \
  --region <AWS_REGION>
```

*   `--name`: 클러스터 이름
*   `--nodegroup-name`: 노드 그룹 이름
*   `--node-type`: 인스턴스 유형
*   `--nodes`: 초기 노드 수
*   `--nodes-min`, `--nodes-max`: 오토스케일링을 위한 최소/최대 노드 수
*   `--managed`: 관리형 노드 그룹 사용
*   `--version`: Kubernetes 버전 (예: 1.27)
*   `--region`: AWS 리전

### 2.4. EKS 클러스터 상태 확인

클러스터 생성 후 `kubectl`을 사용하여 노드 및 Pod 상태를 확인할 수 있습니다.

```bash
# EKS 클러스터 노드 상태 확인
kubectl get nodes
```
