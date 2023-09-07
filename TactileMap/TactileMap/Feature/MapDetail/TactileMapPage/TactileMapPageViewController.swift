//
//  TactileMapPageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import UIKit

class TactileMapPageViewController: UIViewController {

    @IBOutlet weak var mapContainerStackView: UIStackView!
    
    var viewModel: TactileMapPageViewModel
    var coordinator: MapDetailCoordinator
    
    init(viewModel: TactileMapPageViewModel!, coordinator: MapDetailCoordinator!) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.initView()
        self.viewModel.viewDidAppear()
    }

    func initView() {
        self.view.backgroundColor = .black
        
        let drawRectanglesView = TouchMapView()
        drawRectanglesView.rectangles = self.viewModel.getRectangleViews(in: self.mapContainerStackView)
        drawRectanglesView.backgroundColor = .clear
        
        self.mapContainerStackView.addArrangedSubview(drawRectanglesView)
    }
}
