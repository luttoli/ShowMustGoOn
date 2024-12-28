# ShowMustGoOn
- [iOS 앱 개발 공부하고 기록합니다. 계속 합니다!](https://luttoli.notion.site/iOS-35e44c5737824333ad083aa20cda3f5d?pvs=4) 

## CustomTabBar
- [UITabBarController](https://luttoli.notion.site/UITabBarController-6157ff0460724ba9ab1458d0cf845553?pvs=4) 

## SplashViewController
### 앱 실행 시 런치스크린에서 메인뷰로 로드되기 전 보여주기
- [SwiftyGif 사용하기](https://luttoli.notion.site/SwiftyGif-1230f60899b9809d963aee78a98b7218?pvs=4) 
- [gif 파일로 Custom SplashVC 만들기](https://luttoli.notion.site/gif-Custom-SplashVC-1230f60899b980369912d551bba46645?pvs=4) 

## UISegmentedControl
- [기본 & 커스텀 사용 방법](https://luttoli.notion.site/UISegmentedControl-1260f60899b98056afc2e35c8172eef3?pvs=4)
- [CustomSegment](https://luttoli.notion.site/CustomSegment-1590f60899b980ec83bfeeddff8c6872?pvs=4)

## UITableView
- [UITableView, Cell 기본 사용 방법](https://luttoli.notion.site/UITableView-Cell-51f407dc74c1490babe37eecd411a12d?pvs=4)
    - [CustomLabel](https://luttoli.notion.site/CustomLabel-1590f60899b98070a9bdc54119761db1?pvs=4)
- [UITableView, Todo 추가, 완료 표시](https://luttoli.notion.site/UITableView-Todo-1680f60899b9801fb796c36edb287c59?pvs=4)
    - [UITextField](https://luttoli.notion.site/UITextField-61d8a4b9c16a45869c95290bfbfeb67e?pvs=4)
    - [키보드 동작](https://luttoli.notion.site/d6da7564f2824b2ba3f29f79f1888238?pvs=4)
    - [IQKeyboardManagerSwift](https://luttoli.notion.site/IQKeyboardManagerSwift-1640f60899b980cd8a99ed22aab0b3cf?pvs=4)
- [UITableView Section 설정](https://luttoli.notion.site/UITableView-Section-1680f60899b9809f921eeb7b3af51d47?pvs=4)
- [UITableViewCell 안에 CollectionView](https://luttoli.notion.site/UITableViewCell-UICollectionView-1680f60899b980518244d0b70e3a6da6?pvs=4)
    - [UIPageControl](https://luttoli.notion.site/UIPageControl-1380f60899b98017a042e99d09487abc?pvs=4)
    - [CollectionView 자동스크롤](https://luttoli.notion.site/CollectionView-1380f60899b980aca1f4d187c1ca060d?pvs=4)
    - [WebView](https://luttoli.notion.site/WebKit-WebView-dbb909fa1dc34ba4a407193a37b4fdf9?pvs=4)
- [UITableView Header, cell 추가 액션](https://luttoli.notion.site/UITableView-Header-cell-1680f60899b980f9a84bcb6b0d63ba2a?pvs=4)
    - [UISearchBar](https://luttoli.notion.site/UISearchBar-1590f60899b980e1bad3f288d272b945?pvs=4)
    - [CustomButton](https://luttoli.notion.site/CustomButton-1590f60899b980fbb534cd53f043f494?pvs=4)

|순서|UIKit|RxSwift|Component
|:--|:--|:--|:--|
|1.|[UITableView, Cell 기본 사용 방법](https://luttoli.notion.site/UITableView-Cell-51f407dc74c1490babe37eecd411a12d?pvs=4)|[Rx 활용 UITableView](https://luttoli.notion.site/Rx-UITableView-16a0f60899b98047bb4de16e68278a33?pvs=4)|- [CustomLabel](https://luttoli.notion.site/CustomLabel-1590f60899b98070a9bdc54119761db1?pvs=4)|
|2.|[UITableView, Todo 추가, 완료 표시](https://luttoli.notion.site/UITableView-Todo-1680f60899b9801fb796c36edb287c59?pvs=4)||    - [UITextField](https://luttoli.notion.site/UITextField-61d8a4b9c16a45869c95290bfbfeb67e?pvs=4)
    - [키보드 동작](https://luttoli.notion.site/d6da7564f2824b2ba3f29f79f1888238?pvs=4)
    - [IQKeyboardManagerSwift](https://luttoli.notion.site/IQKeyboardManagerSwift-1640f60899b980cd8a99ed22aab0b3cf?pvs=4)|


## RxSwift
|순서|목록|미리보기|
|:-:|:--|:--|
|1.|[RxSwift](https://luttoli.notion.site/RxSwift-15f0f60899b980e0a161cb9a8a01ac30?pvs=4)|`Observable`, `Observer`|
|2.|[Observable 생성](https://luttoli.notion.site/Observable-Observer-15f0f60899b980e7a73cd7d639a22b8f?pvs=4)|`just`, `of`, `from`, `create`, `range`, `empty`, `never`, `interval`, `timer`, `deferred`, `repeat`|
|3.|[변환 연산자](https://luttoli.notion.site/15f0f60899b98034a5a9e4bcc34f6dae?pvs=4)|`toArray`, `map`, `faltMap`, `flatMapLatest`, `scan`, `reduce`|
|4.|[Subject](https://luttoli.notion.site/Subject-15f0f60899b98062ab1dc7fad4a025f6?pvs=4)|`PublishSubject`, `BehaviorSubject`, `ReplaySubject`, `AsyncSubject`, `BehaviorRelay`, `ReplayRealy`|
|5.|[필터링 연산자](https://luttoli.notion.site/15f0f60899b9802ebdb8edea9e61072a?pvs=4)|`filter`, `distinctUntilChanged`, `take`, `skip`, `debounce`|
|6.|[결합 연산자](https://luttoli.notion.site/15f0f60899b980b3a2b8e3bd699785a2?pvs=4)|`merge`, `zip`, `combineLatest`, `withLatestFrom`, `concat`|
|7.|[스케줄러](https://luttoli.notion.site/15f0f60899b980ad8d3fde89604b1f15?pvs=4)|`MainScheduler`, `ConcurrentDispatchQueueScheduler`, `SerialDispatchQueueScheduler`, `OperationQueueScheduler`, `subscribe(on: )`, `observe(on: )`|
|8.|[UI와 RxSwift의 연동(RxCocoa)](https://luttoli.notion.site/UI-RxSwift-RxCocoa-15f0f60899b980ca81d9d4c5cad3e495?pvs=4)|`RxCocoa`, .`rx`, .`bind`, `.rx.items`, `Subject`, `BehaviorSubject`|
|9.|[에러 처리 및 디버깅](https://luttoli.notion.site/15f0f60899b98041841ec77c0a373683?pvs=4)|`error처리`, `eatch`, `retry`, `debug`, `Resources.total`|
|10.|[MVVM 패턴에서 RxSwift 적용](https://luttoli.notion.site/MVVM-RxSwift-15f0f60899b9806495edccaf7445278f?pvs=4)|`MVVM`, `Todo`|
|11.|[RxSwift를 활용한 비동기 네트워크 처리](https://luttoli.notion.site/RxSwift-15f0f60899b980cba777dfe41c626e45?pvs=4)|`요청 관리`, `네트워크 요청 처리`, `JSON 파싱하기`|

## RxSwift 활용 TableView

