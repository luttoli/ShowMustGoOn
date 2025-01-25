//
//  RxTodoListViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/14/24.
//

import UIKit

import RxCocoa
import RxSwift

class RxTodoTableViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - 데이터 구조를 두개로 가져갈 때
//    let addTodo = PublishSubject<String>() // 새 할 일 추가
//    let toggleComplete = PublishSubject<Int>() // 특정 Todo의 완료 상태 토글
//    private let todoList = BehaviorRelay<[TodoModel]>(value: [TodoModel(title: "1", isCompleted: true)])
//    
//    // ViewModel에서 TodoCellData 생성, todoList를 가공하여 셀이 사용할 데이터로 변환
//    lazy var rxTodoCellData: Observable<[RxTodoCellData]> = {
//        todoList
//            .map { todos in
//                todos.map { todo in
//                    RxTodoCellData(
//                        title: todo.title,
//                        isCompleted: todo.isCompleted,
//                        textColor: todo.isCompleted ? .text.lavender : .text.black
//                    )
//                }
//            }
//    }()
//    
//    init() {
//        // 새 Todo 제목을 addTodo에 전달받으면, 이를 TodoModel로 변환하고 todoList에 추가
//        addTodo
//            .map { TodoModel(title: $0) } // 새로운 TodoItem 생성
//            .subscribe(onNext: { [weak self] newTodo in
//                guard let self = self else { return }
//                let updatedList = self.todoList.value + [newTodo]
//                self.todoList.accept(updatedList)
//            })
//            .disposed(by: disposeBag)
//        
//        // 완료 상태 토글 - 코드 개선
//        toggleComplete
//            .withUnretained(self) // [welf self] 대체
//            .filter { $0.todoList.value.indices.contains($1) } // 범위 체크
//            .subscribe(onNext: { owner, index in // owner는 withUnretained(self)를 통해 전달된 ViewModel 인스턴스(self)를 나타냄
//                var updatedList = owner.todoList.value
//                updatedList[index].isCompleted.toggle()
//                owner.todoList.accept(updatedList)
//            })
//            .disposed(by: disposeBag)
//    }
    
    // MARK: - 데이터 구조를 하나로 가져갈 때
//    let todoList = BehaviorRelay<[TodoModel]>(value: [TodoModel(title: "기본 값", isCompleted: true)])
//
//    lazy var rxTodoCellData: Observable<[RxTodoCellData]> = {
//        todoList
//            .map { todos in
//                todos.map { todo in
//                    RxTodoCellData(
//                        title: todo.title,
//                        isCompleted: todo.isCompleted,
//                        textColor: todo.isCompleted ? .text.lavender : .text.black
//                    )
//                }
//            }
//    }()
    
    // init 초기화 사용
    let todoList: BehaviorRelay<[TodoTableModel]>
    let rxTodoCellData: Observable<[RxTodoTableViewCellData]>

    // 생성자에서 초기화
    init(initialTodos: [TodoTableModel] = [TodoTableModel(title: "기본 값", isCompleted: true)]) {
        self.todoList = BehaviorRelay(value: initialTodos)

        // rxTodoCellData 초기화
        self.rxTodoCellData = todoList
            .map { todos in
                todos.map { todo in
                    RxTodoTableViewCellData(
                        title: todo.title,
                        isCompleted: todo.isCompleted,
                        textColor: todo.isCompleted ? .text.lavender : .text.black
                    )
                }
            }
    }

    // 새로운 Todo 추가
    func addTodoItem(title: String) {
        guard !title.isEmpty else { return }
        let newTodo = TodoTableModel(title: title, isCompleted: false)
        var updateList = todoList.value
        updateList.append(newTodo)
        todoList.accept(updateList)
    }

    // 완료 상태 토글
    func toggleTodoItem(at index: Int) {
        guard todoList.value.indices.contains(index) else { return }
        var updateList = todoList.value
        updateList[index].isCompleted.toggle()
        todoList.accept(updateList)
    }
}
