# Planka-ns

## 우아한 오픈소스 프로젝트 트래킹

[**Client demo**](https://plankanban.github.io/planka) (without server features).

## Askfront.com
초보자도 자유롭게 질문할 수 있는 포럼을 만들었습니다. <br />
NavyStack의 가이드 뿐만 아니라, 아니라 모든 종류의 질문을 하실 수 있습니다.

검색해도 도움이 되지 않는 정보만 나오는 것 같고, 주화입마에 빠진 것 같은 기분이 들 때가 있습니다.<br />
그럴 때, 부담 없이 질문해 주세요. 같이 의논하며 생각해봅시다.

[AskFront.com (에스크프론트) 포럼](https://askfront.com/?github)

## 기능

- 프로젝트, 보드, 목록, 카드, 라벨, 작업 만들기
- 카드 구성원 추가, 시간 추적, 마감일 설정, 첨부파일 추가, 코멘트 작성
- 카드 설명과 댓글에 마크다운 지원
- 구성원 및 라벨별로 필터링
- 프로젝트 배경 사용자 지정
- 실시간 업데이트
- 사용자 알림
- 한국어 지원

## 제 레포의 [Traefik](https://github.com/NavyStack/traefik)을 선행하셨다면

`docker-compose-traefik.yml`에서 "수정" 이라고 표시된 도메인 수정하시고, <br>
개인의 환경에 맞게 수정하시고, <br>
`docker compose -f docker-compose-traefik.yml up -d` 하시면 번거로운 것 없이 바로 올라갑니다.

## Development

[개발 섹션](https://docs.planka.cloud/docs/Development)을 참조하세요.

## 기술 스택

- React, Redux, Redux-Saga, Redux-ORM, Semantic UI React, react-beautiful-dnd
- Sails.js, Knex.js
- PostgreSQL

## License

Planka는 [AGPL-3.0 licensed](https://github.com/plankanban/planka/blob/master/LICENSE).
<br>
관련 Dockerfile 등은 [MIT License](https://github.com/NavyStack/planka-ns/blob/main/LICENSE)
<br><br>
모든 빌드 인수 및 설정은 레포에 공개되어있습니다.

My contributions are licensed under the MIT License
<br>
SPDX-License-Identifier: MIT
<br><br>
모든 Docker 이미지와 마찬가지로, 여기에는 다른 라이선스(예: 기본 배포판의 Bash 등 및 포함된 기본 소프트웨어의 직간접적인 종속성)가 적용되는 다른 소프트웨어도 포함될 수 있습니다.<br>
사전 빌드된 이미지 사용과 관련하여, 이 이미지를 사용할 때 이미지에 포함된 모든 소프트웨어에 대한 관련 라이선스를 준수하는지 확인하는 것은 이미지 사용자의 책임입니다.<br>
기타 모든 상표는 각 소유주의 재산이며, 달리 명시된 경우를 제외하고 본문에서 언급한 모든 상표 소유자 또는 기타 업체와의 제휴관계, 홍보 또는 연관관계를 주장하지 않습니다.
