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
    
    var allMapInfo: [SingleMapInfoModel]
    var currentMap: SingleMapInfoModel
    var mapPoints: [String]
    
    @Published var currentStartPoint: String = "請選擇"
    @Published var currentEndPoint: String = "請選擇"
    
    @Published var menuPosition: SideMenuContentPosition = .tactileMap
    
    var coodinator: MapDetailCoordinator
    var pathTrainingViewModel: PathTrainingPageViewModel?
    
    init(coodinator: MapDetailCoordinator, currentMap: SingleMapInfoModel) {
        self.coodinator = coodinator
        self.currentMap = currentMap
        self.allMapInfo = MapInfosViewModel.shared.allMapsInfo
        self.mapPoints = TactileMapGridViewModel.shared.getGridModels(mapName: currentMap.title)
            .map { $0.name }
            .sorted(by: { str1, str2 in
                if (str1.contains("入口")) {
                    if (str2.contains("入口")) {
                        return str1 > str2
                    }
                    return true
                }
                else if (str2.contains("入口")) {
                    return false
                }
                else {
                    return str1 > str2
                }
            })
        
        self.dropDown.textFont = UIFont.systemFont(ofSize: 24)
        self.dropDown.cornerRadius = 8
    }
    
    func onclickGoBackButton() {
        self.coodinator.goToTactileMapPage()
        self.menuPosition = .tactileMap
    }
    
    func onClickGoToHomePageButton() {
        self.coodinator.goToHomePage()
    }
    
    func onclickEnterPathPageButton() {
        self.coodinator.goToPathTrainingPage(with: self.currentMap)
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
            self.coodinator.showAlert(message: "起點或終點不能為空")
            return
        }
        
        if let pathTrainingViewModel = self.pathTrainingViewModel {
            pathTrainingViewModel.startTraining(start: self.currentStartPoint, end: self.currentEndPoint)
        }
    }
}
