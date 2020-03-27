//
//  ViewController.swift
//  RxSwift-Timer
//
//  Created by Zafar on 3/27/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        sourceObservable = Observable<Int>
            .interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .map { $0 + 1 }
            .map { "\($0) seconds" }
            .bind(to: label.rx.text)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sourceObservable?.dispose()
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.textColor = .darkGray
        label.text = "Timer"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sourceObservable: Disposable?
}

