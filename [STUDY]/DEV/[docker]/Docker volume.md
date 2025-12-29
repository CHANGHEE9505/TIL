# volume 기술 이해
- Docker에서 제공하는 volume 기술은 컨테이너 애플리케이션에서 생성되고 사용되는 데이터를 유지, 보존하기 위한 메커니즘을 제공
- 컨테이너가 삭제되어도 volume은 독립적으로 운영되기 때문에 데이터를 유지

- volume 기술은 Docker HostOS와 컨테이너에서 직접 접근이 가능
- 일반적으로 컨테이너 내부의 데이터는 컨테이너의 생명 주기와 연관되어 컨테이너 종료 시 삭제되지만, 이를 지속적으로 보존하기 위한 방법으로 volume 기술을 사용한다.



## volume 방식

### Bind mount

- Bind mount 기법은 디렉터리 뿐만 아니라 파일도 mount 가능하다.
- "호스트 파일 시스템 절대경로" : "컨테이너 내부 경로" 를 직접 mount하여 사용한다.
- 사전에 연결할 파일 또는 디렉터리를 사용자가 생성하면 해당 호스트 파일시스템의 소유자 권한으로 연결이 되고, 존재하지 않는 경우 자동 생엉되지만 이 디렉터리는 루트 사용자 소유가 된다.
- 사전 정의 없이 컨테이너 실행 시 자동 생성되고, 컨테이너 제거 시 Bind mount가 자동해제 되지만 생성된 호스트 디렉터리와 데이터는 보존된다.
- Bind mount 방법은 데이터를 Host의 지정된 디렉터리에서 관리한다.

### Bind mount

"호스트 파일 시스템 절대경로" : 컨테이너 내부 경로를 직접 연결(mount)하여 사용


### docker volume

- Docker에서 권장하는 방법으로 "docker volume create 볼륨명"으로 볼륨을 생성
- Docker볼륨은 Docker 명령어(CLI)와 Docker API 통해 사용할 수 있다
- docker volume 명령은 Docker root dir(/var/lib/docker) 영역에 volume 영역을 만들어 컨테이너 내부 경로와 연결(mount), 공유한다.
