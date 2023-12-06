## 구현목록</br>

✅ 검색어 입력전 최근 검색어 목록</br>
✅ 검색어 입력 중 최근 검색어 일치 항목 리스트 표시</br>
✅ 검색어 입력 후 결과화면</br>
✅ 앱아이콘</br>
✅ 타이틀</br>
✅ 별점</br>
✅ 스크린샷</br>
✅ 상세화면</br>
✅ 앱아이콘</br>
✅ 타이틀</br>
✅ 스크린샷</br>
✅ ‘더보기’ 기능을 포함한 새로운 기능 설명</br>
✅ 테스트 코드 - 스냅샷 테스트, 유닛/고립 테스트, 통합테스트</br>

## 프로젝트 실행 및 Scheme 설명

**프로젝트 실행**</br>
프로젝트를 실행하기 위해서는 AppStoreSearchApp/AppStoreSearchApp.xcworkspace 를 실행하고 AppStoreSearchApp Scheme 에서 빌드 하시면 됩니다.</br>

**Scheme**</br>
AppStoreSearchApp - App scheme 입니다.</br>
앱과 UI 통합테스트 코드를 실행할 수 있습니다.</br>
</br>
AppStoreSearch - Feature Module scheme 입니다.</br>
API, Presentation 컴포넌트들이 같이 모여있습니다.</br>
폴더 구조로 네트워크, 데이터베이스, Presentation 을 분리해 놓았습니다.</br> 
Shared API 와 Shared Presentation 도 이 모듈에 있습니다.</br>
검색어 저장 및 로드하는 유스케이스 테스트들과 presenter 들의 유닛테스트들을 실행할 수
있습니다.</br>
</br>
AppStoreSearchiOS - iOS UI 모듈 입니다.</br>
Shared UI 도 여기에 있습니다.</br>
스냅샷 테스트를 실행할 수 있습니다.</br>
아이폰11(16.4) 시뮬레이터로 테스트를 실행시켜주셔야 스냅샷 테스트가 통과됩니다.</br>
</br>
AppStoreSearchAPIEndToEndTests</br>
API 와 직접 통신하는 테스트를 위한 scheme 입니다.</br>
다른 테스트와 달리 시간이 소요되기 때문에 scheme 을 분리했습니다.</br>
</br>
CI - 스냅샷 테스트를 제외한 모든 테스트를 실행할 수 있는 scheme 입니다.</br> 
스냅샷 테스트 는 Xcode 버전, 테스트를 실행하는 시뮬레이터 버전에도 실패 할 수 있어서 보틀넥이 될까봐 포함시키지 않았습니다.</br>

## 사용한 오픈소스 라이브러리</br>
• SnapKit - SPM</br>
</br>

## 최소지원버전</br>
• iOS 13.0</br>
</br>

## Modular 아키텍처
Modular 아키텍처를 적용했습니다.</br>
모듈은 Framework 와 Scheme 으로 구분했습니다.</br>
AppStoreSearchiOS, 와 AppStoreSearch 는 iOS Framework 이고
AppStoreSearch 프로젝트는 앱입니다.</br>
드래그 앤 드랍으로 xcworkspace 를 만드는 형태로 단순하게 구성했습니다.</br>

## Presentation Design 패턴
MVP 를 변형한 패턴을 사용했습니다</br>

![image](https://github.com/klioop/AppStoreSearch/assets/58622021/95487613-42fd-47dc-90d1-6a8575de9e7d)
