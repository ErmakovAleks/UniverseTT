//
//  ChildCoordinator.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import UIKit
import RxSwift

public class ChildCoordinator: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    public var navController = UINavigationController()
    public let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    // MARK: -
    // MARK: Overriding
    
    func start() {}
}
