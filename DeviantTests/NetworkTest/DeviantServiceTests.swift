//
//  DeviantServiceTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import HandyJSON
import SwiftyJSON
import XCTest

class DeviantServiceTests: XCTestCase {
    var fetchExpectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
    }

    func testServices () {
        //Given
        fetchExpectation = self.expectation(description: "Waiting on test services")

        //When
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    print(#function + " success")
                    self.runAllServices()
                case .failure(let error):
                    print(#function + " error \(error.localizedDescription)")
                    XCTAssertTrue(!error.localizedDescription.isEmpty)
                    self.fetchExpectation?.fulfill()
                }
            }
        } else {
            self.runAllServices()
        }

        //Then
        waitForExpectations(timeout: NetworkConst.testTimeout, handler: nil)
    }

    private func runAllServices() {
        print(#function + " begin")
        let group = DispatchGroup()

        group.enter()
        fetchPopular {
            group.leave()
        }

        group.enter()
        fetchDaily {
            group.leave()
        }

        group.enter()
        fetchDeviantDetail {
            group.leave()
        }

        group.enter()
        fetchTopicList {
            group.leave()
        }

        group.enter()
        fetchTopic {
            group.leave()
        }

        group.enter()
        fetchMetadata {
            group.leave()
        }

        group.enter()
        fetchComment {
            group.leave()
        }

        group.enter()
        fetchMoreLike {
            group.leave()
        }

        group.enter()
        fetchWhoFavorate {
            group.leave()
        }

        group.notify(queue: .main) {
            [weak self] in
            guard let self = self else { return }
            print(#function, " group.notify ")
            self.fetchExpectation?.fulfill()
        }
    }

    private func fetchPopular(completion: (() -> Void)?) {
        let offset = 0
        NetworkManager<DeviantService>().networkRequest(target:
            .fetchPopular(params: PopularParams(categoryPath: "",
                                                query: "",
                                                timeRange: "",
                                                limit: NetworkConst.limit,
                                                offset: offset))) { result in
                            switch result {
                            case .success(let json):
                                let popularBase = JSONDeserializer<PopularBase>.deserializeFrom(json: json.description)
                                XCTAssertTrue((popularBase?.results?.count ?? 0) > 0)
                            case .failure(let error):
                                print(#function + " error \(error.localizedDescription)")
                                XCTAssertTrue(!error.localizedDescription.isEmpty)
                            }
                            completion?()
        }
    }

    private func fetchDaily(completion: (() -> Void)?) {
        NetworkManager<DeviantService>().networkRequest(target: .fetchDaily(date: "")) { result in
            switch result {
            case .success(let json):
                let dailyBase = JSONDeserializer<DailyBase>.deserializeFrom(json: json.description)
                XCTAssertTrue((dailyBase?.results?.count ?? 0) > 0)
            case .failure(let error):
                print(#function + " error \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
            completion?()
        }
    }

    private func fetchDeviantDetail(completion: (() -> Void)?) {
        NetworkManager<DeviantService>().networkRequest(target:
        .fetchDeviantDetail(deviationid: DeviantMockData.deviantId)) { result in
            switch result {
            case .success(let json):
                let deviantDetailBase = JSONDeserializer<DeviantDetailBase>.deserializeFrom(json: json.description)
                XCTAssertNotNil( deviantDetailBase?.deviationid)
            case .failure(let error):
                print(#function + " error \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
            completion?()
        }
    }

    private func fetchTopicList(completion: (() -> Void)?) {
        let params = TopicListParams(numDeviationsPerTopic: NetworkConst.numDeviationsPerTopic,
                                     limit: NetworkConst.limit,
                                     offset: 0)

        NetworkManager<DeviantService>().networkRequest(target:
            .fetchTopicList(params: params) ) { result in
                                switch result {
                                case .success(let json):
                                    let list = JSONDeserializer<TopicListBase>.deserializeFrom(json: json.description)
                                    XCTAssertTrue((list?.results?.count ?? 0) > 0)
                                case .failure(let error):
                                    print(#function + " error \(error.localizedDescription)")
                                    XCTAssertTrue(!error.localizedDescription.isEmpty)
                                }
                                completion?()
        }
    }

    private func fetchTopic(completion: (() -> Void)?) {
        let params = TopicDetailParams(name: DeviantMockData.topicName,
                                       limit: NetworkConst.limit,
                                       offset: 0)
        NetworkManager<DeviantService>().networkRequest(target:
            .fetchTopicDetail(params: params)) { result in
                                switch result {
                                case .success(let json):
                                    let detail = JSONDeserializer<TopicDetailBase>.deserializeFrom(json: json.description)
                                    let results = detail?.results
                                    XCTAssertTrue((results?.count ?? 0) > 0)
                                case .failure(let error):
                                    print(#function + " error \(error.localizedDescription)")
                                    XCTAssertTrue(!error.localizedDescription.isEmpty)
                                }
                                completion?()
        }
    }

    private func fetchMetadata(completion: (() -> Void)?) {
        let params = MetadataParams(deviationids: [DeviantMockData.deviantId],
                                    extSubmission: true,
                                    extCamera: true,
                                    extStats: true,
                                    extCollection: false)
        NetworkManager<DeviantService>().networkRequest(target: .fetchMetadata(params: params)) { result in
            switch result {
            case .success(let json):
                let metadataBase = JSONDeserializer<MetadataBase>.deserializeFrom(json: json.description)
                let results = metadataBase?.metadata
                XCTAssertTrue((results?.count ?? 0) > 0)
            case .failure(let error):
                print(#function + " error \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
            completion?()
        }
    }

    private func fetchComment(completion: (() -> Void)?) {
        let offset = 0
        let params = CommentParams(deviationid: DeviantMockData.deviantId,
                                   commentid: nil,
                                   maxdepth: nil,
                                   offset: offset,
                                   limit: NetworkConst.limit)

        NetworkManager<DeviantService>().networkRequest(target: .   fetchComment(params: params)) { result in
            switch result {
            case .success(let json):
                let comment = JSONDeserializer<CommentBase>.deserializeFrom(json: json.description)
                let results = comment?.thread
                XCTAssertTrue((results?.count ?? 0) > 0)
            case .failure(let error):
                print(#function + " error \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
            completion?()
        }
    }

    private func fetchMoreLike(completion: (() -> Void)?) {
        NetworkManager<DeviantService>().networkRequest(target:
        .fetchMoreLikeThisPreview(seed: DeviantMockData.deviantId)) { result in
            switch result {
            case .success(let json):
                let moreLikeThis = JSONDeserializer<MoreLikeThisPreview>.deserializeFrom(json: json.description)
            XCTAssertNotNil(moreLikeThis)
            case .failure(let error):
                print(#function + " error \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
            completion?()
        }
    }

    private func fetchWhoFavorate(completion: (() -> Void)?) {
        let offset = 0
        let params = WhoFavedParams(deviationid: DeviantMockData.deviantId,
                                    limit: NetworkConst.limit,
                                    offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .   whoFaved(params: params)) { result in
            switch result {
            case .success(let json):
                let favorateBase = JSONDeserializer<WhoFavorateBase>.deserializeFrom(json: json.description)

                XCTAssertTrue((favorateBase?.results?.count ?? 0) > 0)
            case .failure(let error):
                print(#function + " error \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
            completion?()
        }
    }
}
