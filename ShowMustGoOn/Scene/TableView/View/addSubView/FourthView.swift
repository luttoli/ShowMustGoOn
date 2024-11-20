//
//  FourthView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

import SnapKit

class FourthView: UIView {
    // MARK: - Properties
    var viewModel = FourthViewModel()
    weak var parentViewController: UIViewController?
    
    // MARK: - Components
    var inputCategoryBar: UISearchBar = {
        let inputCategoryBar = UISearchBar()
        inputCategoryBar.placeholder = "카테고리 입력 후 추가"
        inputCategoryBar.searchBarStyle = .minimal
        inputCategoryBar.sizeToFit()
        inputCategoryBar.returnKeyType = .done
        return inputCategoryBar
    }()
    
    var addCategoryButton: UIButton = {
        let addCategoryButton = UIButton()
        addCategoryButton.setTitle("+", for: .normal)
        addCategoryButton.setTitleColor(.white, for: .normal)
        addCategoryButton.backgroundColor = .button.lavender
        addCategoryButton.layer.cornerRadius = 10
        return addCategoryButton
    }()
    
    var memoTableView: UITableView = {
        let memoTableView = UITableView(frame: .zero, style: .grouped)
        memoTableView.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        memoTableView.backgroundColor = .clear
        // 스크롤 설정
        memoTableView.bounces = true // 스크롤중 테이블뷰 하단에 도달했을 때 반동 효과 여부
        memoTableView.alwaysBounceVertical = true // cell 컨텐츠가 뷰 높이보다 작아도 수직 방향 반동 효과 여부
        memoTableView.isScrollEnabled = true // 스크롤 가능 여부
        memoTableView.showsVerticalScrollIndicator = true // 스크롤 시 스크롤바 노출 여부
        // 선택
        memoTableView.allowsSelection = true // 하나 선택
        // 여백
        memoTableView.contentInset = .zero // 테이블뷰 컨텐츠 여백
        memoTableView.tableFooterView = UIView(frame: .zero)
        memoTableView.sectionFooterHeight = 0
        // 표시
        memoTableView.separatorStyle = .singleLine // 구분선 노출 여부
        memoTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 구분선 여백 설정
        memoTableView.showsVerticalScrollIndicator = false
        return memoTableView
    }()
    
    var nodataLabel = CustomLabel(title: "메모할 카테고리를 입력해주세요.", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        didTabAddCategoryButton()
        hideOnLabel()
        configureDismissKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension FourthView {
    func setUp() {
        addSubview(inputCategoryBar)
        addSubview(addCategoryButton)
        addSubview(memoTableView)
        addSubview(nodataLabel)
        
        inputCategoryBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(-Constants.spacing.px8)
        }
        inputCategoryBar.delegate = self
        
        addCategoryButton.snp.makeConstraints {
            $0.centerY.equalTo(inputCategoryBar.searchTextField)
            $0.leading.equalTo(inputCategoryBar.snp.trailing).offset(Constants.spacing.px10)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(Constants.size.size50)
            $0.height.equalTo(inputCategoryBar.searchTextField.snp.height)
        }
        
        memoTableView.snp.makeConstraints {
            $0.top.equalTo(inputCategoryBar.snp.bottom).offset(Constants.spacing.px10)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        memoTableView.delegate = self
        memoTableView.dataSource = self
        
        nodataLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        setUpBindings()
    }
}

// MARK: - Method
extension FourthView {
    // 입력한 데이터가 없는 경우
    func hideOnLabel() {
        nodataLabel.isHidden = !viewModel.categories.isEmpty
    }
    
    // 카테고리 추가 버튼
    func didTabAddCategoryButton() {
        addCategoryButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            // 입력값을 가져와 ViewModel로 전달
            guard let inputText = self.inputCategoryBar.searchTextField.text, !inputText.isEmpty else {
                let alert = UIAlertController(title: "빈 값", message: "추가할 카테고리 이름을 입력해주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.parentViewController?.present(alert, animated: true)
                return
            }
            
            self.viewModel.addCategory(inputText)
            self.inputCategoryBar.searchTextField.text = "" // 입력 필드 초기화
        }), for: .touchUpInside)
    }

    //
    func setUpBindings() {
        // ViewModel 데이터 변경을 감지하고 TableView 갱신
        viewModel.onCategoriesUpdated = { [weak self] in
            guard let self = self else { return }
            self.memoTableView.reloadData()
            self.hideOnLabel()
        }
    }
    
    // 화면 클릭 시 키보드 내리기
    func configureDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

// MARK: - delegate
extension FourthView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let headerLabel = CustomLabel(title: "\(viewModel.categories[section].categoryTitle)", size: Constants.size.size12, weight: .Regular, color: .text.subDarkGray)
        
        let addItemButton: UIButton = {
            let addItemButton = UIButton()
            addItemButton.setTitle("+", for: .normal)
            addItemButton.setTitleColor(.white, for: .normal)
            addItemButton.backgroundColor = .button.lavender
            addItemButton.layer.cornerRadius = 10
            return addItemButton
        }()
        
        let deleteCategoryButton: UIButton = {
            let deleteCategoryButton = UIButton()
            deleteCategoryButton.setTitle("-", for: .normal)
            deleteCategoryButton.setTitleColor(.white, for: .normal)
            deleteCategoryButton.backgroundColor = .button.lavender
            deleteCategoryButton.layer.cornerRadius = 10
            return deleteCategoryButton
        }()
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(addItemButton)
        headerView.addSubview(deleteCategoryButton)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.bottom.equalTo(headerView).offset(-Constants.margin.vertical)
        }
        
        addItemButton.snp.makeConstraints {
            $0.centerY.equalTo(headerLabel)
            $0.leading.equalTo(headerLabel.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(deleteCategoryButton.snp.leading).offset(-Constants.margin.horizontal)
            $0.width.equalTo(Constants.size.size50)
            $0.height.equalTo(Constants.size.size35)
        }
        
        deleteCategoryButton.snp.makeConstraints {
            $0.centerY.equalTo(headerLabel)
            $0.leading.equalTo(addItemButton.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView)
            $0.width.equalTo(Constants.size.size50)
            $0.height.equalTo(Constants.size.size35)
        }
        
        addItemButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            // 해당 카테고리의 id를 가져오기
            let categoryId = self.viewModel.categories[section].id
            
            guard let parentVC = self.parentViewController else { return }
            
            let alert = UIAlertController(title: "항목 추가", message: "추가할 항목을 입력하세요", preferredStyle: .alert)
            
            alert.addTextField {
                textField in textField.placeholder = "항목 입력"
            }
            
            let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty {
                    // 카테고리 id와 함께 아이템 추가
                    self.viewModel.addItem(categoryId: categoryId, itemTitle: text)
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            
            parentVC.present(alert, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        deleteCategoryButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let categoryId = self.viewModel.categories[section].id
            self.viewModel.deleteCategory(categoryId)
        }), for: .touchUpInside)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.size.size40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories[section].itemTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        let itemTitle = viewModel.categories[indexPath.section].itemTitle[indexPath.row]
        cell.configure(with: itemTitle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
    
    // 셀 삭제 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = viewModel.categories[indexPath.section]
            let itemToDelete = category.itemTitle[indexPath.row]
            
            // ViewModel에서 데이터 삭제
            viewModel.deleteItem(categoryId: category.id, itemTitle: itemToDelete)
            
            // 전체 테이블 뷰 갱신
            tableView.reloadData()
        }
    }
}

// MARK: - UITextFieldDelegate
extension FourthView: UISearchBarDelegate {
    // 텍스트필드 리턴키 눌리면 키보드 내리기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 키보드 내리기
    }
}
