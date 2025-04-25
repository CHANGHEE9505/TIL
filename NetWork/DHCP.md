#  DHCP (Dynamic Host Configuration Protocol)

##  장단점

###  장점
![DHCP 장점](./img/DHCPimg/1.png)

---

###  단점
![DHCP 단점](./img/DHCPimg/2.png)

---

##  중요 포인트

![DHCP 중요 포인트 1](./img/DHCPimg/3.png)  
![DHCP 중요 포인트 2](./img/DHCPimg/4.png)

---

##  실습 1️⃣ 임대 생성

###  DHCP Server 설치

1. **서버 관리자 실행**
2. **[역할 및 기능 추가] 클릭 후 다음 3번 → DHCP 선택**
3. **[다음] → [다음] → [설치]**

![DHCP 설치](./img/DHCPimg/5.png)

---

![DHCP 설치](./img/DHCPimg/6.png)

---

![DHCP 설치](./img/DHCPimg/7.png)

---
## 📍 범위 지정

1. **DHCP 콘솔 실행 → 새 범위 만들기**
2. **IP 주소 범위, 서브넷 마스크 입력**
3. **임대 기간 설정 및 DNS 등 세부 구성**

![범위 지정 1](./img/DHCPimg/8.png)  
![범위 지정 2](./img/DHCPimg/9.png)  
![범위 지정 3](./img/DHCPimg/10.png)  
![범위 지정 4](./img/DHCPimg/11.png)  
![범위 지정 5](./img/DHCPimg/12.png)  
![범위 지정 6](./img/DHCPimg/13.png)

---
## ⚙️ 세부 설정

1. **라우터(기본 게이트웨이) 설정**
2. **DNS 및 WINS 서버 설정**
3. **DHCP 범위 활성화**

![세부 설정 1](./img/DHCPimg/14.png)  
- 
![세부 설정 2](./img/DHCPimg/15.png) 
- 이름서버, DNS 서버 추가 후 IP 추가
![세부 설정 3](./img/DHCPimg/16.png)

---

## 🔎 주소 임대 확인

- **DHCP 콘솔 → 주소 임대 목록 확인**

![주소 임대 확인](./img/DHCPimg/17.png)

## 💻 DHCP Client 실습


### 1️⃣ IP 주소를 할당받기 위한 작업

- 네트워크 어댑터 설정 변경  
  → **"사용 안 함" → 다시 "사용함"으로 변경**

![IP 설정 1](./img/DHCPimg/18.png)  
![IP 설정 2](./img/DHCPimg/19.png)

---

### 2️⃣ IP 할당 시도

- DHCP 서버로부터 IP 주소를 받아오려 했지만 오류 발생

![오류 발생](./img/DHCPimg/20.png)

---

### 3️⃣ 오류 해결 과정

#### 🚫 여전히 오류 발생

- Virtual Machine Settings에서 **네트워크 어댑터를 `Host-only`로 변경**

![Host-only 설정](./img/DHCPimg/21.png)

- 그러나 여전히 IP 할당 실패

![오류 지속 1](./img/DHCPimg/22.png)  
![오류 지속 2](./img/DHCPimg/25.png)

---

#### 🔧 설정 변경: VMware 네트워크 설정

- **VMnet1 설정 → "Use local DHCP service to distribute IP address to VMs" 체크 해제**

![DHCP 서비스 해제](./img/DHCPimg/23.png)

---

### ✅ 성공적으로 IP 할당

- DHCP 서버에서 1~50번은 제외했기 때문에, **192.168.100.51**부터 할당 시작됨

![성공 화면](./img/DHCPimg/24.png)

---

## 샥스핀을 이용한 패킷 확인
- DHCP Server에서 Client에게 부여한 IP가 올라와 있는 '주소 임대'에서 IP를 삭제한다.

- DHCP Server와 DHCP Client에서 샥스핀을 실행해 놓는다.

- DHCP Client에서 cmd를 실행한 후 'ipconfig /release'와 'ipconfig /renew'를 순서대로 입력, 실행한다.
- 임대받은 IP를 확인한 후 두 시스템에서샥스핀을 종료한다.

![성공 화면](./img/DHCPimg/26.png)

---
- '필터링(^ + /)' 확인 입력란에 'dhcp'를 입력하면 해당 프로토콜을 사용한
    내용만 출력된다.
- 4개의 패킷(Discover → Offer → Request → Ack)'이 순서대로
    Broadcasting 되고 있는 것을 확인한다.
![성공 화면](./img/DHCPimg/27.png)

---

![성공 화면](./img/DHCPimg/28.png)

---

## 예약 주소 임대
server100에서 주소임대 삭제후 Client100에서 MACAddress를 가져온다
```
ipconfig /all
```
물리적 주소를 복사한다.
![성공 화면](./img/DHCPimg/51.png)

---
SRV100으로 가서 MAC 주소와 부여하고 싶은 IP주소값을 부여한다.
![성공 화면](./img/DHCPimg/52.png)

---
예약을 확인 할 수 있다.
![성공 화면](./img/DHCPimg/53.png)

---
Client100에서 다시
```
ipconfig /release
ipconfig /renew
```
IP주소를 받아온다.
![성공 화면](./img/DHCPimg/54.png)

---
- 완료
![성공 화면](./img/DHCPimg/55.png)

---


