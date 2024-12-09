//
//  RxButtonViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/8/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxButtonViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
    lazy var rxTextFieldPage: UIBarButtonItem = {
        let rxTextFieldPage = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(goRxTextFieldPage))
        return rxTextFieldPage
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("클릭하세요!", for: .normal)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "초기 상태"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button, label])
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

extension RxButtonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        didTabButton()
    }
}

// MARK: - Navigation
extension RxButtonViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        navigationItem.rightBarButtonItem = rxTextFieldPage
        navigationController?.navigationBar.tintColor = .button.lavender
    }
}

// MARK: - SetUp
private extension RxButtonViewController {
    func setUp() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
private extension RxButtonViewController {
    @objc func goRxTextFieldPage() {
        let rxTextFieldVC = RxTextFieldViewController()
        rxTextFieldVC.hidesBottomBarWhenPushed = true // VC tabbar 숨기기
        navigationController?.pushViewController(rxTextFieldVC, animated: true)
    }
    
    // 버튼 클릭 이벤트를 Rx로 처리
    func didTabButton() {
        button.rx.tap
            .map { "버튼이 클릭되었습니다!" }
            .observe(on: MainScheduler.instance) // UI 업데이트를 메인 스레드에서 수행
            .subscribe(onNext: { [weak self] text in
                self?.label.text = text
                print("UI 업데이트: \(text)")
            })
            .disposed(by: disposeBag)
    }
}
