# 자동화 관리도구

## 1. **Ansible** 개요

### 개요
- IaC(Infrastructure as Code, 인프라 관리를 코드 기반)으로 자동화 해주는 오픈소스 기반의 **자동화 관리 도구** 이다.

# 📦 Ansible 특징 및 용어 정리

## ✅ Ansible 특징

### 🔹 Ansible **이전**의 IaC

- `Chef`, `Puppet` 등 기존의 IaC 도구는 **원격 서버에 에이전트(Agent)를 설치**해야 했다.
- 구조:
  - **Controller 서버** ↔️ **원격 서버에 설치된 Agent**
  - 명령은 Controller가 Agent에게 전달하여 실행됨.
- 🔧 **단점**: 원격 서버에 별도의 Agent 설치 필요 → 초기 설정과 유지관리의 부담 증가.

---

### 🔹 Ansible **이후**의 IaC

- ✅ **Ansible은 SSH 기반**으로 명령을 원격 서버에 직접 전달함.
- ✅ **Agent가 필요 없음** → 원격 서버에 접속해서 따로 Agent를 설치할 필요 없음.
- 💡 핵심 장점:
  - Agent 설치 단계를 제거하여 **더 간결하고 자동화된 인프라 구축 가능**
  - **구성이 단순**해지고 관리가 용이해짐.

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

![128](./img/1.img/0001.png)

##### 패키지 추가
```
yum -y install ansible
```

![128](./img/1.img/0002.png)

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

![128](./img/1.img/0003.png)
```
ssh-keygen
```
![128](./img/1.img/0004.png)
```
ssh-copy-id root@192.168.10.129
```

- 원격 서버에 키 복사 및 확인

![129](./img/1.img/0005.png)

- 접속 테스트

![](./img/1.img/0006.png)

#### Step 3. 인베토리 (Inventory, 재고) 파일 작성

##### 개요
- (/etc/ansible/hosts)를 **인벤토리 파일** 이라고 한다.
- 이 파일을 열고 **원격 서버의 IP(#129)** 를 추가하면 된다.

##### 작업
- 파일 편집

![128](./img/1.img/0008.png)
```
vi /etc/ansible/hosts 
```
![](./img/1.img/0007.png)
맨 위에 192.168.10.129 추가

- 접속 테스트

![128](./img/1.img/0009.png)
```
ansible all -m ping
```
SUCCESS확인


#### Step 4. Ansible 명령어 구조
- 구조
```
ansible [host 또는 host그룹] options
```
- 설명

##### [host 또는 host그룹]

- Ansible 명령을 전달할 원격 서버(Node(s))들을 설정 한다.
- 'all'을 사용하면 인벤토리에 입력(/etc/ansible/hosts)되어 있는 모든 원격 서버에 명령을 전달한다. 

##### -m 
- 가장 많이 사용하는 옵션
- Ansible에서 실행할 모듈을 호출하는 옵션이다.

## 실습 1. 'Ansible' 이해를 위한 기본 실습
### 개요
**Controller 서버**에 '/Ansible/test.txt' 파일을 생성한 후 '원격 서버'에 복사

## 명령 실행
### 129

![129](./img/1.img/0011.png)

### 128


![128](./img/1.img/0010.png)

```
mkdir /Ansible
echo "Ansible Structure! by Samadal" > test.txt
ansible all -m copy -a "src=./test.txt dest=/Nodel/test.txt"
```

- host
  - 'all'을 넣어서 인벤토리에 있는 모든 원격 서버에 명령을 전달한다. 
- copy
  - 이 copy 모듈을 불러와서 파일 복사 명령을 수행하도록 한다.
- -a
  - copy 모듈에 필요한 인자값을 전달하는 옵션이다.
  - src file의 경로와 dest file 경로를 전달한다.

  ![129](./img/1.img/0012.png)

## 실습 2. 옵션을 이용할 실습

### 개요
- '원격 서버'는 Ansible NodeX'라고 한다.

### 옵션 1. '-i'
- 적용될 노드(들)을 선택한다.
- 작업
```
echo "192.168.10.129" > customized_inven.1st
```
- **customized_inven.1st** 파일에 'Ansible Node1(#129)의 'IP'를 삽입한다.

### 옵션 2. '-k'
  - 적용될 노드(들)의 암호를 물어보도록 설정한다.
  - 작업
    - ssh 인증키가 등록되어 있는경우 '-k'를 입력하지 않아도 된다.

  ![128](./img/1.img/0013.png)

  ![128](./img/1.img/0014.png)

  ![128](./img/1.img/0015.png)
  백그라운드가 연결 되어 있어서 비밀 번호를 물어보지 않는다 옵션 k를 사용하여

  ![129](./img/1.img/0016.png)
  ssh 키를 /root/.ssh에서 다른곳으로 옮기면 이러한 오류가 발생한다.

리눅스만 사용 ip대역 동일하게 맞춘다. 192.168.14.14, 192.168.14.15 bridge, 3번째 옥텍 같은 대역
  ![129](./img/1.img/0017.png)

두번째 라우터 연결(생략) 가능 다른 대역

### 옵션 3. '--list-hosts'
- 적용되는 노드(들)을 확인한다.
- 어떤 노드들이 적용되는지 확인해야 할 필요가 있을 때 사용한다.
- 명령이 실제로 수행되고 적용되는 것이 아니라 확인만 할 뿐이다.

![](./img/1.img/0018.png)

### 옵션 4. '-m shell'
- 개요
  - 사용할 모듈을 선택하는 용도로 사용된다.
  - 노드들에 명령 구분을 전달하고 해당 결과를 다시 반환하는 모듈
  - 'shell'은 'Bash Shell'과 같은 역할을 하고 '-a'는 uptime, cd, ls, ..등의 명령구문으로 이루어져 있다.
  - 'shell' 모듈 뒤에는 '-a' 옵션으로 필요한 인자값을 넣어서 사용한다.
- 작업
  - 작업 1. 'Ansible' 명령으로 'Module'을 확인한다.
  - 작업 2. 모든 Node들의 가동 시간을 확인한다.
  ![](./img/1.img/0019.png)

  - 작업 3. 디스크 사용량과 메모리 사용량을 확인
  ![](./img/1.img/0020.png)

    ![](./img/1.img/0021.png)
  - 작업 4. 큰 따옴표("")는 가급적 사용하는 것이 좋다. 
    ![](./img/1.img/0022.png)

### 'user' Module

#### 개요
  - 사용자를 추가/삭제/관리하기에 유용한 기능을 제공한다.
#### 작업환경
  - 신규 시스템 한 개 더 추가한다.
#### 작업 1. 사용자 추가(-m user -a "name=유저")
- (오류) 'Node의 IP'가 등록된 '파일(customized_inven.1st)'을 이용해서 사용자 추가
- 인벤토리 파일에 신규 Node의 IP를 등록하고 사용자 추가

![](./img/1.img/0023.png)

- 신규 Node 시스템에 인증키 복사 후 사용자 추가
```
ssh-copy-id root@192.168.10.130
```

- (정상) 신규 Node 시스템에 인증키 복사 후 사용자 추가

![](./img/1.img/0024.png)

![](./img/1.img/0025.png)

![](./img/1.img/0026.png)

![](./img/1.img/0027.png)

![](./img/1.img/0028.png)

![](./img/1.img/0029.png)

```
ansible all -m user -a "name=clouddx"
```

```
ansible all -i customized_inven.1st -m user -a "name=clouddx"
```

#### 작업 2. 사용자 삭제(-m user -a "name = 유저 state=absent")

![](./img/1.img/0030.png)

### 'yum' Module 
### 작업 1. 패키지 설치 유무에 따른 학습
#### 패키지 확인
![](./img/1.img/0031.png)


#### 패키지가 설치되어 있는 경우
![](./img/1.img/0032.png)


#### 패키지가 설치되어 있지 않은 경우

![](./img/1.img/0033.png)

![](./img/1.img/0034.png)

![](./img/1.img/0035.png)

![](./img/1.img/0036.png)

### 작업 2. Ansible 환경설정 변경 유무에 따른 패키지 확인
- 패키지 확인 -Ansible 환경설정 수정 전
- 패키지 확인 -Ansible 환경설정 수정 후

```
find / -name ansible.cfg -type f
```

![](./img/1.img/0037.png)

```
vi /etc/ansible/ansible.cfg  
```
188 번 주석 해제

![](./img/1.img/0038.png)
```
[WARNING]: Consider using the yum, dnf or zypper module rather than running 'rpm'.  If you need to use command because
yum, dnf or zypper is insufficient you can add 'warn: false' to this command task or set 'command_warnings=False' in
ansible.cfg to get rid of this message.
```
아까 나오던 핑크색 경고 문구가 안나옴

### 'copy' Module 
#### 개요
- Controller 서버에서 원격 서버에 파일을 전송할 때 사용하는 모듈이다.

![](./img/1.img/0039.png)
#### 작업 1. 로컬 시스템에서의 작업
- 기본 웹 페이지 파일 다운로드
- Apache 기본 경로(/var/www/html)에 기본 파일(index.html) 생성

![](./img/1.img/0040.png)

![](./img/1.img/0041.png)

#### 작업 2. public Cloud 시스템과 연동

- /Ansible에 ec2.lst라는 파일 생성
- /Ansible에 임의의 내용을 입력한 test.txt 파일 생성
- AWS에서 EC2 Instance를 한 개 생성한 후 EC2 콘솔창에서 /ec2라는 디렉터리 생성
- EC2 Instance의 보안에서 22번 포트를 추가
- Public IP를 ec2.lst 파일에 입력한다.
- /Ansible에 있는 test.txt를 EC2 Instance 시스템에 복사

![](./img/1.img/0042.png)

![](./img/1.img/0043.png)

![](./img/1.img/0044.png)

```
ansible all -m service -a "name=httpd state=started"
```

```
ansible all -m shell -a "ps -ef | grep httpd"
```
![](./img/1.img/0045.png)

![](./img/1.img/0046.png)

## 실습 4. 작업할 내용을 파일로 작성
### 개요
  - Ansible을 이용해서 웹서를 설치 하기 위해 몇 단계를 거쳤나?
    - 기본 페이지 다운로드/업로드, 패키지 설치, 데몬 실행, 방화벽, 사이트 출력

  - 'Ansible'은 여러 단계가 필요한 작업을 위해서 '플레이북(Playbook)'이라는 기능을 제공있다.
         
         
  - '플레이북(Playbook)'의 사전적인 의미는 '각본, 작전, 계획'이라는 뜻으로 그중에서 '각본'이 가장 'Ansible'의 '플레이북(Playbook)'에 적합한 의미로 생각된다.


  - 그 이유는, '플레이북(Playbook)'은 **미리 정의된 작업을 수행하는 절차적인 의미**가 들어 있기 때문이다.

### playbook은 **야믈(Yaml)** 이라는 언어로 구성되어 있다.

### Yaml 멱등성 비슷 VPN

#### 가장 중요한 **멱등성(idempotence)** 이라는 특성을 가지고 있다.

