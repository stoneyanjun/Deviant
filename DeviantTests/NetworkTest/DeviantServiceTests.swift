//
//  DeviantServiceTests.swift
//  DeviantTests
//
//  Created by Stone on 16/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
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
                    self.runAllServices()
                case .failure(let error):
                    print(#function + "\(error.localizedDescription)")
                    XCTAssertTrue(!error.localizedDescription.isEmpty)
                }
            }
        } else {
            self.runAllServices()
        }

        //Then
        waitForExpectations(timeout: NetworkConst.testTimeout, handler: nil)
    }

    private func runAllServices() {
//        self.fetchExpectation?.fulfill()
        fetchPopular()
        fetchDaily()
        fetchDeviantDetail()
        fetchTopicList()
        fetchTopic()
        fetchMetadata()
        fetchComment()
        fetchMoreLike()
    }

    private func fetchPopular() {
        let offset = 0
        NetworkManager<DeviantService>().networkRequest(target:
            .fetchPopular(categoryPath: "",
                          query: "",
                          timeRange: "",
                          limit: NetworkConst.limit,
                          offset: offset)) { result in
                            switch result {
                            case .success(let json):
                                let popularBase = JSONDeserializer<PopularBase>.deserializeFrom(json: json.description)
                                XCTAssertTrue((popularBase?.results?.count ?? 0) > 0)
                            case .failure(let error):
                                print(#function + "\(error.localizedDescription)")
                                XCTAssertTrue(!error.localizedDescription.isEmpty)
                            }
        }
    }

    private func fetchDaily() {
        NetworkManager<DeviantService>().networkRequest(target: .fetchDaily(date: "")) { result in
            switch result {
            case .success(let json):
                let dailyBase = JSONDeserializer<DailyBase>.deserializeFrom(json: json.description)
                XCTAssertTrue((dailyBase?.results?.count ?? 0) > 0)
            case .failure(let error):
                print(#function + "\(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
        }
    }

    private func fetchDeviantDetail() {
        NetworkManager<DeviantService>().networkRequest(target:
        .fetchDeviantDetail(deviationid: DeviantMockData.deviantId)) { result in
            switch result {
            case .success(let json):
                let deviantDetailBase = JSONDeserializer<DeviantDetailBase>.deserializeFrom(json: json.description)
                XCTAssertNotNil( deviantDetailBase?.deviationid)
            case .failure(let error):
                print(#function + "\(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
        }
    }

    private func fetchTopicList() {
        let offset = 0
        NetworkManager<DeviantService>().networkRequest(target:
            .fetchTopicList(numDeviationsPerTopic: NetworkConst.numDeviationsPerTopic,
                            limit: NetworkConst.limit,
                            offset: offset) ) { result in
                                switch result {
                                case .success(let json):
                                    let list = JSONDeserializer<TopicListBase>.deserializeFrom(json: json.description)
                                    XCTAssertTrue((list?.results?.count ?? 0) > 0)
                                case .failure(let error):
                                    print(#function + "\(error.localizedDescription)")
                                    XCTAssertTrue(!error.localizedDescription.isEmpty)
                                }
        }
    }

    private func fetchTopic() {
        let name = DeviantMockData.topicName
        let offset = 0
        NetworkManager<DeviantService>().networkRequest(target:
            .fetchTopicDetail(name: name,
                              limit: NetworkConst.limit,
                              offset: offset)) { result in
                                switch result {
                                case .success(let json):
                                    let detail = JSONDeserializer<TopicDetailBase>.deserializeFrom(json: json.description)
                                    let results = detail?.results
                                    XCTAssertTrue((results?.count ?? 0) > 0)
                                case .failure(let error):
                                    print(#function + "\(error.localizedDescription)")
                                    XCTAssertTrue(!error.localizedDescription.isEmpty)
                                }
        }
    }

    private func fetchMetadata() {
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
                print(#function + "\(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
        }
    }

    private func fetchComment() {
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
                print(#function + "\(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
        }
    }

    private func fetchMoreLike() {
        NetworkManager<DeviantService>().networkRequest(target:
        .fetchMoreLikeThisPreview(seed: DeviantMockData.deviantId)) { result in
            switch result {
            case .success(let json):
                let moreLikeThis = JSONDeserializer<MoreLikeThisPreview>.deserializeFrom(json: json.description)
            XCTAssertNotNil(moreLikeThis)
            case .failure(let error):
                print(#function + "\(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
        }
    }
}
