//
//  PathTraingPageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import UIKit

class PathTrainingPageViewController: UIViewController {
    
    @IBOutlet weak var mapContainerStackView: UIStackView!
    
    var viewModel: PathTrainingPageViewModel
    var coordinator: MapDetailCoordinator
    
    init(viewModel: PathTrainingPageViewModel, coordinator: MapDetailCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.initView()
        self.setupBinding()
    }
    
    func initView() {
        let drawRectanglesView = PathTrainingView()
        drawRectanglesView.rectangles = self.viewModel.getRectangleViews(in: self.view)

        self.mapContainerStackView.addArrangedSubview(drawRectanglesView)
        
    }

    func setupBinding() {
        
    }
    
}
