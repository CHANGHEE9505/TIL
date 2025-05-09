## 6. 실습 3. CA 인증서

시스템 구성
- SRV100 (인증기관, 인증서 발급)
- Client100 (인증서 요청)
- SRV100
    - 인증기관 설치
---

### ✅ 실습 개요

- **목표**: SRV100에 인증기관(CA, Certificate Authority)을 설치하여 IPSec 구성 시 **공식 인증 방식 사용**
- **시스템 구성**:  
  - `SRV100` : 인증기관 역할 수행 (CA 서버로 동작)

---

### 🏗️ CA 인증기관 설치 과정 (SRV100)

#### 1. `서버 관리자` 실행

> 시작 메뉴 → **[서버 관리자]** 실행

---

#### 2. [역할 및 기능 추가] 클릭

- 시작 화면에서 **[역할 및 기능 추가]** 선택
- 이후 **"다음"** 3번 클릭하여 진행

![46](./img/IPSec.img/46.png)<br>

---

#### 3. 인증기관 역할 선택

- **"인증 기관"**, **"인증 기관 웹 등록"** 체크
- 기능 추가 메시지에서 → **[기능 추가] 클릭**

📸 예시:

![47](./img/IPSec.img/47.png)<br>

---

#### 4. 다음 → 설치 진행

- 요약 화면 확인 후 → **[설치] 클릭**
![](./img/IPSec.img/48.png)<br>

- 설치가 완료되면 재부팅 없이 바로 구성 가능

![](./img/IPSec.img/49.png)<br>
![](./img/IPSec.img/50.png)<br>
![](./img/IPSec.img/51.png)<br>
![](./img/IPSec.img/52.png)<br>
![](./img/IPSec.img/53.png)<br>
![](./img/IPSec.img/54.png)<br>
![](./img/IPSec.img/55.png)<br>

## 인증서 환경설정
- 윈도우 알
- mmc(Microsoft Management Console)

![](./img/IPSec.img/56.png)<br>
내 사용자 계정 -> 컴퓨터 계정 순으로
![](./img/IPSec.img/58.png)<br>
![](./img/IPSec.img/57.png)<br>
![](./img/IPSec.img/59.png)<br>

시작 들어가서 Internet Explorer 들어가기
![](./img/IPSec.img/60.png)<br>

### 인증서 신청 <br>

- Internet Explorer 설정
확인
![](./img/IPSec.img/61.png)<br>
- 인증서버 접속
```
http://localhost/certsrv/
```
![](./img/IPSec.img/63.png)<br>

![](./img/IPSec.img/64.png)<br>

![](./img/IPSec.img/65.png)<br>

![](./img/IPSec.img/66.png)<br>

![](./img/IPSec.img/67.png)<br>

![](./img/IPSec.img/68.png)<br>

![](./img/IPSec.img/69.png)<br>

![](./img/IPSec.img/70.png)<br>

![](./img/IPSec.img/71.png)<br>
마지막에 제출 버튼이 활성화 된 이유는 전전전전 사진에서 스크립팅하기 안전하지 ~ **사용**으로 선택 했기 때문이다.
![](./img/IPSec.img/72.png)<br>

![](./img/IPSec.img/73.png)<br>
모든작업 -> 발급 발급 받기
![](./img/IPSec.img/74.png)<br>


- Step 2. 보류 중인 인증서 요청 상태 확인

![](./img/IPSec.img/75.png)<br>

![](./img/IPSec.img/76.png)<br>

- (X) CA 인증서, 인증서 체인 또는 CRL 다운로드

- 인증서 구성 
![](./img/IPSec.img/77.png)<br>

![](./img/IPSec.img/78.png)<br>

![](./img/IPSec.img/79.png)<br>

![](./img/IPSec.img/80.png)<br>

![](./img/IPSec.img/81.png)<br>

![](./img/IPSec.img/82.png)<br>

![](./img/IPSec.img/83.png)<br>

![](./img/IPSec.img/84.png)<br>

![](./img/IPSec.img/85.png)<br>

### Client 100
![](./img/IPSec.img/62.png)<br>
- MMC를 이용한 인증서 작업 환경 구성

![](./img/IPSec.img/86.png)<br>

- Step 1. CA 인증서, 인증서 체인 또는 CRL 다운로드

![](./img/IPSec.img/87.png)<br>

![](./img/IPSec.img/88.png)<br>

![](./img/IPSec.img/89.png)<br>

![](./img/IPSec.img/90.png)<br>

![](./img/IPSec.img/91.png)<br>

![](./img/IPSec.img/92.png)<br>

![](./img/IPSec.img/93.png)<br>

- Step 2. 인증서 요청

![](./img/IPSec.img/94.png)<br>

![](./img/IPSec.img/95.png)<br>
SRV100으로 이동<br>
![](./img/IPSec.img/96.png)<br>
모든작업 발급<br>
![](./img/IPSec.img/97.png)<br>

- Step 3. 보류 중인 인증서 요청 상태 확인

![](./img/IPSec.img/98.png)<br>

![](./img/IPSec.img/99.png)<br>

![](./img/IPSec.img/100.png)<br>

---

![](./img/IPSec.img/101.png)<br>

![](./img/IPSec.img/102.png)<br>

![](./img/IPSec.img/103.png)<br>

![](./img/IPSec.img/104.png)<br>

### 테스트 1.
- 'ICMP' 가 출력된다.

![](./img/IPSec.img/105.png)<br>

![](./img/IPSec.img/106.png)<br>

- 방화벽 구성
window로고 + R
secpol.msc 치고
SRV100, Client100 모두 구성
![](./img/IPSec.img/107.png)<br>

### 테스트 2.
- 'ESP'가 출력된다.
![](./img/IPSec.img/108.png)<br>

![](./img/IPSec.img/109.png)<br>
