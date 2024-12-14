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
    // Input: 새 할 일을 추가하는 이벤트
    let addTodo = PublishSubject<String>()
    
    // Output: 현재 Todo 리스트를 Observable로 제공
    var todoItems: Observable<[RxTodoModel]>
    
    private let disposeBag = DisposeBag()
    private let todoList = BehaviorRelay<[RxTodoModel]>(value: [])
    
    init() {
        todoItems = todoList.asObservable()
        
        addTodo
            .map { RxTodoModel(title: $0) } // 새 TodoItem 생성
            .subscribe(onNext: { [weak self] newTodo in
                guard let self = self else { return }
                let updatedList = self.todoList.value + [newTodo]
                self.todoList.accept(updatedList)
            })
            .disposed(by: disposeBag)
    }
}
