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
        
        // 완료 상태 토글
        toggleComplete
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                var updatedList = self.todoList.value // 현재 저장된 Todo 리스트의 상태 가져오기
                guard updatedList.indices.contains(index) else { return } // 전달된 index가 Todo 리스트 범위에 있는지 확인
                
                // 완료 상태 토글
                updatedList[index].isCompleted.toggle() // Bool 값을 반전시키는 메서드
                self.todoList.accept(updatedList) // 새로 생성한 리스트를 accept로 할당
            })
            .disposed(by: disposeBag)
    }
}
