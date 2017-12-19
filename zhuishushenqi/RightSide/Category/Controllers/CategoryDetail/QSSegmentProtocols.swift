//
//  QSSegmentProtocols.swift
//  zhuishushenqi
//
//  Created caonongyun on 2017/4/20.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol QSSegmentWireframeProtocol: class {
    func presentDetail(book:Book)
}
//MARK: Presenter -
protocol QSSegmentPresenterProtocol: class {
    func viewDidLoad()
    func requestMore()
    func requestData(index:Int)
    func didSelectAt(index:Int)
    func didSelectRowAt(indexPath:IndexPath)
}

//MARK: Interactor -
protocol QSSegmentInteractorProtocol: class {
    func request(index:Int)
    func requestMore()
    func showSeg()
    func showDetail(indexPath:IndexPath)
}

//MARK: Output - 
protocol QSSegmentInteractorOutputProtocol: class {
    func fetchDataSuccess(models:[Book])
    func fetchDataFailed()
    func showSeg(titles:[String])
    func showDetail(book:Book)
}

//MARK: View -
protocol QSSegmentViewProtocol: IndicatableView {

  var presenter: QSSegmentPresenterProtocol?  { get set }
    func showData(books:[Book])
    func showSeg(titles:[String])
}
