//
//  HomepageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

fileprivate struct Section: Hashable {
    let id: UUID
    let title: String
}

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView! { didSet {
        mainImageView.layer.cornerRadius = 15
    }}
    
    @IBOutlet weak var mapContentsTableView: UITableView!
    
    let tableViewCellHeight: CGFloat = 400
    let tableViewHeaderHeight: CGFloat = 100
    let tableViewSeparatorHeight: CGFloat = 10
    
    private lazy var tableDataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapContentsTableView.delegate = self
        self.mapContentsTableView.separatorStyle = .none
        
        mapContentsTableView.register(UINib(nibName: String(describing: HomePageMapInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomePageMapInfoTableViewCell.self))
        
        let mapInfoListModels = MapInfosViewModel.shared.getMapListsFake(withClock: true, canSetFavorite: true)
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, MapInfoListModel>()
        
        mapInfoListModels.contents.forEach {
            let section = Section(id: UUID(), title: $0.title)
            snapshot.appendSections([section])
            snapshot.appendItems([$0], toSection: section)
        }
        
        self.tableDataSource.defaultRowAnimation = .fade
        self.tableDataSource.apply(snapshot, animatingDifferences: true)
    
        let estimatedHeight = CGFloat(mapInfoListModels.contents.count) * (self.tableViewCellHeight + self.tableViewHeaderHeight + 50)

        self.mapContentsTableView.heightAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        headerTitleLabel.font = .systemFont(ofSize: 36)
        headerTitleLabel.textColor = UIColor(named: "defaultFontColor")
        headerView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        return headerView
    }
    
}

@available(iOS 13.0, *)
fileprivate extension HomepageViewController {
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, MapInfoListModel> {
        return UITableViewDiffableDataSource(
            tableView: mapContentsTableView) { tableView, indexPath, listModel in
                let cell = self.mapContentsTableView.dequeueReusableCell(withIdentifier: String(describing: HomePageMapInfoTableViewCell.self), for: indexPath) as! HomePageMapInfoTableViewCell
                cell.setupMapInfoListModel(mapsInfo: listModel.infos)
                return cell
            }
    }
}

