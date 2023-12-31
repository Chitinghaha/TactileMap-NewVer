//
//  HomepageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit
import Combine

fileprivate struct Section: Hashable {
    let id: Int
    let title: String
}

class HomepageViewController: UIViewController {
    // MARK: Constants
    let tableViewCellHeight: CGFloat = 400
    let tableViewHeaderHeight: CGFloat = 100
    let tableViewSeparatorHeight: CGFloat = 10
    
    // MARK: IBOutlets
    @IBOutlet weak var mainImageView: UIImageView! { didSet {
        mainImageView.layer.cornerRadius = 15
    }}
    
    @IBOutlet weak var mapContentsTableView: UITableView!
    
    @IBOutlet weak var mapContentsTableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Member var
    private lazy var tableDataSource = makeDataSource()
    var coordinator: HomepageCoordinator
    
    private var cancellable = Set<AnyCancellable>()
        
    // MARK: Life Cycle
    init(coordinator: HomepageCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initTableView() {
        self.mapContentsTableView.delegate = self
        self.mapContentsTableView.separatorStyle = .none
        
        mapContentsTableView.register(UINib(nibName: String(describing: HomePageMapInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomePageMapInfoTableViewCell.self))
        
        self.tableDataSource.defaultRowAnimation = .fade
        self.mapContentsTableViewHeightConstraint.constant = 0
    
        var snapshot = NSDiffableDataSourceSnapshot<Section, MapList>()
        
        MapInfoDataStore.shared.mapLists.forEach {
            let section = Section(id: $0.id, title: $0.title)
            snapshot.appendSections([section])
            snapshot.appendItems([$0], toSection: section)
        }
        
        self.tableDataSource.apply(snapshot, animatingDifferences: true)
        
        if (self.mapContentsTableViewHeightConstraint.constant == 0) {
            let estimatedHeight = CGFloat(MapInfoDataStore.shared.mapLists.count) * (self.tableViewCellHeight + self.tableViewHeaderHeight + 50)

            self.mapContentsTableViewHeightConstraint.constant = estimatedHeight
        }
        
    }
}

extension HomepageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.tableViewHeaderHeight))
        
        if (section > 0) {
            let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.tableViewSeparatorHeight))
            separatorView.layer.cornerRadius = 4
            separatorView.backgroundColor = .systemGray
            headerView.addSubview(separatorView)
            separatorView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        }
        
        let headerTitleLabel = UILabel(frame: headerView.frame)
        headerView.addSubview(headerTitleLabel)
        
        headerTitleLabel.text = self.tableDataSource.snapshot().sectionIdentifiers[section].title
        headerTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        headerTitleLabel.textColor = UIColor.systemBackground
        headerView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        return headerView
    }
    
}

@available(iOS 13.0, *)
fileprivate extension HomepageViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Section, MapList> {
        return UITableViewDiffableDataSource(
            tableView: self.mapContentsTableView) { tableView, indexPath, listModel in
                let cell = self.mapContentsTableView.dequeueReusableCell(withIdentifier: String(describing: HomePageMapInfoTableViewCell.self), for: indexPath) as! HomePageMapInfoTableViewCell
                cell.setupMapInfoListModel(mapsInfo: listModel.infos)
                cell.coordinator = self.coordinator
                return cell
            }
    }
}
