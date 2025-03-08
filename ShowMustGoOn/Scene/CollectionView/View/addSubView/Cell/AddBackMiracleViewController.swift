//
//  AddBackMiracleViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/4/25.
//

import UIKit

import SnapKit

class AddBackMiracleViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    var inputTitleLabel = CustomLabel(title: "기적명", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    var textField: UITextField = {
        let textField = UITextField()
        // PlaceholderColor 변경
        textField.attributedPlaceholder = NSAttributedString(string: "미라클 타이틀을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.text.subDarkGray])
        textField.font = .toPretendard(size: Constants.size.size15, weight: .Regular)
        textField.backgroundColor = .systemBackground
        textField.textColor = .text.black
        textField.clearButtonMode = .whileEditing
        
        // 보더 스타일 제거 (roundedRect 대신 보더 굵기, 컬러, 굴곡, 여백 직접 설정)
//        textField.borderStyle = .roundedRect
        textField.borderStyle = .none
        
        // 커스텀 보더 추가
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = Constants.radius.px8

        // 왼쪽 여백 추가
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always // 항상 여백 적용
        return textField
    }()
    
    var selectedStartTitleLabel = CustomLabel(title: "시작일", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    // 날짜 선택 유아이 고민...
    var selectedStartDateTextField: UITextField = {
        let selectedStartDateTextField = UITextField()
        selectedStartDateTextField.attributedPlaceholder = NSAttributedString(string: "시작할 날짜를 선택하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.text.subDarkGray])
        selectedStartDateTextField.font = .toPretendard(size: Constants.size.size15, weight: .Regular)
        selectedStartDateTextField.backgroundColor = .systemBackground
        selectedStartDateTextField.textColor = .text.black
        
        //
        selectedStartDateTextField.borderStyle = .none
        selectedStartDateTextField.layer.borderWidth = 1
        selectedStartDateTextField.layer.borderColor = UIColor.black.cgColor
        selectedStartDateTextField.layer.cornerRadius = Constants.radius.px8

        //
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: selectedStartDateTextField.frame.height))
        selectedStartDateTextField.leftView = paddingView
        selectedStartDateTextField.leftViewMode = .always // 항상 여백 적용
        
        //
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        selectedStartDateTextField.inputView = datePicker
        
        return selectedStartDateTextField
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
extension AddBackMiracleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension AddBackMiracleViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "빽일의 기적 추가", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension AddBackMiracleViewController {
    func setUp() {
        view.addSubview(inputTitleLabel)
        view.addSubview(textField)
        view.addSubview(selectedStartTitleLabel)
        view.addSubview(selectedStartDateTextField)
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(60)
        }
        
        selectedStartTitleLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
        
        selectedStartDateTextField.snp.makeConstraints {
            $0.top.equalTo(selectedStartTitleLabel.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(60)
        }
    }
}

// MARK: - Method
private extension AddBackMiracleViewController {
    
}

// MARK: - Delegate
extension AddBackMiracleViewController {
    
}
