# 🔐 Cisco Router 취약점 정리

## 1. Web Management Console (웹 관리 콘솔)

- ISP로부터 제공받은 **기업 전용선**의 경우, 초기 설치 이후에는 **원격으로 웹 관리** 운영
- 로그인 시 **데이터 암호화 없이 Base64 Encoding** 방식 사용

---

### 🔍 Base64 Encoding이란?

- **Binary-to-Text 인코딩 방식**의 하나
- 바이너리 데이터를 ASCII 문자로 변환하여 **텍스트화**
- 주로 실행파일, 이진 코드 등을 **문서 형식(텍스트)**으로 표현 가능하게 함
- ⚠️ **암호화가 아니며 누구나 복호화 가능 → 보안 취약점 발생 가능**
- 즉, **민감한 로그인 정보가 쉽게 노출될 수 있음**

---

## 2. CSRF (Cross-Site Request Forgery)

- **교차 사이트 요청 위조 공격**
- 사용자가 로그인된 상태에서 공격자가 만든 악성 요청을 **의도치 않게 수행하게 유도**
- 예: 설정 변경, 계정 추가/삭제 등
- 결국,
  - **접근 제어 미비**
  - **설정 위변조 가능**
  - **장비 보안 통제가 어려움**

---

📌 **요약**:  
Cisco 웹 관리 콘솔은 기본적으로 **암호화 없이 인증 정보를 노출**하고 있으며,  
**CSRF 공격에도 취약**해 설정 변경 등의 보안 위협에 노출될 수 있음.

# 📡 SNMP (Simple Network Management Protocol) 정리


## 1. 개요

- **네트워크 장비를 원격에서 모니터링하고 관리**하기 위한 프로토콜
- OSI 7계층 중 **7계층(Application Layer)**에 속함
- **UDP 161, 162 포트** 사용
  - 161: 일반 요청/응답 (Manager ↔ Agent)
  - 162: Trap 메시지 전송 (Agent → Manager)
- **Stateless 프로토콜** (→ UDP 기반)
- **Community String**을 통해 인증 수행 (→ 암호화 아님)
- 보안과는 관련 없고, **"모니터링"에 초점**

---

## 2. 구성 요소

### 🔹 Manager
- Agent에게 정보 요청, 설정 명령 전달
- 네트워크 구성 및 성능 관리, 장애 대응 등 수행

### 🔹 Agent
- 장비 내에 설치되어 **Manager의 요청에 응답**
- 이상 상황 발생 시 **Trap Message 전송**

---

## 3. Version 비교

| 버전      | 특징 |
|-----------|------|
| **SNMPv1** | - 암호화 미지원<br>- Community String 기반 인증<br>- 장비/성능 관리 지원 |
| **SNMPv2** | - 암호화 추가<br>- **상용화 실패, 사용 거의 안 됨**<br>- v1과 호환 안 됨 |
| **SNMPv2c** | - 암호화 제거<br>- Community String 사용<br>- Trap 기능 추가<br>- v1과 호환<br>✅ 현재 가장 많이 사용됨 |
| **SNMPv3** | - 인 암호화 지원<br>- Manager/Agent 개념이 객체로만 구분됨<br>- 물리적으로 분리 필요 없음 |

---

## 4. SNMP Message Type

| 메시지 유형 | 포트 | 설명 |
|-------------|------|------|
| `get-request` | 161 | 특정 객체의 값을 요청 |
| `get-next-request` | 161 | 다음 객체 또는 인덱스 값을 요청 |
| `set-request` | 161 | 객체 값 설정/수정 |
| `get-response` | 161 | Agent가 Manager에 응답 전달 |
| `trap` | 162 | Agent가 이상 발생 시 Manager에 알림 |

---

## 5. SNMP가 필요한 상황

- 장비가 자주 다운되거나 지속적인 모니터링이 필요한 경우
- 특정 장비에서 **과부하(Traffic Overload)** 의심되는 경우
- Ping은 정상이나 **특정 경로의 트래픽 문제**가 발생하는 경우
- **원격지 장비를 관리**해야 하는 경우
- **느린 네트워크** 문제의 원인을 찾고자 할 때

---

📌 **요약**  
SNMP는 **모니터링 중심의 경량 관리 프로토콜**로,  
UDP 기반으로 동작하며 보안이 약하므로 **운영환경에서는 v3 사용 권장**

---


# 📘 MIB와 OID 정리


## 1. MIB (Management Information Base, 관리 정보 기반)

- SNMP 환경에서 **Manager와 Agent 사이의 정보 교환을 정의하는 구조**
- Agent(예: Router, Switch, Hub, Server 등)에서 관리되는 **객체(Object)** 들의 **집합체**
- 객체는 SNMP를 통해 접근 가능하며, 각각의 정보 단위를 의미
- 형태 예시:
  - `SNMPv2-MIB::sysDescr.0`
  - `HOST-RESOURCES-MIB::hrSystemDate`

---

## 2. OID (Object Identifier, 객체 ID)

- MIB에 있는 각 객체를 **식별하기 위한 고유 숫자 체계**
- 사람이 읽기 쉬운 이름(MIB 이름)을 **컴퓨터가 인식할 수 있도록 숫자로 표현**
- **디렉터리(트리) 구조**로 되어 있음
- 형태 예시:
  - `.1.3.6.1.2.1.1.1.0`

---

## 3. 관계 정리: NMS – SNMP – MIB – OID

- **NMS (Network Management System)**: 다양한 네트워크 장비를 통합적으로 관리하는 시스템
- NMS는 다음 방식으로 장비를 관리함:
  - **SNMP 방식**: → 장비 상태를 MIB에 정의된 **객체(OID)**를 통해 수집
  - **Syslog 방식**: → 로그 기반 장비 상태 수집
- SNMP는 MIB에 정의된 OID 값을 통해 장비 정보를 수신하고 상태를 파악함

---

## 4. SNMP 수업 방향

- SNMP는 **하드웨어 + 소프트웨어** 관점에서 분석 가능
- 하지만 하드웨어 측면(예: ACL)은 네트워크 수업에서 다뤘으므로 생략
- 이번 수업에서는 **소프트웨어 관점에서 SNMP 구성과 메시지 흐름**을 중점으로 학습

---

📌 **요약**  
MIB는 장비 관리용 객체의 모음이고, OID는 그 객체의 고유 주소이며,  
NMS는 이를 활용해 SNMP로 장비 상태를 **자동 수집하고 분석**하는 시스템이다.
