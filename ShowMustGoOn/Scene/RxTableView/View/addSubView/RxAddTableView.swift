//
//  RxAddTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

class RxAddTableView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxAddViewModel()
    weak var parentViewController: UIViewController?
    
    // MARK: - Components
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "카테고리 입력 후 추가"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = .done
        searchBar.showsCancelButton = false
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
        bindNodataLabel()
        tabAddCategoryButton()
        bindTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension RxAddTableView {
    func setUp() {
        addSubview(searchBar)
        addSubview(addCategoryButton)
        addSubview(memoTableView)
        addSubview(nodataLabel)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(-Constants.spacing.px8)
        }
        
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
        
        nodataLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension RxAddTableView {
    // 테이블뷰셀 데이터 바인딩 정리 - 재사용 가능성
    func createDataSource() -> RxTableViewSectionedReloadDataSource<AddSection> {
        return RxTableViewSectionedReloadDataSource<AddSection>(
            configureCell: { _, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as? AddTableViewCell else { return UITableViewCell() }
                cell.checkItemTitle.text = item.checkItemTitle
                return cell
            }
        )
    }
    
    // 데이터 없다는 라벨 동작
    private func bindNodataLabel() {
        viewModel.data
            .asObservable()
            .map { !$0.isEmpty } // 데이터가 있는 경우 라벨 숨김
            .bind(to: nodataLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    // 카테고리 추가 버튼 클릭 동작
    private func tabAddCategoryButton() {
        addCategoryButton.rx.tap
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .withUnretained(self)
            .do(onNext: { owner, text in
                owner.viewModel.addCategory(title: text)
                print(text)
            })
            .subscribe(onNext: { owner, _ in
                owner.searchBar.text = ""
            })
            .disposed(by: disposeBag)
    }
    
    // data bind
    private func bindTableView() {
        viewModel.data
            .bind(to: memoTableView.rx.items(dataSource: createDataSource()))
            .disposed(by: disposeBag)
        
        memoTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: - delegate
extension RxAddTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray6
        
        let headerLabel = CustomLabel(title: viewModel.data.value[section].header, size: Constants.size.size12, weight: .Regular, color: .text.subDarkGray)
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
        
        // 체크 아이템 추가 버튼 탭 -
        addCheckListButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard let parentVC = owner.parentViewController else { return }
                
                let alert = UIAlertController(
                    title: "항목 추가",
                    message: "추가할 항목을 입력하세요",
                    preferredStyle: .alert
                )
                
                alert.addTextField { textField in
                    textField.placeholder = "항목 입력"
                }
                
                let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    if let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty {
                        // 카테고리 id와 함께 아이템 추가
                        let categoryId = self.viewModel.data.value[section].id
//                        self.viewModel.addCheckItem(categoryId: categoryId, checkItemTitle: text)
                    }
                }
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
                alert.addAction(addAction)
                alert.addAction(cancelAction)
                
                parentVC.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        // 카테고리 삭제 버튼 탭
        deleteCategoryButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                self.viewModel.deletecategory(categoryId: self.viewModel.data.value[section].id)
            })
            .disposed(by: disposeBag)
            
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.size.size40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
}
