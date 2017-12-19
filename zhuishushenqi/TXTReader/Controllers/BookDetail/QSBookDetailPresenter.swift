//
//  QSBookDetailPresenter.swift
//  zhuishushenqi
//
//  Created Nory Cao on 2017/4/13.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class QSBookDetailPresenter: QSBookDetailPresenterProtocol {

    weak var view: QSBookDetailViewProtocol?
    let interactor: QSBookDetailInteractorProtocol
    let router: QSBookDetailWireframeProtocol

    var ranks:[BookComment] = []
    var show:Bool = false
    
    init(interface: QSBookDetailViewProtocol, interactor: QSBookDetailInteractorProtocol, router: QSBookDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad(id: String) {
        interactor.requestData(id: id)
        view?.showActivityView()
    }
    
    func didClickReadingBtn(model:BookDetail,select:Bool){
        view?.showActivityView()
        let allChapterUrl = "\(BASEURL)/toc"
        interactor.requestAllChapters(withUrl: allChapterUrl,param:["view":"summary","book":model._id ])
    }
    
    func didClickPersueBtn(model:BookDetail,select:Bool){
        //需要遍历删除
        if select == true {
            BookManager.updateShelf(with: model, type: .add,refresh:true)
        }else{
            BookManager.updateShelf(with: model, type: .delete,refresh:true)
        }
        QSLog(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
    }
    
    func didClickCacheAll(){
        
    }
    
    func didSelectRow(indexPath:IndexPath){
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                self.show = !self.show
                fetchContent(show: self.show)
            }
        }
        if indexPath.section == 1 {
            router.presentComment(model: ranks[indexPath.row])
        }else if indexPath.section == 2 {
            interactor.showCommunity()
        }else if indexPath.section == 4{
            interactor.showTopic(index: indexPath.row)
        }
    }
    
    func didClickRecBtn(btn:UIButton){
        let tag = btn.tag - RecBtnTag
        interactor.showBookDetail(tag: tag)
    }
}

extension QSBookDetailPresenter:QSBookDetailInteractorOutputProtocol{
    func fetchBookSuccess(bookDetail:BookDetail,ranks:[BookComment]){
        self.ranks = ranks
        view?.hideActivityView()
        view?.showResult(bookDetail: bookDetail, comment: ranks)
        interactor.requestRecommend()
        interactor.requestRecList()
    }
    
    func fetchRankFailed() {
        view?.hideActivityView()
    }
    
    func fetchContent(show: Bool) {
        view?.showContent(show: show)
    }
    
    func fetchAllChapterSuccess(bookDetail:BookDetail,res:[ResourceModel]){
        view?.hideActivityView()
        router.presentReading(model: res, booDetail: bookDetail)
    }
    
    func fetchAllChapterFailed(){
        view?.hideActivityView()
    }
    
    func fetchRecommendSuccess(books: [Book]) {
        view?.hideActivityView()
        view?.showRecommend(list: books)
    }
    
    func fetchRecommendFailed() {
        view?.hideActivityView()
    }
    
    func fetchRecBookSuccess(books: [QSBookList]) {
        view?.hideActivityView()
        view?.showRecBookList(list: books)
    }
    
    func fetchRecBookFailed() {
        view?.hideActivityView()
    }
    
    func showTopic(model:QSBookList){
        router.presentTopic(model: model)
    }
    
    func showBookDetail(model: Book) {
        router.presentSelf(model: model)
    }
    
    func showCommunity(model: BookDetail) {
        router.presentCommunity(model: model)
    }
    
    func showInterestedView(recList:[Book]){
        router.presentInterestedView(recList: recList)
    }

}
