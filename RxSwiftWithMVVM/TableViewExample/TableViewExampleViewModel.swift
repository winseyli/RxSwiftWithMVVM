//
//  TableViewExampleViewModel.swift
//  RxSwiftWithMVVM
//
//  Created by Winsey Li on 19/5/2018.
//  Copyright © 2018 winseyli.nz. All rights reserved.
//

import RxSwift
import RxCocoa

class TableViewExampleViewModel {

    let isLoading: Driver<Bool>
    let stringData: Driver<[Post]>
    let isError: Driver<Bool>
    
    private enum DataEvent {
        case loading
        case data([Post])
        case error
    }
    
    init(dataService: DataService, refreshDriver: Driver<Void>) {
        let eventDriver = refreshDriver
            .startWith(())
            .flatMapLatest { _ -> Driver<DataEvent> in
                return dataService.fetchData()
                    .map { .data($0) }
                    .asDriver(onErrorJustReturn: .error)
                    .startWith(.loading)
        }
        
        // ==========================================================
        // If you do not need a refresh button, you can initalize the
        // event driver directly as followed.
        // ==========================================================
        /*
        let eventDriver: Driver<DataEvent> = dataService.fetchData()
            .map { .data($0) }
            .asDriver(onErrorJustReturn: .error)
            .startWith(.loading)
         */
    
        isLoading = eventDriver
            .map { event in
                switch event {
                case .loading: return true
                default: return false
                }
        }
        
        stringData = eventDriver
            .map { event in
                switch event {
                case .data(let data): return data
                default: return []
                }
        }
        
        isError = eventDriver
            .map { event in
                switch event {
                case .error: return true
                default: return false
                }
        }
    }
}
