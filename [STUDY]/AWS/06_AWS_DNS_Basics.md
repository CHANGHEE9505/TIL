# 06. AWS 기초 지식: DNS (Domain Name System)

이 문서는 사람이 읽을 수 있는 도메인 이름을 기계가 읽을 수 있는 IP 주소로 변환하는 **DNS(도메인 이름 시스템)**의 기본 개념과 동작 원리를 설명합니다.

## DNS란?

-   **정의**: 사람이 읽을 수 있는 문자열(도메인 이름)과 인터넷 프로토콜(IP) 기반의 숫자 정보(IP 주소)를 서로 매칭시켜주는 시스템입니다. 예를 들어, `www.amazon.com`이라는 도메인 이름을 `192.0.2.44`와 같은 IP 주소로 변환합니다.
-   **관리**: **ICANN(Internet Corporation for Assigned Names and Numbers)** 에서 전 세계의 도메인을 관리합니다.

## DNS 주요 개념

-   **도메인(Domain)**: IP 주소와 매핑되는, 사람이 쉽게 인식할 수 있는 문자열입니다.
    -   **서브도메인(Subdomain)**: 도메인 앞에 추가 문자열이 붙은 형태 (예: `text.example.com`).
    -   **APEX 도메인(Root Domain)**: 추가 문자열 없이 순수한 최상위 도메인 (예: `example.com`).
-   **DNS 레코드(DNS Record)**: 도메인이 어떤 데이터와 매칭되는지 정의하는 기록입니다.
    -   **레코드 종류**: `A` (IPv4 주소), `MX` (메일서버), `CNAME` 등 다양한 종류가 있습니다.
-   **네임서버(Name Server, NS)**: 도메인의 레코드 정보를 저장하고, DNS 쿼리(질의)에 응답하는 서버입니다.
    -   **Authoritative NS**: DNS 정보의 원본을 가진 가장 최상위 네임서버.
    -   **Non-Authoritative NS**: Authoritative NS에 조회하여 얻은 정보를 캐시(보관)하고 응답하는 서버.
-   **DNS Resolver**: 사용자와 네임서버 사이에 위치한 서버로, 보통 ISP(인터넷 서비스 제공자)가 관리합니다. 사용자의 요청에 따라 IP 주소 등의 정보를 대신 찾아서 확보해줍니다.

## DNS의 계층 구조와 동작 원리

DNS는 전 세계적으로 매우 큰 규모(수억 개의 도메인)를 이루고 있으며, 이를 효율적으로 관리하기 위해 계층 구조로 구성되어 있습니다.

### DNS 계층 구조

1.  **DNS Root (`.`)**: DNS 계층 구조의 최상위 레벨. 전 세계에 13개의 주체(A~M)가 관리하는 루트 서버가 있으며, DNS 쿼리 수행 시 최초로 조회하는 거점입니다.
2.  **Top-Level Domain (TLD)**: `.com`, `.org`, `.net`, `.kr` 등 두 번째 레벨의 도메인입니다. 각 TLD는 **TLDs Registry**(예: `.com`은 Verisign, `.kr`은 KISA)에서 관리하며, 하위 도메인의 네임서버 주소 정보를 가지고 있습니다.
3.  **Domain (`awsclassroom`)**: 사용자가 등록하는 실제 도메인입니다.
4.  **Subdomain (`lecture`)**: 도메인에 속한 하위 도메인입니다.

### DNS 동작 과정 (예: `lecture.awsclassroom.kr` 조회)

1.  **Client → DNS Resolver**: 사용자의 클라이언트(브라우저)가 가장 먼저 ISP의 DNS Resolver에게 `lecture.awsclassroom.kr`의 IP 주소를 물어봅니다.
2.  **Resolver → Root Server**: Resolver는 `Root Hints File`에 하드코딩된 주소를 통해 **DNS Root 서버**에 질의합니다.
3.  **Root Server → TLD Server**: Root 서버는 `.kr` 도메인을 관리하는 **TLD 네임서버**의 주소를 알려줍니다.
4.  **Resolver → TLD Server**: Resolver는 TLD 네임서버에 `awsclassroom.kr`의 네임서버 주소를 물어봅니다.
5.  **TLD Server → Authoritative NS**: TLD 네임서버는 `awsclassroom.kr`의 정보를 가진 **Authoritative 네임서버**(예: AWS Route 53)의 주소를 알려줍니다.
6.  **Resolver → Authoritative NS**: Resolver는 드디어 최종 목적지인 Authoritative 네임서버에 `lecture.awsclassroom.kr`의 IP 주소를 물어봅니다.
7.  **Authoritative NS → Resolver → Client**: 네임서버는 Zone File에서 해당 레코드를 찾아 최종 IP 주소(`203.0.113.14`)를 반환하고, Resolver는 이 정보를 클라이언트에게 전달합니다.

## 도메인 등록

-   **Domain Registrar (도메인 등록 대행)**: `가비아`, `GoDaddy`, `AWS Route 53` 등 ICANN의 인증을 받아 도메인 등록 권한을 가진 주체입니다.
-   **등록 과정**: Registrar를 통해 도메인을 등록할 때, 해당 도메인의 TLDs Registry에 내가 원하는 네임서버의 주소를 등록합니다. 이 네임서버는 직접 구축하거나 **DNS Hosting Service**(대부분의 Registrar가 함께 제공)를 통해 대여할 수 있습니다.

이 문서는 AWS Route 53과 같은 DNS 호스팅 서비스를 이해하고, 웹 서비스의 근간이 되는 도메인 시스템의 동작 원리를 파악하는 데 필수적인 지식을 제공합니다.