//
//  RxTodoListViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/14/24.
//

import UIKit

import RxCocoa
import RxSwift

class RxTodoListViewModel {
    // Input
    let addTodo = PublishSubject<String>() // 새 할 일 추가
    let toggleComplete = PublishSubject<Int>() // 특정 Todo의 완료 상태 토글
    
    // Output
    lazy var todoItems: Observable<[RxTodoModel]> = {
        todoList.asObservable()
    }()
    
    private let disposeBag = DisposeBag()
    private let todoList = BehaviorRelay<[RxTodoModel]>(value: [])
    
    init() {
        // 새 Todo 추가
        addTodo
            .map { RxTodoModel(title: $0) } // 새로운 TodoItem 생성
            .subscribe(onNext: { [weak self] newTodo in
                guard let self = self else { return }
                let updatedList = self.todoList.value + [newTodo]
                self.todoList.accept(updatedList)
            })
            .disposed(by: disposeBag)
        
        // 완료 상태 토글 - 코드 개선
        toggleComplete
            .withUnretained(self) // [welf self] 대체
            .filter { $0.todoList.value.indices.contains($1) } // 범위 체크
            .subscribe(onNext: { owner, index in // owner는 withUnretained(self)를 통해 전달된 ViewModel 인스턴스(self)를 나타냄
                var updatedList = owner.todoList.value
                updatedList[index].isCompleted.toggle()
                owner.todoList.accept(updatedList)
            })
            .disposed(by: disposeBag)
    }
}
