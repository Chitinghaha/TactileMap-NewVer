//
//  MapDetailSideMenuViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import UIKit
import Combine

class MapDetailSideMenuViewController: UIViewController {
    //MARK: IBs
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
    
    @IBOutlet weak var allMapsTableView: UITableView!
    
    @IBOutlet weak var shouldPlayMapNameSwitch: UISwitch!
    
    @IBOutlet weak var shouldPlayMapNameSwitchOutterButton: UIButton!
    
    //path training's UI
    
    @IBOutlet weak var trainingPathPageRelatedStackView: UIStackView!
    
    @IBOutlet weak var startPointContainerView: UIView! { didSet {
        startPointContainerView.layer.cornerRadius = 10
        startPointContainerView.layer.borderColor = UIColor.systemGray4.cgColor
        startPointContainerView.layer.borderWidth = 1
    }}
    @IBOutlet weak var startPointLabel: UILabel!
    
    @IBOutlet weak var endPointContainerView: UIView!{ didSet {
        endPointContainerView.layer.cornerRadius = 10
        endPointContainerView.layer.borderColor = UIColor.systemGray4.cgColor
        endPointContainerView.layer.borderWidth = 1
    }}
    
    @IBOutlet weak var endPointLabel: UILabel!
    
    @IBOutlet weak var confirmPathButton: UIButton!
    
    // Actions
    @IBAction func onclickGoBackButton(_ sender: Any) {
        self.viewModel.onclickGoBackButton()
        
    }
    
    @IBAction func onClickGoToHomePageButton(_ sender: Any) {
        self.viewModel.onClickGoToHomePageButton()
    }
    
    @IBAction func onclickEnterPathPageButton(_ sender: Any) {
        self.viewModel.onclickEnterPathPageButton()
    }
    
    @IBAction func onclickShouldPlayMapNameSwitchOutterButton(_ sender: Any) {
        self.shouldPlayMapName.toggle()
        self.shouldPlayMapNameSwitch.isOn.toggle()
    }
    
    @IBAction func onClickSelectStartPoint(_ sender: UIButton) {
        self.viewModel.onClickSelectStartPoint(sender)
    }
    
    @IBAction func onClickSelectEndPoint(_ sender: UIButton) {
        self.viewModel.onClickSelectEndPoint(sender)

    }
    
    @IBAction func onclickConfirmPathButton(_ sender: Any) {
        self.viewModel.onclickConfirmPathButton()
    }
    
    // MARK: Other members
    var viewModel: MapDetailSideMenuViewModel
    
    var isInTactileMap: Bool = true
    
    var shouldPlayMapName: Bool {
        get {
            UserDefaults.standard.bool(forKey: "EnterMapShouldPlayMapName")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "EnterMapShouldPlayMapName")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MapDetailSideMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.setupBinding()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func initView() {
        self.shouldPlayMapNameSwitch.isOn = self.shouldPlayMapName
        
        self.isInTactileMap = true
        self.trainingPathPageRelatedStackView.isHidden = true
        self.tactileMapPageRelatedStackView.isHidden = false
        
        // add maps into "所有地圖"
        // allMapNameStackView.addArragedSubview...
        self.setupAllMapsTableView()
    }
    
    func setupAllMapsTableView() {
        self.allMapsTableView.delegate = self
        self.allMapsTableView.dataSource = self
    }
    
    func clearPath() {
        self.viewModel.currentStartPoint = "請選擇"
        self.viewModel.currentEndPoint = "請選擇"
    }
}

extension MapDetailSideMenuViewController {
    func setupBinding() {
        self.viewModel.$currentMap
            .receive(on: RunLoop.main)
            .sink { [weak self] map in
                guard let self = self else { return }
                self.mapTitleLabel.text = map.title
                self.openTimeLabel.text = map.description
            }
            .store(in: &cancellables)
        
        self.viewModel.$currentStartPoint
            .sink { [weak self] in
                guard let self = self else { return }
                self.startPointLabel.text = $0
            }
            .store(in: &cancellables)
        
        self.viewModel.$currentEndPoint
            .sink { [weak self] in
                guard let self = self else { return }
                self.endPointLabel.text = $0
            }
            .store(in: &cancellables)
        
        self.viewModel.$menuPosition
            .sink { [weak self] in
                guard let self = self else { return }
                self.trainingPathPageRelatedStackView.isHidden = $0 == .tactileMap
                self.tactileMapPageRelatedStackView.isHidden = $0 == .pathTraining
            }
            .store(in: &cancellables)
    }
}

extension MapDetailSideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapInfoDataStore.shared.allMapsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let map = MapInfoDataStore.shared.allMapsInfo[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.backgroundColor = .clear
        var content = cell.defaultContentConfiguration()
        content.text = map.title
        content.image = UIImage(systemName: "star")
        content.textProperties.font = .preferredFont(forTextStyle: .title2)
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.onclickAllMapTableCell(map: MapInfoDataStore.shared.allMapsInfo[indexPath.row])        
    }
}
