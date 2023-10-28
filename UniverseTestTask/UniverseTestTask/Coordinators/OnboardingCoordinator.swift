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
        .disposed(by: self.disposeBag)
        
        self.navController.pushViewController(view, animated: true)
    }
    
    // MARK: -
    // MARK: Handling Internal Flow Navigation
    
    private func handle(events: OnboardingViewModelOutputEvents) {
        switch events {
        case .termsOfUse:
            self.navController.present(termsOfUse(), animated: true)
        case .privacyPolicy:
            self.navController.present(privacyPolicy(), animated: true)
        case .subscriptionTerms:
            self.navController.present(subscriptionTerms(), animated: true)
        }
    }
    
    private func termsOfUse() -> TermsOfUseView {
        let viewModel = TermsOfUseViewModel()
        let view = TermsOfUseView(viewModel: viewModel)
        
        viewModel.events.bind {
            self.handle(events: $0)
        }
        .disposed(by: self.disposeBag)
        
        return view
    }
    
    private func handle(events: TermsOfUseViewModelOutputEvents) {
        
    }
    
    private func privacyPolicy() -> PrivacyPolicyView {
        let viewModel = PrivacyPolicyViewModel()
        let view = PrivacyPolicyView(viewModel: viewModel)
        
        viewModel.events.bind {
            self.handle(events: $0)
        }
        .disposed(by: self.disposeBag)
        
        return view
    }
    
    private func handle(events: PrivacyPolicyViewModelOutputEvents) {
        
    }
    
    private func subscriptionTerms() -> SubscriptionTermsView {
        let viewModel = SubscriptionTermsViewModel()
        let view = SubscriptionTermsView(viewModel: viewModel)
        
        viewModel.events.bind {
            self.handle(events: $0)
        }
        .disposed(by: self.disposeBag)
        
        return view
    }
    
    private func handle(events: SubscriptionTermsViewModelOutputEvents) {
        
    }
}
