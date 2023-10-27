//
//  BaseViewModel.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import Foundation

import RxSwift
import RxCocoa

public enum SpinnerAction {
    
    case start
    case stop
}

public class BaseViewModel<OutputEventsType: Events>: NetworkServiceContainable {
    
    //MARK: -
    //MARK: Variables
    
    public var events: Observable<OutputEventsType> {
        return self.outputEventsEmiter.asObservable()
    }
    
    public let disposeBag = DisposeBag()
    
    internal var spinnerHandler: ((SpinnerAction) -> ())?
    
    internal let outputEventsEmiter = PublishRelay<OutputEventsType>()
    
    //MARK: -
    //MARK: Initializations
    
    public init() {
        self.prepareBindings(bag: self.disposeBag)
    }

    //MARK: -
    //MARK: Overriding

    func prepareBindings(bag: DisposeBag) {
        
    }
    
    func viewDidLoaded() {
        
    }
}
