//
//  TableViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/31/24.
//

import UIKit

class TableViewModel {
    var tableData: [TableModel] = {
        let numbers = Array(1...14).map { "\($0)" } // ["1", "2",...]
        let titles = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"]
        // zip 함수가 [(1, "가"), (2, "나"), ...]
        // map 함수가 각 쌍을 TableModel 타입으로 변환 [TableModel(number: "1", title: "가"), TableModel(number: "2", title: "나"), ...]
        // var tableData: [TableModel] = [
        //     TableModel(number: "1", title: "가"),
        //     TableModel(number: "2", title: "나"),
        //     ...
        // ]
        // 동일한 형태
        return zip(numbers, titles).map { TableModel(number: $0, title: $1) }
    }()
}
