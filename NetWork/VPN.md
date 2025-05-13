# 📘 VPN

## 1. 개요

기업 전용선의 장점을 그대로 이용하면서도  
**비용 부담을 줄일 수 있는 네트워크 보안 서비스**입니다.

> 🔒 **VPN (Virtual Private Network)**  
> → 인터넷을 통해 지사와 본사 간의 인트라넷처럼 통신할 수 있도록 해주는 기술.

- 마치 **인트라넷**처럼 폐쇄망을 구성할 수 있습니다.
- 별도의 기업 전용선을 설치하지 않고도 안전한 통신이 가능합니다.

<br>

![VPN 개요도](./img/VPNimg/1.jpg)

---

## 2. 서비스 구성 방법

### ✅ Site-to-Site (Gateway-to-Gateway)

- 본사와 지사 간의 네트워크를 안전하게 연결하는 방식  
- 지역이 다른 사무실들을 하나의 네트워크처럼 연결

📌 **특징 요약:**
- 서로 다른 지역 간 네트워크 통합
- 내부 정보 유출 방지를 위한 폐쇄형 구성 가능
- 외부 연결 차단 및 USB 차단 등으로 보안 강화

---

![VPN 구성 예시](./img/VPNimg/2.jpg)

---

## 3. 서버 구성 시 요구사항

> VPN 서버는 외부와 내부 네트워크를 모두 연결해야 하므로,  
> 다음 조건을 반드시 만족해야 합니다.

- 🔐 **관리자 권한** 만 설정 가능해야 함
- 💻 **NIC(Network Interface Card)**가 최소 2개 필요:
  - **공용 IP**: 외부 접근 시 사용
  - **내부 IP**: 내부망 통신용
- 🌐 **DMZ 구간**에 위치 (내·외부 네트워크 모두 접근 가능한 중간 지대)

---

## 4. 실습 환경 구성

### 💻 시스템 구성

- **VPN Server** 1대  
- **VPN Client** 1대  
> 총 2대의 시스템으로 실습 진행

---

## ✅ 실습 준비: 역할 정리

| 시스템         | 역할 설명                     |
|----------------|-------------------------------|
| **VPN Server** | VPN 접속 허용 및 인증 담당 서버 |
| **VPN Client** | VPN을 통해 서버에 접속하는 사용자 장치 |

---
## VPN Server
### 라우팅 및 원격 액세스에서의 설정

![vpn1](./img/VPNimg/1.png)<br>

![vpn2](./img/VPNimg/2.png)<br>

![vpn3](./img/VPNimg/3.png)<br>

![vpn4](./img/VPNimg/4.png)<br>

![vpn5](./img/VPNimg/5.png)<br>

![vpn6](./img/VPNimg/6.png)<br>

![vpn7](./img/VPNimg/7.png)<br>

![vpn8](./img/VPNimg/8.png)<br>

#### 나머지는 기본값
![vpn8](./img/VPNimg/9.png)<br>

### vpn Service를 사용할 사용자 생성
![](./img/VPNimg/10.png)<br>

![](./img/VPNimg/11.png)<br>

생성된 VPNuser 더블 클릭
![](./img/VPNimg/12.png)<br>

## VPN Client

![](./img/VPNimg/13.png)<br>

![](./img/VPNimg/14.png)<br>

![](./img/VPNimg/15.png)<br>

![](./img/VPNimg/16.png)<br>

![](./img/VPNimg/17.png)<br>

![](./img/VPNimg/18.png)<br>

![](./img/VPNimg/19.png)<br>

![](./img/VPNimg/20.png)<br>

![](./img/VPNimg/21.png)<br>

![](./img/VPNimg/22.png)<br>

![](./img/VPNimg/23.png)<br>

![](./img/VPNimg/24.png)<br>

![](./img/VPNimg/25.png)<br>

![](./img/VPNimg/26.png)<br>

![](./img/VPNimg/27.png)<br>

## client 200
![](./img/VPNimg/28.png)<br>
똑같이 작업

![](./img/VPNimg/29.png)<br>
