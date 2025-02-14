//
//  CalendarCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

import SnapKit

class CalendarCollectionView: UIView {
    // MARK: - Properties
    var viewModel = CalendarCollcetionViewModel()
    
    // MARK: - Components
    var leftButton = CustomButton(type: .iconButton(icon: .left))
    var yearLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular, color: .text.black)
    var rightButton = CustomButton(type: .iconButton(icon: .right))
    var todayButton = CustomButton(type: .textButton(title: "오늘", color: .lavender, size: .small))
    
    private lazy var yearStackView: UIStackView = {
        let yearStackView = UIStackView(arrangedSubviews: [leftButton, yearLabel, rightButton])
        yearStackView.axis = .horizontal
        yearStackView.distribution = .equalCentering
        yearStackView.spacing = Constants.margin.horizontal
        return yearStackView
    }()
    
    private lazy var calendarHeader: UIStackView = {
        let calendarHeader = UIStackView(arrangedSubviews: [yearStackView, todayButton])
        calendarHeader.axis = .horizontal
        calendarHeader.distribution = .equalSpacing
        calendarHeader.alignment = .top
        return calendarHeader
    }()
    
    private lazy var dayStackView: UIStackView = {
        let numberStackView = UIStackView()
        numberStackView.axis = .horizontal
        numberStackView.distribution = .fillEqually
        numberStackView.alignment = .center
        return numberStackView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
        collectionView.register(CalendarBoxCollectionViewCell.self, forCellWithReuseIdentifier: CalendarBoxCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        bindViewModel()
        configureDayLabel()
        previousNextButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CalendarCollectionView {
    func setUp() {
        addSubview(calendarHeader)
        addSubview(dayStackView)
        addSubview(collectionView)
        
        calendarHeader.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        dayStackView.snp.makeConstraints {
            $0.top.equalTo(calendarHeader.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(dayStackView.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension CalendarCollectionView {
    private func bindViewModel() {
        yearLabel.text = viewModel.yearLabelText
    }
    
    func previousNextButtonAction() {
        leftButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            let previousMonth = self.viewModel.calendar.date(byAdding: .month, value: -1, to: self.viewModel.calendarDate) ?? Date()
            self.viewModel.updateYear(to: previousMonth)
            self.yearLabel.text = self.viewModel.yearLabelText
            
            // datecell 지난달로 이동해야할거
        }), for: .touchUpInside)
        
        rightButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            let nextMonth = self.viewModel.calendar.date(byAdding: .month, value: +1, to: self.viewModel.calendarDate) ?? Date()
            self.viewModel.updateYear(to: nextMonth)
            self.yearLabel.text = self.viewModel.yearLabelText
            
            // datecell 다음달로 이동해야할거
        }), for: .touchUpInside)
    }
    
    func configureDayLabel() {
        let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let dayLabel = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size12, weight: .Regular, color: .text.black)
            dayLabel.textAlignment = .center
            
            if i == 0 {
                dayLabel.textColor = .text.notification.red
            } else if i == 6 {
                dayLabel.textColor = .text.lavender
            } else {
                dayLabel.textColor = .text.black
            }
            
            self.dayStackView.addArrangedSubview(dayLabel)
        }
    }
}

// MARK: - delegate
extension CalendarCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarBoxCollectionViewCell.identifier, for: indexPath) as? CalendarBoxCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // horizontal collectionViewCell 끼리의 여백 줄이기
    }
}
