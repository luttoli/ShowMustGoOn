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
    var viewModel = CalendarCollectionViewModel()
    
    // MARK: - Components
    var yearLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular, color: .text.black)
    var leftButton = CustomButton(type: .iconButton(icon: .left))
    var todayButton = CustomButton(type: .textButton(title: "오늘", color: .lavender, size: .small))
    var rightButton = CustomButton(type: .iconButton(icon: .right))
    
    private lazy var moveButtonStackView: UIStackView = {
        let moveButtonStackView = UIStackView(arrangedSubviews: [leftButton, todayButton, rightButton])
        moveButtonStackView.axis = .horizontal
        moveButtonStackView.distribution = .equalCentering
        moveButtonStackView.spacing = Constants.spacing.px20
        return moveButtonStackView
    }()
    
    private lazy var calendarHeaderStackView: UIStackView = {
        let calendarHeaderStackView = UIStackView(arrangedSubviews: [yearLabel, moveButtonStackView])
        calendarHeaderStackView.axis = .horizontal
        calendarHeaderStackView.distribution = .equalSpacing
        calendarHeaderStackView.alignment = .top
        return calendarHeaderStackView
    }()
    
    private lazy var dayStackView: UIStackView = {
        let dayStackView = UIStackView()
        dayStackView.axis = .horizontal
        dayStackView.distribution = .fillEqually
        dayStackView.alignment = .center
        return dayStackView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
        updateCalendar(to: Date())
        bindViewModel()
        setupButtonActions()
        configureDayLabel()
        
        //
        viewModel.generateMonths()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CalendarCollectionView {
    func setUp() {
        addSubview(calendarHeaderStackView)
        addSubview(dayStackView)
        addSubview(collectionView)
        
        calendarHeaderStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        dayStackView.snp.makeConstraints {
            $0.top.equalTo(calendarHeaderStackView.snp.bottom).offset(Constants.margin.vertical)
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
    // 날짜 변경 메소드
    private func updateCalendar(to date: Date) {
        viewModel.updateYear(to: date)
        bindViewModel()
    }
    
    // UI 업데이트
    private func bindViewModel() {
        yearLabel.text = viewModel.yearLabelText
        collectionView.reloadData()
    }
    
    // 왼쪽, 오늘, 오른쪽 버튼 클릭 액션
    func setupButtonActions() {
        leftButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let previousMonth = self.viewModel.calendar.date(byAdding: .month, value: -1, to: self.viewModel.calendarDate) ?? Date()
            self.updateCalendar(to: previousMonth)
        }), for: .touchUpInside)

        rightButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let nextMonth = self.viewModel.calendar.date(byAdding: .month, value: +1, to: self.viewModel.calendarDate) ?? Date()
            self.updateCalendar(to: nextMonth)
        }), for: .touchUpInside)

        todayButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.updateCalendar(to: Date()) // 오늘 날짜로 이동
        }), for: .touchUpInside)
    }
    
    // 요일 라벨을 표시할 스택뷰 설정
    func configureDayLabel() {
        let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let dayLabel = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size15, weight: .Regular, color: .text.black)
            dayLabel.textAlignment = .center
            
            if i == 0 || i == 6 {
                dayLabel.textColor = .text.notification.red
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
        // 정해긴 기간만큼의 월 수가 노출되게
        return viewModel.months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.black.cgColor
        
        let month = viewModel.months[indexPath.item] // 월 데이터
        let days = viewModel.daysByMonths[month] ?? [] // 해당 월의 일 데이터
        cell.configure(with: month, days: days)
        
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
