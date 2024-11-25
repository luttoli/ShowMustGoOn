# UITableView

# UITableView?

- List 형태의 UI
- UIScrollView를 상속하여 스크롤 가능
- cell 이라는 행을 가짐

---

# ViewController에서 TableView 사용하기

```swift
**var** firstTableView: UITableView = {
    **let** firstTableView = UITableView(frame: .zero, style: .plain)
    firstTableView.register(NumTableViewCell.**self**, forCellReuseIdentifier: NumTableViewCell.identifier)
    firstTableView.backgroundColor = .clear
    // 스크롤 설정
    firstTableView.bounces = **true** // 스크롤중 테이블뷰 하단에 도달했을 때 반동 효과 여부
    firstTableView.alwaysBounceVertical = **true** // cell 컨텐츠가 뷰 높이보다 작아도 수직 방향 반동 효과 여부
    firstTableView.isScrollEnabled = **true** // 스크롤 가능 여부
    firstTableView.showsVerticalScrollIndicator = **true** // 스크롤 시 스크롤바 노출 여부
    // 선택
    firstTableView.allowsSelection = **true** // 하나 선택
    firstTableView.allowsMultipleSelection = **true** // 중복 선택
    // 여백
    firstTableView.contentInset = .zero // 테이블뷰 컨텐츠 여백
    // 표시
    firstTableView.separatorStyle = .singleLine // 구분선 노출 여부
    firstTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 구분선 여백 설정
    firstTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: firstTableView.frame.width, height: 50)) // 헤더뷰
    firstTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: firstTableView.frame.width, height: 50)) // 푸터뷰
    // 성능
    firstTableView.estimatedRowHeight = 44
    firstTableView.rowHeight = UITableView.automaticDimension
    **return** firstTableView
}()
```

## UITableView.style

### plain

- 스크롤 시 header 상단에 고정

### grouped

- 스크롤 시 header 상단에 고정되지 않음
- header가 있으면 자동으로 footer가 있음 (사용하지 않을경우 영역을 코드로 없애야함)
    
    ```swift
    makeTableView.tableFooterView = UIView(frame: .zero)
    makeTableView.sectionFooterHeight = 0
    ```
    

### insetGrouped

- rows들의 bounds가 둥근 모형이며, row 양 옆에 inset이 들어가는 것 (아이폰 설정 모양)

---

## UITableView 스크롤 설정

### bounces

- 스크롤중 테이블뷰 하단에 도달했을 때 반동 효과 여부

### alwaysBounceVertical

- cell 컨텐츠가 뷰 높이보다 작아도 수직 방향 반동 효과 여부

### isScrollEnabled

- 스크롤 가능 여부

### showsVerticalScrollIndicator

- 스크롤 시 스크롤바 노출 여부

---

## UITableView 선택 설정

### allowsSelection

- 하나 선택

### allowsMultipleSelection

- 중복 선택

---

## UITableView 여백 설정

```swift
firstTableView.contentInset = .zero // 테이블뷰 컨텐츠 여백
```

---

## UITableView 표시 설정

```swift
firstTableView.separatorStyle = .singleLine // 구분선 노출 여부
firstTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 구분선 여백 설정
firstTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: firstTableView.frame.width, height: 50)) // 헤더뷰
firstTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: firstTableView.frame.width, height: 50)) // 푸터뷰
```

---

# cell 생성하기

- 각 행의 컨텐츠를 나타내는 View
- 셀 등록 후 반환

## UITableViewCell.identifier로 테이블뷰 셀 재사용 간편하게 만들기

```swift
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
```

- 셀의 클래스 이름을 문자열로 반환
- 셀 등록이나 재사용 시 문자열 대신 identifier 사용
    
    ```swift
    // 셀 등록
    tableView.register(MyCustomCell.self, forCellReuseIdentifier: MyCustomCell.identifier)
    
    // 셀 재사용
    let cell = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as! MyCustomCell
    ```
    

## customCell 정의

### cell Components 설정

```swift
class BasicTableViewCell: UITableViewCell {
    // MARK: - Components
    var numLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var titleLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
```

### 레이아웃 설정

```swift
// MARK: - SetUp
private extension BasicTableViewCell {
    func setUp() {
        contentView.addSubview(numLabel)
        contentView.addSubview(titleLabel)
        
        numLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(numLabel.snp.trailing).offset(Constants.margin.horizontal)
        }
    }
}
```

### 데이터 연결

- 데이터 모델(TableModel)을 기반으로 셀 업데이트
- TableModel 구조체로 전달받은 데이터를 활용하여 numLabel, titleLabel의 내용을 업데이트 한다.

```swift
// MARK: - Method
extension BasicTableViewCell {
    func configure(with model: TableModel) {
        numLabel.text = "\(model.number)."
        titleLabel.text = model.title
    }
}
```

## TableView Delegate, DataSource 채택하여 구성하기

### **numberOfRowsInSection**

- 섹션당 몇 개의 행을 표시할지 설정
    
    ```swift
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    ```
    

### **cellForRowAt**

- 특정 인덱스에 표시될 셀 내용 설정  - dequeueReusableCell 메서드를 사용하여 재사용 가능할 셀을 가져오고, configure 메서드로 셀 구성
    
    ```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.identifier, for: indexPath) as? BasicTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.tableData[indexPath.row])
        return cell
    }
    ```
    

**didSelectRowAt**

- 특정 셀 선택 시 동작 정의
    
    ```swift
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.tableData[indexPath.row]
        print("\(model.number). \(model.title)")
    }
    ```
    

**heightForRowAt**

- 행 높이 설정
    
    ```swift
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
    ```
    

![Simulator Screenshot - iPhone 16 Pro - 2024-11-24 at 16.22.12.png](UITableView%2051f407dc74c1490babe37eecd411a12d/Simulator_Screenshot_-_iPhone_16_Pro_-_2024-11-24_at_16.22.12.png)