# 🌐 AWS VPC(Virtual Private Cloud) 개요

---

## 📌 개념 정리

- **VPC란?**  
  → 특정 AWS 계정 사용자(`terraformuser`)만을 위한 **가상의 네트워크**  
  → 쉽게 말해 **AWS 내 나만의 전용 데이터센터**

- 사용자가 직접 설정 가능  
  → IP 주소 범위 지정  
  → 서브넷 생성  
  → 라우팅 테이블 구성  
  → 인터넷 게이트웨이 연결 등

- **Public Cloud 환경**에서 사용할 수 있는 **고객 전용 사설 네트워크**

- **AWS는 VPC 사용을 필수화**  
  → 대부분의 AWS 서비스는 **VPC에 종속**되어 동작함

---

## 📈 도입 배경

### 🔙 도입 전 (EC2-Classic 네트워크)
- 여러 사용자 인스턴스가 **뒤엉켜 복잡**  
- 보안 및 독립성 부족  
- 네트워크 경계 불명확  

![](./IMG/VPC.img/1.png)


### 🔜 도입 후 (Amazon VPC)
- 인스턴스가 VPC에 **논리적으로 독립**  
- 사용자가 VPC별로 네트워크 설정 가능  
- 보안, 관리, 확장성 ↑  

![](./IMG/VPC.img/2.png)

---

## 🧰 VPC 생성 방식

- 사용자가 직접 VPC 생성 가능  
- 또는 계정 생성 시 **Region 별로 자동 생성되는 기본 VPC(Default VPC)** 사용 가능

---

## ✅ 장점 요약

- 다른 네트워크와 **논리적으로 분리**되어 있음  
- **보안성이 높고**, **관리가 용이**  
- **개별 사용자 환경**에 최적화된 네트워크 구성 가능


# 🖼️ AWS VPC 이해를 돕는 이미지 정리

---

## 📌 1. VPC 기본 구조  
![](./IMG/VPC.img/3.png)


- VPC에는 **리전의 각 가용성 영역(AZ)** 에 하나씩 **서브넷(Subnet)** 이 존재
- 각 서브넷에는 **EC2 인스턴스**가 배치됨
- VPC와 인터넷 간 통신을 위해 **Internet Gateway (IGW)** 가 연결됨

### 🧮 Subnet Mask 설명
- **Subnet Mask**는 IP에서 `Network ID`와 `Host ID`를 구분하는 역할  
  - `Network ID`: IP 대역을 식별  
  - `Host ID`: 해당 대역 내에서 실제 호스트(PC)에 할당되는 ID  

---

## 📌 2. VPC 간 네트워크 트래픽 흐름  
![](./IMG/VPC.img/4.png)


- 리전 내 **2개의 VPC 간 네트워크 트래픽 공유 구조** 설명
- 사용자는 리소스 배치, 보안, 연결을 포함해 **가상 네트워킹 환경을 완전하게 제어 가능**

### 🛠️ 구성 절차
1. AWS 콘솔에서 VPC 생성  
2. EC2, RDS 등 리소스를 VPC에 추가  
3. VPC 간 통신 방식(계정, AZ, 리전 간) 정의  

## 📌 3. CIDR, Subnet 생성 예시  
![](./IMG/VPC.img/5.png)


- `/16` 대역으로 VPC 생성 후, **서브넷을 나누는 구조 예시**
  - 예: `172.16.0.0/16` → `172.16.0.0/24`, `172.16.1.0/24` 등 분할 가능

### 🌍 구성 개념 정리
- **Region**: AWS 데이터센터 묶음  
- **Availability Zone (AZ)** (**가용영역**): Region 내부 개별 데이터센터 
- **VPC**: Region 규모의 가상 네트워크  

> 즉, VPC는 하나의 Region 안에서 **독립적으로 존재**하는 네트워크이며,  
> 사용자가 원하는 IP 범위, 서브넷 구조로 자유롭게 설계할 수 있다.

# 🛠️ AWS VPC 생성 및 설정 가이드

---

## ✅ 1. VPC 생성 및 설정

### Step 1. VPC 서비스 실행  
→ AWS 콘솔에서 VPC 서비스 실행

### Step 2. VPC 이름과 IPv4 CIDR 블록 설정  
![](./IMG/VPC.img/6.png)  
![](./IMG/VPC.img/7.png)  
![](./IMG/VPC.img/8.png)

---

## ✅ 2. Public Subnet 및 Private Subnet 생성

![](./IMG/VPC.img/9.png)  
![](./IMG/VPC.img/10.png)

### Step 3. public-subnet 생성  
![](./IMG/VPC.img/11.png)

### Step 4. private-subnet 생성  
![](./IMG/VPC.img/12.png)  
![](./IMG/VPC.img/13.png)

---

## ✅ 3. Internet Gateway 생성 및 VPC 연결

![](./IMG/VPC.img/14.png)

### Step 5. Internet Gateway 생성  
![](./IMG/VPC.img/15.png)  
![](./IMG/VPC.img/16.png)

### Step 6. 생성한 Internet Gateway를 VPC에 연결  
![](./IMG/VPC.img/17.png)  
![](./IMG/VPC.img/18.png)

---

## ✅ 4. 라우팅 테이블 생성 및 서브넷 연결

### Step 7. 라우팅 테이블 기본 연결 상태  
- 서브넷 생성 시 라우팅 테이블을 지정하지 않으면 **기본 라우팅 테이블에 자동 연결됨**
- 각 서브넷에 맞는 **개별 라우팅 테이블을 생성**해야 함

### Step 8. 라우팅 테이블 생성  
- `public-rtb`  
- `private-rtb`  

![](./IMG/VPC.img/19.png)  
![](./IMG/VPC.img/20.png)  
![](./IMG/VPC.img/21.png)

### Step 9. 서브넷과 라우팅 테이블 연결  
- `public-subnet` → `public-rtb`  
- `private-subnet` → `private-rtb`  

![](./IMG/VPC.img/22.png)  
![](./IMG/VPC.img/23.png)  
![](./IMG/VPC.img/24.png)  
![](./IMG/VPC.img/25.png)

---

## ✅ 5. 라우팅 규칙 설정

### Step 10. public-rtb에 규칙 설정  
→ 목적지: `0.0.0.0/0`  
→ 대상: **Internet Gateway**

![](./IMG/VPC.img/26.png)  
![](./IMG/VPC.img/27.png)  
![](./IMG/VPC.img/28.png)  
![](./IMG/VPC.img/29.png)

### Step 11. private-rtb는 규칙 설정 불필요  
→ 외부 인터넷 연결이 필요하지 않음

---

## ✅ Step 12. 최종 정리

- **Public Subnet**  
  → 라우팅 테이블에 **Internet Gateway로 향하는 라우팅 규칙이 있는 서브넷**

- **Private Subnet**  
  → 해당 라우팅 규칙이 **없는 서브넷**

> 🔑 **즉, Public인지 Private인지는 '서브넷 자체'가 아니라 '라우팅 테이블의 설정'에 따라 결정됩니다.**
















