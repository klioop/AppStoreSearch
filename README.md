구현목록
✅ 검색어 입력전 최근 검색어 목록
✅ 검색어 입력 중 최근 검색어 일치 항목 리스트 표시
✅ 검색어 입력 후 결과화면
✅ 앱아이콘
✅ 타이틀
✅ 별점
✅ 스크린샷
✅ 상세화면
✅ 앱아이콘
✅ 타이틀
✅ 스크린샷
✅ ‘더보기’ 기능을 포함한 새로운 기능 설명
✅ 테스트 코드 - 스냅샷 테스트, 유닛/고립 테스트, 통합테스트

**프로젝트 실행 및 Scheme 설명**

프로젝트 실행
프로젝트를 실행하기 위해서는
AppStoreSearchApp/AppStoreSearchApp.xcworkspace 를 실행하고
AppStoreSearchApp Scheme 에서 빌드 하시면 됩니다.

Scheme
AppStoreSearchApp - App scheme 입니다.
앱과 UI 통합테스트 코드를 실행할 수 있습니다.
AppStoreSearch - Feature Module scheme 입니다. API, Presentation 컴포넌트들
이 같이 모여있습니다. 폴더 구조로 네트워크, 데이터베이스, Presentation 을 분리해 놓았
습니다. Shared API 와 Shared Presentation 도 이 모듈에 있습니다.
검색어 저장 및 로드하는 유스케이스 테스트들과 presenter 들의 유닛테스트들을 실행할 수
있습니다.
AppStoreSearchiOS - iOS UI 모듈 입니다. Shared UI 도 여기에 있습니다.
스냅샷 테스트를 실행할 수 있습니다.
아이폰11(16.4) 시뮬레이터로 테스트를 실행시켜주셔야 스냅샷 테스트가 통과됩니다.
AppStoreSearchAPIEndToEndTests - API 와 직접 통신하는 테스트를 위한 scheme
입니다. 다른 테스트와 달리 시간이 소요되기 때문에 scheme 을 분리했습니다.
CI - 스냅샷 테스트를 제외한 모든 테스트를 실행할 수 있는 scheme 입니다. 스냅샷 테스트
는 Xcode 버전, 테스트를 실행하는 시뮬레이터 버전에도 실패 할 수 있어서 보틀넥이 될까봐
포함시키지 않았습니다.

사용한 오픈소스 라이브러리
• SnapKit - SPM
