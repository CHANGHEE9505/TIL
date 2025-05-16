# 자동화 관리도구

## 1. **Ansible** 개요

### 개요
- IaC(Infrastructure as Code, 인프라 관리를 코드 기반)으로 자동화 해주는 오픈소스 기반의 **자동화 관리 도구** 이다.

# 📦 Ansible 특징 및 용어 정리

## ✅ Ansible 특징

### 🔹 Agentless

- 기존 IaC 솔루션인 **Chef / Puppet**은 원격 서버에 *Agent* 설치가 필요함.
- Ansible은 **SSH 기반으로 명령을 전달**하여 에이전트 설치가 필요 없음.
  - 각 서버에 접속해 Agent를 설치할 필요가 없으므로 **자동화 효율성** 증가.
  - 인프라 구축이 **간편하고 빠름**.

---

### 🔹 접근 용이성

- Ansible은 **Controller 서버에서 명령어를 전달**하는 구조.
- 단일 명령어 입력도 가능하지만, **자동화를 위해 Playbook 사용**이 일반적.
- Playbook은 **YAML 형식**의 파일로 작성됨.
  - ✅ YAML은 **가독성이 뛰어나며**, 진입장벽이 낮음.
  - ✅ 명령어들을 한 번에 실행할 수 있어 **쉘 스크립트처럼 사용 가능**.

---

### 🔹 멱등성 (Idempotence)

- 동일한 작업을 여러 번 실행해도 **결과가 항상 같음**.
- Ansible은 이를 위해 내부적으로 상태를 체크하고 불필요한 작업은 생략.

---

## 🛠️ Ansible 주요 용어

### 📍 Controller 서버

- Ansible 명령을 **전달하는 주체**.
- 원격 서버에는 에이전트가 없으므로, **Ansible은 Controller 서버에만 설치**하면 됨.

---

### 📍 인벤토리 (Inventory)

- 명령을 보낼 **원격 서버 목록**.
- 기본 경로: `/etc/ansible/hosts`
- 종종 **Ansible Hosts**라고도 불림.

---

### 📍 플레이북 (Playbook)

- 원격 서버에 전달할 **명령어 모음집**.
- YAML 형식으로 구성되며, **자동화 스크립트**로 활용됨.

## 2. **Ansible** 설치 및 초기 설정

## 🖥️ 실습 환경 (NAT 구성)

### ✅ Controller 서버
- CentOS 7.9.2207
- IP: `192.168.10.128`
- 게이트웨이: `192.168.10.2`
- DNS: `192.168.10.2`
- **Ansible**은 이곳에만 설치하면 된다.

### ✅ Ansible Node1 (원격 서버)
- CentOS 7.9.2207
- IP: `192.168.10.129`
- 게이트웨이: `192.168.10.2`
- DNS: `192.168.10.2`



#### 128

#### 저장소 추가 후 'Ansible' 설치

![](./img/1.img/0001.png)

##### 패키지 추가
```
yum -y install ansible
```

![](./img/1.img/0002.png)

```
rpm -qa | grep ansible
ansible --version
```

#### Step 2. SSH Key 생성
- 개요
  - Ansible 은 SSH 접속 을 기반으로 원격 서버들에게 명령을 전달 하기 때문에 Controller서버와 원격 서버간 SSH Key가 공유 되어야 한다.
  - Controller 서버 에서 모든 것을 완료할 수 있다.

- 작업
- 인증키 생성

![](./img/1.img/0003.png)
```
ssh-keygen
```
![](./img/1.img/0004.png)
```
ssh-copy-id root@192.168.10.129
```

- 원격 서버에 키 복사 및 확인

![](./img/1.img/0005.png)

- 접속 테스트

![](./img/1.img/0006.png)





