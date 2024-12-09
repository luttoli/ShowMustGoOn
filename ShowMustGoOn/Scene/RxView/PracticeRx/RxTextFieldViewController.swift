//
//  RxTextFieldViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/9/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxTextFieldViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "여기에 입력하세요"
        return textField
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "입력 내용이 여기에 표시됩니다"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, label])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RxTextFieldViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        setUp()
        bindTextField()
    }
}

// MARK: - SetUp
private extension RxTextFieldViewController {
    func setUp() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Method
private extension RxTextFieldViewController {
    func bindTextField() {
        // 텍스트 필드의 텍스트를 레이블에 실시간으로 반영
        textField.rx.text
            .orEmpty // 옵셔널을 제거하고 빈 문자열로 대체
            .observe(on: MainScheduler.instance) // UI 업데이트를 메인 스레드에서 수행
            .bind(to: label.rx.text) // 레이블 텍스트에 바인딩
            .disposed(by: disposeBag)
    }
}

//private extension RxTextFieldViewController {
//    func bindTextField() {
//        // 텍스트 필드 입력 값에 따라 레이블 업데이트
//        textField.rx.text.orEmpty
//            .filter { !$0.isEmpty } // 빈 문자열이 아닌 경우만 필터링
//            .observe(on: MainScheduler.instance) // UI 업데이트는 메인 스레드에서
//            .subscribe(onNext: { [weak self] text in
//                self?.label.text = text
//            })
//            .disposed(by: disposeBag)
//    }
//}
