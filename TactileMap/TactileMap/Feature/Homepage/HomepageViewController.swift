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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mapInfoListModels: MultiMapInfoListModel = MultiMapInfoListModel(
            contents: [
                MapInfoListModel(
                    title: "學餐",
                    infos: [
                        SingleMapInfoModel(imageName: "tmpMap1", title: "testTitle1", description: "testDescription1", descriptionIconName: "1", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap2", title: "testTitle2", description: "testDescription2", descriptionIconName: "1", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap3", title: "testTitle3", description: "testDescription3", descriptionIconName: "1", favoriteEnabled: true, isFavorite: false),
                        SingleMapInfoModel(imageName: "tmpMap4", title: "testTitle2", description: "testDescription2", descriptionIconName: "1", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap5", title: "testTitle3", description: "testDescription3", descriptionIconName: "1", favoriteEnabled: true, isFavorite: true)
                        
                    ]
                ),
                MapInfoListModel(
                    title: "系館",
                    infos: [
                        SingleMapInfoModel(imageName: "tmpMap4", title: "testTitle1", description: "testDescription1", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap5", title: "testTitle2", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: false),
                        SingleMapInfoModel(imageName: "tmpMap6", title: "testTitle3", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap1", title: "testTitle2", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap2", title: "testTitle3", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true)
                    ]
                ),
                MapInfoListModel(
                    title: "常用區域",
                    infos: [
                        SingleMapInfoModel(imageName: "tmpMap4", title: "testTitle1", description: "testDescription1", descriptionIconName: "", favoriteEnabled: true, isFavorite: false),
                        SingleMapInfoModel(imageName: "tmpMap5", title: "testTitle2", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap6", title: "testTitle3", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap1", title: "testTitle2", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
                        SingleMapInfoModel(imageName: "tmpMap2", title: "testTitle3", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true)
                    ]
                )
            ]
        )
        
        
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
                cell.setupMapInfoListModel(mapInfoListModel: listModel)
                return cell
            }
    }
}

