# Web Language 및 '웹에서 사용하는 Encoding Schema'

## 2. Web Language

### 개요

#### Script Language
- SSSL (Server Side Script Language)
    - ASP, PHP, JSP
    - 웹 브라우저를 통해서 소스를 확인할 수가 없다.

- CSSL (Client Side Script Language)
    - HTML, Javascript
    - 웹 브라우저를 통해서 소스를 확인할 수가 있다.

- ASCII Code
    - 7bit(128개 문자) + 1bit(Parity bit, 오류 검증 비트)

    - 인코딩(Encoding, 부호화) & 디코딩(Decoding, 복호화)



: 'CSSL'과 'SSSL'의 방식 (웹 서버의 취약점 분석 및 예방)



    ; 작업 환경


    -> 윈도우 계열 OS 2개

        : Windows 10

        : Windows Server 2022


    -> 리눅스 계열 OS 2개

        : Kali 24.1

        : CentOS 7.9.2207


    ; 필요 프로그램


    -> Web Proxy (리눅스용 Paros at 32bit)

## 🖥️ 실습 환경 (NAT 구성)

### ✅ CentOS
- CentOS with DNS, Web Server, DB Server
- IP: `192.168.10.132`
- 게이트웨이: `192.168.10.2`
- DNS: `192.168.10.132`

### ✅ Windows 10
- IP: `192.168.10.130`
- 게이트웨이: `192.168.10.2`
- DNS: `192.168.10.132`

### ✅ windows Server 2022
- IP: `192.168.10.131`
- 게이트웨이: `192.168.10.2`
- DNS: `192.168.10.132`

### ✅ Kali
- IP: `192.168.10.128`
- 게이트웨이: `192.168.10.2`
- DNS: `192.168.10.132`

## 구성 시 신경써야 할 내용

- 통신 상태 확인
    - 모든 시스템들은 서로 통신이 되어야 한다.
    - 모든 시스템들에서 네임서버 조회(ns, www, ws22)가 되어야 한다.

- 'windows Server 2022' 에서의 필수 사항
    - '외부 시스템(Windows 10)' 에서 접속할 '사용자(winsamadal)를 생성
    - ASP(Active Server Page, 오직 'windows System'에서만 동작) 사용을 위해서 IIS를 추가하고 FTP Server도 활성화

## ✅ windows Server 2022(client100)
- 서버관리자

![](./img/Web%20Language.img/0001.png)

![](./img/Web%20Language.img/0002.png)

![](./img/Web%20Language.img/0003.png)

![](./img/Web%20Language.img/0004.png)


## 🌐 IIS 설치 및 동작 상태 확인

### ✅ 1. 웹사이트 출력 확인
- **Windows 10**에서 다음 두 웹사이트가 정상적으로 출력되어야 함:
  - `http://www.gusiya.com`
  - `http://ws22.gusiya.com`

---

### ✅ 2. FTP 서버 접속 확인 (Windows 10 → Windows Server 2022(Client100))

#### ❌ 접속 오류 1: **FTP Server 접속 불가**
- **문제**: 포트 21이 방화벽에서 허용되지 않음
- **해결 방법**:
  - `Windows 방화벽(wf.msc)` 실행
  - **인바운드 규칙**에서 **TCP 21 포트 허용** 추가

  ![](./img/Web%20Language.img/0005.png)

---

#### ❌ 접속 오류 2: 접속은 되지만 '정상적인 접속'이 아님
- **문제 요약**:
  - FTP 서버에는 접속되었고, IIS에서 설정한 폴더에도 접근 가능하지만,
  - 사용자가 **실제 사용할 폴더 권한(ACL)** 설정이 누락됨

- **원인**:
  - 사용자(`Winsamadal`) 생성 후, IIS와 연동된 **접근 권한 설정 누락** - compmgmt.msc <br>

![](./img/Web%20Language.img/0012.png)


  - FTP 루트 폴더 또는 IIS 연결 폴더에 대해 권한이 없음

- **해결 방법**:
  1. **폴더 → 속성 → 보안 탭** 클릭
  2. **편집 → 추가 → 고급 → 지금 찾기**
  3. `Winsamadal` 계정 선택 후 권한 부여

  ![](./img/Web%20Language.img/0006.png)

- ✅ **결론**:
  - FTP 사용자가 접근할 폴더에 **IIS에서 설정된 경로와 일치하는 권한(ACL)** 설정이 반드시 필요


## 웹 해킹을 위한 'Webhack'
### 압축 파일 해제 후 이동
![](./img/Web%20Language.img/0007.png)

### 테스트 1.
#### IIS의 기본 경로를 'wwwroot'로 변경

![](./img/Web%20Language.img/0008.png)

![](./img/Web%20Language.img/0009.png)

- 정상출력

#### IIS의 기본 경로를 'webhack'으로 변경

![](./img/Web%20Language.img/0010.png)

![](./img/Web%20Language.img/0011.png)

- '서버 오류'가 발생하는데 이것은 정상적인 '오류'이다.
- 발생 이유는 'index.asp' 파일을 인식하지 못하기 때문이다.
- 따라서 ASP 관련 기능을 설치하지 않으면 출력되지 않는다.

### IIS의 ASP 활성화

#### Windows Server 2022(Client100)
- 역할 및 기능 추가 -> 다음 3번 -> 서버역할<br>

![](./img/Web%20Language.img/0013.png)

![](./img/Web%20Language.img/0014.png)

![](./img/Web%20Language.img/0015.png) <br>
기본값 설정
### 테스트 2. 
- 'Web Hacking Practice Site'가 출력된다.
![](./img/Web%20Language.img/0016.png) <br>

- 웹 사이트 수정에 따른 취약점 분석
    - 테스트 파일 생성(script_test.asp)
    ```
    <html>
	<head>
		<title> Test Page </title>
	</head>
	<body>
		Your Input Data = <% =Request.QueryString("param") %>
		<script>alert("Alert")</script>
	</body>
    </html>
    ```
    ![](./img/Web%20Language.img/0017.png) <br>

#### Windows 10에서 테스트
![](./img/Web%20Language.img/0018.png) <br>

![](./img/Web%20Language.img/0021.png) <br>

- 파일명만 입력한 경우

![](./img/Web%20Language.img/0019.png) <br>

![](./img/Web%20Language.img/0020.png) <br>


- 파일명 뒤에 Parameter를 입력한 경우


```
<html>
	<head>
		<title> Test Page </title>
	</head>
	<body>
		Your Input Data = <% =Request.QueryString("param") %>
		<script>alert("Alert with Samadal");</script>
	</body>
</html>
```
![](./img/Web%20Language.img/0022.png) <br>

![](./img/Web%20Language.img/0023.png) <br>

## Kali에서 테스트
### 사이트 출력
![](./img/Web%20Language.img/0024.png) <br>

![](./img/Web%20Language.img/0025.png) <br>

### Paros 설치

알집 cd Desktop/ 으로 옮기기

![](./img/Web%20Language.img/0026.png) <br>

