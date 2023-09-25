//
//  PathTraingPageViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import UIKit
import Combine

class PathTrainingPageViewController: UIViewController {
    
    @IBOutlet weak var mapContainerStackView: UIStackView!
    
    var viewModel: PathTrainingPageViewModel
    var coordinator: MapDetailCoordinator
    var pathTrainingView: PathTrainingView = PathTrainingView()
    
    private var cancellables = Set<AnyCancellable>()
    
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
    }

    override func viewDidAppear(_ animated: Bool) {
        self.initView()
        self.setupBinding()
    }
    
    func initView() {
        self.pathTrainingView.gridViews = self.viewModel.getRectangleViews(in: self.mapContainerStackView)

        self.mapContainerStackView.addArrangedSubview(self.pathTrainingView)
        
    }

    func startTraining(start: String, end: String) {
        self.pathTrainingView.prepairTraining(start: start, end: end)
    }
    
    func setupBinding() {
        self.pathTrainingView.$isTraining
            .removeDuplicates()
            .sink { [weak self] isTraining in
                guard let self = self else { return }
                if (!isTraining) {
                    self.coordinator.clearSideMenuPath()
                }
            }
            .store(in: &self.cancellables)
    }
    
}
