//
//  BackMiracleListCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/26/25.
//

import UIKit

import SnapKit

class BackMiracleListCollectionViewCell: UICollectionViewCell {
    //
    var backMiracle: BackMiracleCollectionModel? {
        didSet {
            setupCellData()
        }
    }
    
    // MARK: - Components
    var backMiracleTitleLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .medium, color: .text.black)
    
    private lazy var dayStackView: UIStackView = {
        let dayStackView = UIStackView()
        dayStackView.axis = .horizontal
        dayStackView.distribution = .fillEqually
        dayStackView.alignment = .center
        return dayStackView
    }()
    
    var upButton = CustomButton(type: .iconButton(icon: .up))
    var yearLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .medium, color: .text.black)
    var downButton = CustomButton(type: .iconButton(icon: .down))
    
    private lazy var yearStackView: UIStackView = {
        let yearStackView = UIStackView(arrangedSubviews: [upButton, yearLabel, downButton])
        yearStackView.axis = .vertical
        yearStackView.alignment = .center
        yearStackView.spacing = Constants.spacing.px8
        return yearStackView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BlockCollectionViewCell.self, forCellWithReuseIdentifier: BlockCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    var dayNumberLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .medium, color: .text.black)
    var doneCountLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .medium, color: .text.black)
    var doneButton = CustomButton(type: .textButton(title: "완료", color: .lavender, size: .small))
    
    private lazy var doneStackView: UIStackView = {
        let doneStackView = UIStackView(arrangedSubviews: [dayNumberLabel, doneCountLabel, doneButton])
        doneStackView.axis = .vertical
        doneStackView.alignment = .center
        doneStackView.spacing = Constants.spacing.px20
        return doneStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
        configureDayLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension BackMiracleListCollectionViewCell {
    func setUp() {
        contentView.addSubview(backMiracleTitleLabel)
        contentView.addSubview(dayStackView)
        contentView.addSubview(yearStackView)
        contentView.addSubview(collectionView)
        contentView.addSubview(doneStackView)
        
        backMiracleTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.margin.horizontal)
            $0.trailing.equalToSuperview().offset(-Constants.margin.horizontal)
        }
        
        dayStackView.snp.makeConstraints {
            $0.top.equalTo(backMiracleTitleLabel.snp.bottom).offset(Constants.margin.horizontal)
            $0.leading.equalTo(yearStackView.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(doneStackView.snp.leading).offset(-Constants.margin.horizontal)
        }
        
        yearStackView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.width.equalTo(yearLabel.snp.width)
            $0.centerY.equalTo(collectionView)
        }
        yearLabel.numberOfLines = 0
        yearLabel.textAlignment = .center
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(dayStackView.snp.bottom).offset(Constants.spacing.px4)
            $0.leading.equalTo(yearStackView.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(doneStackView.snp.leading).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        doneStackView.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.width.equalTo(doneCountLabel.snp.width)
            $0.centerY.equalTo(collectionView)
        }
    }
}

// MARK: - Method
extension BackMiracleListCollectionViewCell {
    private func setupCellData() {
        guard backMiracle != nil else { return }
        collectionView.reloadData() // 작은 콜랙션뷰 갱신
    }
    
    // 요일 라벨을 표시할 스택뷰 설정
    func configureDayLabel() {
        let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let dayLabel = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size15, weight: .Regular, color: .text.black)
            dayLabel.textAlignment = .center
            
            if i == 1 || i == 3 || i == 5 {
                dayLabel.textColor = .text.black
            } else {
                dayLabel.textColor = .text.white
            }
            
            self.dayStackView.addArrangedSubview(dayLabel)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension BackMiracleListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 42
        return backMiracle?.backDays.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlockCollectionViewCell.identifier, for: indexPath) as? BlockCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.systemGray4
        cell.layer.cornerRadius = Constants.radius.px4
        
        cell.backgroundColor = backMiracle?.backDays[indexPath.row].isChecked == true ? .background.lavender : UIColor.systemGray4
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 3
        let width = (collectionView.bounds.width - (spacing * 6)) / 7
        let height = (collectionView.bounds.height - (spacing * 5)) / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
