//
//  MapDetailSideMenuViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import UIKit

class MapDetailSideMenuViewController: UIViewController {
    
    @IBOutlet weak var goBackButton: UIButton!
    
    @IBOutlet weak var goToHomePageButton: UIButton!
    
    @IBOutlet weak var mapTitleLabel: UILabel!
    
    @IBOutlet weak var openTimeStackView: UIStackView!
    
    @IBOutlet weak var openTimeIconImageView: UIImageView!
    @IBOutlet weak var openTimeLabel: UILabel!
    
    // touch map's UI
    
    @IBOutlet weak var tactileMapPageRelatedStackView: UIStackView!
    @IBOutlet weak var enterPathPageContainerView: UIView!{ didSet {
        enterPathPageContainerView.layer.cornerRadius = 10
    }}
    
    @IBOutlet weak var enterPathPageButton: UIButton!
    
    @IBOutlet weak var allMapNameStackView: UIStackView!
    
    @IBOutlet weak var shouldPlayMapNameSwitch: UISwitch!
    
    @IBOutlet weak var shouldPlayMapNameSwitchOutterButton: UIButton!
    
    //path training's UI
    
    @IBOutlet weak var trainingPathPageRelatedStackView: UIStackView!
    
    @IBOutlet weak var startPointContainerView: UIView! { didSet {
        startPointContainerView.layer.cornerRadius = 10
    }}
    @IBOutlet weak var startPointLabel: UILabel!
    
    @IBOutlet weak var endPointContainerView: UIView!{ didSet {
        endPointContainerView.layer.cornerRadius = 10
    }}
    
    @IBOutlet weak var endPointLabel: UILabel!
    
    var coodinator: MapDetailCoordinator
    var viewModel: MapDetailSideMenuViewModel
    
    init(coodinator: MapDetailCoordinator, viewModel: MapDetailSideMenuViewModel) {
        self.coodinator = coodinator
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onclickGoBackButton(_ sender: Any) {
        self.coodinator.navigationController.popViewController(animated: false)
    }
    
    @IBAction func onClickGoToHomePageButton(_ sender: Any) {
        self.coodinator.goToHomePage()
    }
    
    @IBAction func onclickenterPathPageButton(_ sender: Any) {
        self.coodinator.goToPathTrainingPage(with: self.viewModel.currentMap)
    }
    
    
    @IBAction func onclickShouldPlayMapNameSwitchOutterButton(_ sender: Any) {
        
    }
    
    @IBAction func onClickSelectStartPoint(_ sender: Any) {
        
    }
    
    
    @IBAction func onClickSelectEndPoint(_ sender: Any) {
        
    }
    
}
