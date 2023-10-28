//
//  OnboardingCoordinator.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import UIKit
import RxSwift
import RxRelay

enum OnboardingCoordinatorOutputEvents: Events {
    
    case needPayment
}

final class OnboardingCoordinator: ChildCoordinator {
    
    // MARK: -
    // MARK: Variables
    
    public let events = PublishRelay<OnboardingCoordinatorOutputEvents>()
    
    // MARK: -
    // MARK: Coordinator Life Cycle
    
    override func start() {
        super.start()
        
        let viewModel = OnboardingViewModel()
        let view = OnboardingView(viewModel: viewModel)
        
        viewModel.events.bind { [weak self] in
            self?.handle(events: $0)
        }
        
        self.navController.pushViewController(view, animated: true)
    }
    
    private func handle(events: OnboardingViewModelOutputEvents) {
        
    }
}
