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
    
    // MARK: - Components
    var inputCategoryBar: UISearchBar = {
        let inputCategoryBar = UISearchBar()
        inputCategoryBar.placeholder = "카테고리 입력 후 추가"
        inputCategoryBar.searchBarStyle = .minimal
        inputCategoryBar.sizeToFit()
        return inputCategoryBar
    }()
    
    var addCategoryButton: UIButton = {
        let addCategoryButton = UIButton()
        addCategoryButton.setTitle("추가", for: .normal)
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
        return memoTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        didTabAddCategoryButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        didTabAddCategoryButton()
    }
}

// MARK: - SetUp
private extension FourthView {
    func setUp() {
        addSubview(inputCategoryBar)
        addSubview(addCategoryButton)
        addSubview(memoTableView)
        
        inputCategoryBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(-Constants.spacing.px8)
        }
        
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
        
        setUpBindings()
    }
}

// MARK: - Method
extension FourthView {
    func didTabAddCategoryButton() {
        addCategoryButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            // 입력값을 가져와 ViewModel로 전달
            guard let inputText = self.inputCategoryBar.searchTextField.text, !inputText.isEmpty else {
                print("빈 값은 추가할 수 없습니다.")
                return
            }
            
            self.viewModel.addCategory(inputText)
            self.inputCategoryBar.searchTextField.text = "" // 입력 필드 초기화
        }), for: .touchUpInside)
    }

    func setUpBindings() {
        // ViewModel 데이터 변경을 감지하고 TableView 갱신
        viewModel.onCategoriesUpdated = { [weak self] in
            self?.memoTableView.reloadData()
        }
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
            addItemButton.setTitle("추가", for: .normal)
            addItemButton.setTitleColor(.white, for: .normal)
            addItemButton.backgroundColor = .button.lavender
            addItemButton.layer.cornerRadius = 10
            return addItemButton
        }()
        
        let deleteCategoryButton: UIButton = {
            let deleteCategoryButton = UIButton()
            deleteCategoryButton.setTitle("삭제", for: .normal)
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
            self.viewModel.addItem(self.viewModel.categories[section].categoryTitle, self.viewModel.categories[section].itemTitle)
        }), for: .touchUpInside)
        
        
        deleteCategoryButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.deleteCategory(self.viewModel.categories[section].id)
        }), for: .touchUpInside)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.size.size40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories[section].categoryTitle.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
}
