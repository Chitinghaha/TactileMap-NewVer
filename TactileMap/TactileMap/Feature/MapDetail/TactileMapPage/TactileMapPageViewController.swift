//
//  TactileMapPageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import UIKit

class TactileMapPageViewController: UIViewController {

    @IBOutlet weak var mapContainerStackView: UIStackView!
    let stackViewHeight = [40,15,45]
    
    var viewModel: TactileMapPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let drawRectanglesView = DrawRectanglesView()
    
        self.mapContainerStackView.addArrangedSubview(drawRectanglesView)
        
        var rectangles: [TactileMapGridCellView] = []
        
        let gridModels = TactileMapGridViewModel.shared.getGridModels(mapName: self.viewModel.mapInfo.title)
        
        gridModels.forEach {
            let frame = CGRect(x: $0.x * self.view.frame.width, y: $0.y * self.view.frame.height, width: $0.width * self.view.frame.width, height: $0.height * self.view.frame.height)
            let view = TactileMapGridCellView(frameRect: frame, color: UIColor(hex: $0.color), name: $0.name)
            rectangles.append(view)
        }
        
        drawRectanglesView.rectangles = rectangles
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
