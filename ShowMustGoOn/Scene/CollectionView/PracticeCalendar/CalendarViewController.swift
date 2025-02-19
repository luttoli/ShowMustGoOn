//
//  CalendarViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/18/25.
//

import UIKit

import SnapKit

class CalendarViewController: UIViewController {
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
    
    let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .cell.lightGray
        return lineView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
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
extension CalendarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        bindViewModel()
        previousNextButtonAction()
        configureDayLabel()
        setupGestures()
    }
}

// MARK: - Navigation
extension CalendarViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - SetUp
private extension CalendarViewController {
    func setUp() {
        view.addSubview(calendarHeaderStackView)
        view.addSubview(dayStackView)
        view.addSubview(lineView)
        view.addSubview(collectionView)
        
        calendarHeaderStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
        
        dayStackView.snp.makeConstraints {
            $0.top.equalTo(calendarHeaderStackView.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.spacing.px4)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.spacing.px4)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(dayStackView.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.spacing.px4)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.spacing.px4)
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.spacing.px4)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.spacing.px4)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension CalendarViewController {
    // 뷰모델에서 작성한 dateFormatter를 적용해 년월텍스트라벨에 연결
    private func bindViewModel() {
        viewModel.updateYear(to: viewModel.calendarDate)
        yearLabel.text = viewModel.yearLabelText
        collectionView.reloadData()
    }
    
    // 왼쪽, 오른쪽 버튼 클릭 액션
    func previousNextButtonAction() {
        // 왼쪽 버튼 클릭 액션
        leftButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            let previousMonth = self.viewModel.calendar.date(byAdding: .month, value: -1, to: self.viewModel.calendarDate) ?? Date()
            self.viewModel.updateYear(to: previousMonth)
            self.yearLabel.text = self.viewModel.yearLabelText
            bindViewModel()
        }), for: .touchUpInside)
        
        // 오른쪽 버튼 클릭 액션
        rightButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            let nextMonth = self.viewModel.calendar.date(byAdding: .month, value: +1, to: self.viewModel.calendarDate) ?? Date()
            self.viewModel.updateYear(to: nextMonth)
            self.yearLabel.text = self.viewModel.yearLabelText
            bindViewModel()
        }), for: .touchUpInside)
    }
    
    // 요일 라벨을 표시할 스택뷰 설정
    func configureDayLabel() {
        let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let dayLabel = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size15, weight: .Regular, color: .text.black)
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
    
    // 좌우 제스처
    private func setupGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        leftSwipe.direction = .left
        collectionView.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        rightSwipe.direction = .right
        collectionView.addGestureRecognizer(rightSwipe)
    }

    //
    @objc private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            goToNextMonth()
        } else if gesture.direction == .right {
            goToPreviousMonth()
        }
    }
    
    //
    private func goToPreviousMonth() {
        let previousMonth = self.viewModel.calendar.date(byAdding: .month, value: -1, to: self.viewModel.calendarDate) ?? Date()
        self.viewModel.updateYear(to: previousMonth)
        self.yearLabel.text = self.viewModel.yearLabelText
        bindViewModel()
    }

    //
    private func goToNextMonth() {
        let nextMonth = self.viewModel.calendar.date(byAdding: .month, value: +1, to: self.viewModel.calendarDate) ?? Date()
        self.viewModel.updateYear(to: nextMonth)
        self.yearLabel.text = self.viewModel.yearLabelText
        bindViewModel()
    }
}

// MARK: - Delegate
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.days[indexPath.row])
        
        if !viewModel.days[indexPath.row].isEmpty {
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.cell.lightGray.cgColor
        } else {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        
        if let today = viewModel.todayNumber, viewModel.days[indexPath.row] == today {
            cell.backgroundColor = .cell.lavender.withAlphaComponent(0.3) // 배경 강조
        } else {
            cell.backgroundColor = .clear
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
