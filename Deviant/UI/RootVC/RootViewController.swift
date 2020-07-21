//
//  RootViewController.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import HandyJSON
import UIKit

class RootViewController: UIViewController {
    private var offset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        TokenManager.shared.fetchToken { result in
            switch result {
            case .success(let token):
                print(#function + " token: \r\n\(token)")
                self.fetchPopular()

            case .failure(let error):
                print(#function +  " error  - \(error.deviantError.localizedDescription)")
            }
        }
    }
}

extension RootViewController {
    private func fetchPopular() {
        NetworkManager<PopularService>().networkRequest(target: .fetchPopular(categoryPath: "", query: "", timeRange: "", limit: NetworkConst.limit, offset: offset)) { result in
            switch result {
            case .success(let json):
                print(#function + " json\r\n \(json.description)")
                if let popularBase = JSONDeserializer<PopularBase>.deserializeFrom(json: json.description ) {
                    if let nextOffset = popularBase.nextOffset, nextOffset > self.offset {
                        self.offset = nextOffset
                    }
                    print(#function + " count: \(popularBase.results?.count ?? 0)")
                }
            case .failure(let error):
                print(#function +  " UI error  - \(error.deviantError.localizedDescription)")
            }
        }
    }
}
