//
//  RxExViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/11/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxExViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "여기에 입력하세요."
        return textField
    }()
    
    let button = CustomButton(type: .textButton(title: "클릭하세요!", color: .lavender, size: .small))
    
    let labelText = BehaviorRelay<String>(value: "버튼 클릭하면 여기에 표시됩니다.")
    
    let label = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular)
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, button, label])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
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

// MARK: - LifeCycle
extension RxExViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUp()
        didTapButton()
    }
}

// MARK: - SetUp
private extension RxExViewController {
    func setUp() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Method
private extension RxExViewController {
    func didTapButton() {
        // 버튼 클릭 시 텍스트 필드 값에 따라 레이블 업데이트
        button.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty)
            .map { $0.isEmpty ? "값을 입력하세요." : $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .filter { $0.isEmpty } // 텍스트가 비어있는 경우만 처리
            .map { _ in self.labelText.value } // 초기값 설정
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
