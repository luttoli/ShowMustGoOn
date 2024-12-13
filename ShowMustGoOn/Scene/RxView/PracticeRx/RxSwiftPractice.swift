//
//  RxSwiftPractice.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/7/24.
//

import UIKit

import RxSwift

let disposeBag = DisposeBag()

class RxSwifts {
    func observable() {
        Observable.of("안녕", "RxSwift", "공부")
            .subscribe(onNext: { value in
                print("받은 값: \(value)")
            })
            .disposed(by: disposeBag)
    }
    
    func create() {
        let observable = Observable<String>.create { observer in
            observer.onNext("안녕하세요")
            observer.onNext("RxSwift 입니다")
            observer.onCompleted()
            return Disposables.create()
        }

        observable.subscribe(
            onNext: { value in
                print("create: \(value) ")
            },
            onCompleted: {
                print("완료됨")
            }
        ).disposed(by: disposeBag)
    }
    
    func map() {
        let observable = Observable.of(1, 2, 3, 4, 5)
        
        observable
            .map { $0 * 5 }
            .subscribe(onNext: { value in
                print("\(value)")
            })
            .disposed(by: disposeBag)
    }
    
    func filter() {
        let observable = Observable.of(1, 2, 3, 4, 5)
        
        observable
            .filter { $0 % 2 == 0 }
            .subscribe(onNext: { value in
                print("\(value)")
            })
            .disposed(by: disposeBag)
    }
    
    func reduce() {
        let observable = Observable.of(1, 2, 3, 4, 5)
        
        observable
            .reduce(1) { a, b in
                return a * b
            }
            .subscribe(onNext: { result in
                print("reduce 결과: \(result)")
            })
            .disposed(by: disposeBag)
    }
    
    func publishSubject() {
        let publishSubject = PublishSubject<String>()

        // 첫 번째 구독자
        publishSubject
            .subscribe(onNext: { value in
                print("첫 번째 구독자: \(value)")
            })
            .disposed(by: disposeBag)

        // 첫 번째 구독자가 구독된 후 이벤트 발생
        publishSubject.onNext("RxSwift")

        // 두 번째 구독자 추가
        publishSubject
            .subscribe(onNext: { value in
                print("두 번째 구독자: \(value)")
            })
            .disposed(by: disposeBag)

        // 이후 이벤트 발생
        publishSubject.onNext("새로운 이벤트")
    }
    
    func behaviorSubject() {
        let behaviorSubject = BehaviorSubject(value: "초기값")

        // 첫 번째 구독자
        behaviorSubject
            .subscribe(onNext: { value in
                print("첫 번째 구독자: \(value)")
            })
            .disposed(by: disposeBag)

        // 첫 번째 구독자에게 새로운 값 방출
        behaviorSubject.onNext("첫 번째 값")

        // 두 번째 구독자 추가
        behaviorSubject
            .subscribe(onNext: { value in
                print("두 번째 구독자: \(value)")
            })
            .disposed(by: disposeBag)

        // 이후 새로운 값 방출
        behaviorSubject.onNext("두 번째 값")
    }
    
    func mapscan() {
        let observable = Observable.of(1, 2, 3, 4, 5)
        
        observable
            .scan(0) { acc, value in acc + value }
            .map { "누적 결과: \($0)" }
            .subscribe(onNext: { result in
                print(result) // 출력: 누적 결과: 1, 누적 결과: 3, ...
            })
            .disposed(by: disposeBag)
    }
    
    func zip() {
        let observable3 = Observable.of(1, 2, 3)
        let observable4 = Observable.of("A", "B", "C")

        Observable.zip(observable3, observable4)
            .subscribe (onNext: { a, b in
                print("\(a)\(b)")
            })
            .disposed(by: disposeBag)
    }
    
    func mainThread() {
        let observable = Observable.of(1, 2, 3, 4, 5)

        // subscribeOn으로 백그라운드 스레드에서 데이터 생성
        // observeOn으로 메인 스레드에서 데이터를 처리
        observable
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)) // 생성 시점: 백그라운드
            .observe(on: MainScheduler.instance) // 소비 시점: 메인 스레드
            .subscribe(onNext: { value in
                print("현재 쓰레드: \(Thread.isMainThread ? "메인 스레드" : "백그라운드 스레드") - 값: \(value)")
            })
            .disposed(by: disposeBag)
    }

    func apiError() {
        let disposeBag = DisposeBag()

        enum APIError: Error {
            case networkError
        }

        func fetchDataFromAPI() -> Observable<[String]> {
            return Observable<[String]>.create { observer in
                print("API 호출 시작")
                observer.onNext(["API 데이터 1", "API 데이터 2"])
                observer.onError(APIError.networkError) // 에러 발생
                return Disposables.create {
                    print("Observable disposed")
                }
            }
        }

        let defaultData = ["기본 데이터 A", "기본 데이터 B"]

        fetchDataFromAPI()
            .debug("API Observable") // 이벤트 흐름 디버깅
            .catch { error in
                print("에러 발생, 기본 데이터를 반환합니다: \(error)")
                return Observable.just(defaultData) // 에러 발생 시 기본 데이터로 복구
            }
            .subscribe(
                onNext: { data in
                    print("받은 데이터:", data)
                },
                onError: { error in
                    print("Error:", error)
                },
                onCompleted: {
                    print("Completed")
                }
            )
            .disposed(by: disposeBag)
    }
}
