//
//  MonthCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

import SnapKit

class MonthCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var viewModel = CalendarCollectionViewModel()
    
    // MARK: - Components
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var days: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
        viewModel.daysUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension MonthCollectionViewCell {
    func setUp() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension MonthCollectionViewCell {
    func configure(with month: Date, days: [String]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
//        monthLabel.text = formatter.string(from: month)

        self.days = days
        collectionView.reloadData()
    }
}

// MARK: - CollectionViewDelegate
extension MonthCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count // 전체 캘린더칸에 빈문자 포함이기 때문에 42개 동일
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: days[indexPath.row])
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.cell.lightGray.cgColor
        
        // 오늘 날짜에 표시 - 이거 수정해야함
        if let today = viewModel.todayNumber, viewModel.days[indexPath.row] == today {
            cell.backgroundColor = .cell.lavender.withAlphaComponent(0.3) // 배경 강조
        } else {
            cell.backgroundColor = .clear
        }
        
        // 일요일, 토요일 셀에 들어가는 라벨 색 변경
        let dayIndex = indexPath.row % 7 // 7로 나눈 나머지 값이 요일을 의미
        if dayIndex == 0 || dayIndex == 6 {
            cell.dateLabel.textColor = UIColor.text.notification.red
        } else {
            cell.dateLabel.textColor = UIColor.text.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 1
        let width = (collectionView.bounds.width - (spacing * 6)) / 7
        let height = (collectionView.bounds.height - (spacing * 5)) / 6
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
