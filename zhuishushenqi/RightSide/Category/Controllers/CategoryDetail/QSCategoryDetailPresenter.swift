//
//  QSCategoryDetailPresenter.swift
//  zhuishushenqi
//
//  Created caonongyun on 2017/4/20.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class QSCategoryDetailPresenter: QSCategoryDetailPresenterProtocol {

    weak var view: QSCategoryDetailViewProtocol?
    let interactor: QSCategoryDetailInteractorProtocol
    let router: QSCategoryDetailWireframeProtocol
    
    init(interface: QSCategoryDetailViewProtocol, interactor: QSCategoryDetailInteractorProtocol, router: QSCategoryDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func setupSegview()->[UIViewController]{
        return interactor.setupSegview()
    }
}

extension QSCategoryDetailPresenter:QSCategoryDetailInteractorOutputProtocol{
    
}

