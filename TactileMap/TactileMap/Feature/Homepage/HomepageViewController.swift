//
//  HomepageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

fileprivate enum Section: CaseIterable {
    case home
}

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var mapContentsTableView: UITableView!
    
    private lazy var tableDataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

@available(iOS 13.0, *)
fileprivate extension HomepageViewController {
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, MapInfoListModel> {
        return UITableViewDiffableDataSource(
            tableView: mapContentsTableView) { tableView, indexPath, listModel in
                
                return UITableViewCell()
            }
    }
}

