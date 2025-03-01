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
    var yearLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .medium, color: .text.black)
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
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
        doneStackView.spacing = Constants.spacing.px4
        return doneStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
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
        contentView.addSubview(yearLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(doneStackView)
        
        backMiracleTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.margin.horizontal)
            $0.trailing.equalToSuperview().offset(-Constants.margin.horizontal)
        }
        
        yearLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.margin.horizontal)
            $0.centerY.equalTo(collectionView)
        }
        yearLabel.numberOfLines = 0
        yearLabel.textAlignment = .center
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(backMiracleTitleLabel.snp.bottom).offset(Constants.spacing.px12)
            $0.leading.equalTo(yearLabel.snp.trailing).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(doneStackView.snp.leading).offset(-Constants.margin.horizontal)
            $0.bottom.equalToSuperview().offset(-Constants.margin.horizontal)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        doneStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.margin.horizontal)
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
}

// MARK: - UICollectionViewDelegate
extension BackMiracleListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // 재사용 가능한 헤더 뷰 생성
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "header", for: indexPath)
            
            header.subviews.forEach { $0.removeFromSuperview() } // 기존 서브뷰 제거 (중복 추가 방지)
            
            let dayStackView: UIStackView = {
                let dayStackView = UIStackView()
                dayStackView.axis = .horizontal
                dayStackView.distribution = .fillEqually
                dayStackView.alignment = .center
                return dayStackView
            }()
            
            func configureDayLabel() {
                let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
                
                for i in 0..<7 {
                    let dayLabel = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size12, weight: .medium, color: .text.black)
                    dayLabel.textAlignment = .center
                    
                    // 월, 수, 금 텍스트 색상 변경
                    if i == 1 || i == 3 || i == 5 {
                        dayLabel.textColor = .text.black
                    } else {
                        dayLabel.textColor = .text.white
                    }
                    dayStackView.addArrangedSubview(dayLabel)
                }
            }

            configureDayLabel()
            header.addSubview(dayStackView)
            dayStackView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
            }
            return header
        }
        return UICollectionReusableView()
    }

    // 헤더 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Constants.size.size18)
    }
    
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
        let height = (collectionView.bounds.height - (spacing * 5) - 18) / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
