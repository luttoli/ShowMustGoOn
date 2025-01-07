//
//  TodoViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/19/24.
//

import UIKit

class TodoViewModel {
    // 데이터
    var todoData: [TodoModel] = [
        TodoModel(title: "기본 값", isCompleted: true)
    ]
    
    // 업데이트 체크
    var onTodoUpdated: (() -> Void)?
    
    // todo 추가
    func addTodo(title: String, isCompleted: Bool) {
        guard !title.isEmpty else { return }
        let newTodo = TodoModel(title: title, isCompleted: isCompleted)
        todoData.append(newTodo)
        onTodoUpdated?()
    }
    
    // 완료 상태
    func toggleCompleted(at index: Int) {
        guard todoData.indices.contains(index) else { return }
        todoData[index].isCompleted.toggle()
        onTodoUpdated?()
    }
}
