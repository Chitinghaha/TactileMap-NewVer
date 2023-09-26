//
//  MapDetailSideMenuViewModel.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import DropDown
import Combine


enum SideMenuContentPosition {
    case tactileMap
    case pathTraining
}

class MapDetailSideMenuViewModel {
    var dropDown = DropDown()
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var currentMap: Map
    var mapPoints: [String] = []
    
    @Published var currentStartPoint: String = "請選擇"
    @Published var currentEndPoint: String = "請選擇"
    
    @Published var menuPosition: SideMenuContentPosition = .tactileMap
    
    var coordinator: MapDetailCoordinator
    var pathTrainingPageViewController: PathTrainingPageViewController?
    
    init(coodinator: MapDetailCoordinator, currentMap: Map) {
        self.coordinator = coodinator
        self.currentMap = currentMap
        
        self.setupBinding()
        
        self.dropDown.textFont = UIFont.systemFont(ofSize: 24)
        self.dropDown.cornerRadius = 8
    }
    
    func onclickGoBackButton() {
        self.coordinator.goToTactileMapPage()
        self.menuPosition = .tactileMap
        self.currentStartPoint = "請選擇"
        self.currentEndPoint = "請選擇"
    }
    
    func onClickGoToHomePageButton() {
        self.coordinator.goToHomePage()
    }
    
    func onclickAllMapTableCell(map: Map) {
        if (self.currentMap != map) {
            self.currentMap = map
            self.coordinator.changeTactileMapPage(with: map)
        }
    }
    
    func onclickEnterPathPageButton() {
        self.coordinator.goToPathTrainingPage(with: self.currentMap)
        self.menuPosition = .pathTraining
    }
    
    func onClickSelectStartPoint(_ sender: UIButton) {
        self.dropDown.dataSource = self.mapPoints
        self.dropDown.anchorView = sender
        self.dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.minY - 100)
        self.dropDown.show()
        self.dropDown.selectionAction = { [self] (index : Int, item : String) in
            print(index,item)
            self.currentStartPoint = item
        }
    }
    
    func onClickSelectEndPoint(_ sender: UIButton) {
        self.dropDown.anchorView = sender
        self.dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.minY - 300)
        self.dropDown.show()
        self.dropDown.selectionAction = { [self] (index : Int, item : String) in
            print(index,item)
            self.currentEndPoint = item
        }
    }
    
    func onclickConfirmPathButton() {
        if (self.currentStartPoint == "請選擇" || self.currentEndPoint == "請選擇") {
            self.coordinator.showAlert(message: "起點或終點不能為空")
            return
        }
        
        if let pathTrainingPageViewController = self.pathTrainingPageViewController {
            pathTrainingPageViewController.startTraining(start: self.currentStartPoint, end: self.currentEndPoint)
            self.coordinator.hideSideMenu()
        }
    }
}

extension MapDetailSideMenuViewModel {
    func setupBinding() {
        self.$currentMap
            .sink{ [weak self] map in
                guard let self = self else { return }
                
                self.mapPoints = TactileMapGridViewModel.shared.getGridModels(mapName: map.title)
                    .map { $0.name }
                    .filter {
                        !$0.contains("走道")
                    }
            }
            .store(in: &cancellable)
    }
}
