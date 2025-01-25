//
//  FourthView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

import SnapKit

class AddTableView: UIView {
    // MARK: - Properties
    var viewModel = AddTableViewModel()
    weak var parentViewController: UIViewController?
    
    // MARK: - Components
    // 추후에는 텍스트필드로 변경할 것
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "카테고리 입력 후 추가"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .done
        searchBar.showsCancelButton = false
        searchBar.setValue("취소", forKey: "cancelButtonText")
        return searchBar
    }()
    
    var addCategoryButton = CustomButton(type: .iconButton(icon: .plus))
    
    var memoTableView: UITableView = {
        let memoTableView = UITableView(frame: .zero, style: .grouped)
        memoTableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.identifier)
        memoTableView.backgroundColor = .clear
        return memoTableView
    }()
    
    var nodataLabel = CustomLabel(title: "메모할 카테고리를 입력해주세요.", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        hideOnLabel()
        didTapAddCategoryButton()
        setUpBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension AddTableView {
    func setUp() {
        addSubview(searchBar)
        addSubview(addCategoryButton)
        addSubview(memoTableView)
        addSubview(nodataLabel)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(-Constants.spacing.px8)
        }
        searchBar.delegate = self
        
        addCategoryButton.snp.makeConstraints {
            $0.centerY.equalTo(searchBar.searchTextField)
            $0.leading.equalTo(searchBar.snp.trailing).offset(Constants.spacing.px10)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        memoTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(Constants.spacing.px10)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        memoTableView.delegate = self
        memoTableView.dataSource = self
        
        nodataLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension AddTableView {
    // 입력한 데이터가 없는 경우
    func hideOnLabel() {
        nodataLabel.isHidden = !viewModel.categories.isEmpty
    }
    
    // Section 추가 버튼 클릭 동작
    func didTapAddCategoryButton() {
        addCategoryButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            // 입력값을 가져와 ViewModel로 전달
            guard let inputText = self.searchBar.searchTextField.text, !inputText.isEmpty else {
                let alert = UIAlertController(title: "빈 값", message: "추가할 카테고리 이름을 입력해주세요.", preferredStyle: .actionSheet)
                let buttonTitles = ["확인1", "확인2"]
                for title in buttonTitles {
                    alert.addAction(UIAlertAction(title: title, style: .default, handler: { action in
                        if let buttonTitle = action.title {
                            switch buttonTitle {
                            case "확인1":
                                print("확인1 버튼 동작: 첫 번째 작업 수행")
                            case "확인2":
                                print("확인2 버튼 동작: 두 번째 작업 수행")
                            default:
                                print("알 수 없는 버튼")
                            }
                        }
                    }))
                }
                self.parentViewController?.present(alert, animated: true)
                return
            }
            
            self.viewModel.addCategory(inputText)
            self.searchBar.searchTextField.text = "" // 입력 필드 초기화
        }), for: .touchUpInside)
    }

    // ViewModel 데이터 변경 시 업데이트
    func setUpBindings() {
        // ViewModel 데이터 변경을 감지하고 TableView 갱신
        viewModel.onCategoriesUpdated = { [weak self] in
            guard let self = self else { return }
            self.memoTableView.reloadData()
            self.hideOnLabel()
        }
    }
}

// MARK: - delegate
extension AddTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray6
        
        let headerLabel = CustomLabel(title: "\(viewModel.categories[section].categoryTitle)", size: Constants.size.size12, weight: .Regular, color: .text.subDarkGray)
        let addCheckListButton = CustomButton(type: .iconButton(icon: .plus))
        let deleteCategoryButton = CustomButton(type: .iconButton(icon: .minus))
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(addCheckListButton)
        headerView.addSubview(deleteCategoryButton)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView).offset(Constants.spacing.px8)
            $0.bottom.equalTo(headerView).offset(-Constants.margin.vertical)
        }
        
        addCheckListButton.snp.makeConstraints {
            $0.centerY.equalTo(headerLabel)
            $0.leading.equalTo(headerLabel.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(deleteCategoryButton.snp.leading).offset(-Constants.margin.horizontal)
        }
        
        deleteCategoryButton.snp.makeConstraints {
            $0.centerY.equalTo(headerLabel)
            $0.leading.equalTo(addCheckListButton.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView)
        }
        
        addCheckListButton.addAction(UIAction(handler: { [weak self] _ in
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
                    self.viewModel.addCheckItem(categoryId: categoryId, checkItemTitle: text)
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
        return viewModel.categories[section].checkItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as? AddTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        // 셀에 데이터를 설정
        let checkItem = viewModel.categories[indexPath.section].checkItem[indexPath.row]
        cell.configure(with: checkItem)

        // 기존의 버튼 액션 제거 후 추가
        cell.checkItemCheckboxButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.checkItemCheckboxButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            // 상태 토글 후 ViewModel 업데이트
            self.viewModel.checkItemToggle(categoryId: self.viewModel.categories[indexPath.section].id, checkItemId: checkItem.checkItemId)
            
            // 변경된 데이터로 UI를 업데이트하기 위해 테이블뷰 리로드
            self.memoTableView.reloadRows(at: [indexPath], with: .none)
        }), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
    
    // 셀 삭제 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = viewModel.categories[indexPath.section]
            let checkListId = category.checkItem[indexPath.row].checkItemId
            viewModel.deleteCheckItem(categoryId: category.id, checkItemId: checkListId)
            tableView.reloadData()
        }
    }
}

// MARK: - delegate
extension AddTableView: UISearchBarDelegate {
    // 검색 시작 시 호출
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true // 취소 버튼 표시
    }
    
    // 검색 버튼 클릭 시 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            print("검색어가 비어 있습니다.")
            return
        }
        print("검색 실행: \(searchText)")
        
        // 키보드 숨김
        searchBar.resignFirstResponder()
    }
    
    // 텍스트 변경될때 호출
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 실시간 검색 필터링 처리 가능
    }
    
    // 검색 종료될때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // 취소 버튼 숨김
    }
    
    // 취소 버튼 클릭 시 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = "" // 텍스트 초기화
        searchBar.resignFirstResponder() // 키보드 숨김
    }
}
