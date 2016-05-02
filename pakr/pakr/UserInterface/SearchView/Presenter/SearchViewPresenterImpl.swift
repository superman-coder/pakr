//
//  SearchViewPresenterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/2/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class SearchViewPresenterImpl: NSObject, SearchViewPresenter {
    
    weak var view: SearchView!
    let model: SearchViewModel
    let tracker: SearchViewTracker
    let adapter: SearchViewAdapter
    
    init(view: SearchView, model: SearchViewModel, adapter: SearchViewAdapter, tracker: SearchViewTracker) {
        self.view = view
        self.model = model
        self.tracker = tracker
        self.adapter = adapter
        
        super.init()
    }
}