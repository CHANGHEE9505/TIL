# 📘 snmp

## 🖥️ 실습 환경 (NAT 구성)
## 🖥️ 실습 환경: NAT 기반 SNMP 구성

---

### 📌 네트워크 구성 (공통: C Class, Gateway 192.168.10.2)

---

### 🐧 CentOS (SNMP Agent)

- IP 주소: `192.168.10.132`
- SNMP 구성:
  - SNMP Agent 설치 및 설정
  - SNMP Manager로부터 요청을 받아 응답
- 역할: **SNMP Agent**

---

### 🪟 Windows (SNMP Manager)

- IP 주소: `192.168.10.130`
- SNMP 구성:
  - SNMP Manager 설치
  - **CUOIU Mode**를 활용해 MIB 및 OID 확인
- 역할: **SNMP Manager**

---

### 구성 요약

| 역할           | OS       | IP 주소         | SNMP 기능       | 비고                         |
|----------------|----------|------------------|------------------|------------------------------|
| SNMP Agent     | CentOS   | 192.168.10.132   | Agent 설치/응답 | SNMP 요청 수신 및 Trap 전송 |
| SNMP Manager   | Windows  | 192.168.10.130   | Manager 설정     | MIB/OID 확인 (CUOIU 사용)   |

---

📎 **구성 방식**: NAT 기반, 동일 네트워크 세그먼트에서 양방향 통신 확인


```
yum -y install epel-release
```
```
[root@localhost ~]# rpm -qa | grep snmp
net-snmp-utils-5.7.2-49.el7_9.4.x86_64
net-snmp-devel-5.7.2-49.el7_9.4.x86_64
net-snmp-libs-5.7.2-49.el7_9.4.x86_64
net-snmp-agent-libs-5.7.2-49.el7_9.4.x86_64
net-snmp-sysvinit-5.7.2-49.el7_9.4.x86_64
net-snmp-gui-5.7.2-49.el7_9.4.x86_64
net-snmp-perl-5.7.2-49.el7_9.4.x86_64
net-snmp-5.7.2-49.el7_9.4.x86_64
net-snmp-python-5.7.2-49.el7_9.4.x86_64
```
### 설치 가능한 패키지 목록 인터넷 상에서 확인

```
 yum list | grep snmp | nl
```

```
yum -y install net-snmp-*
```
![](./img/snmp/1.png)
1, 8 대표 패키지