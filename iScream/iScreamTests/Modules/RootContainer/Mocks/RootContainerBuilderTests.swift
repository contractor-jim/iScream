//
//  RootContainerBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import Testing
@testable import iScream

struct RootContainerBuilderTests {

    var mockService: MockUserService
    let router: MockRootContainerRouter
    let interactor: MockRootContainerInteractor
    let presenter: RootContainerPresenterImp

    init() throws {
        mockService = MockUserService()
        router = MockRootContainerRouter()
        interactor = MockRootContainerInteractor(entity: MockRootContainerEntity(), userService: mockService)
        presenter = RootContainerPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - Can create a new Root COntainer module") func testFetch() throws {
        let builder = RootContainerDefaultBuilder()
        let _ = builder.buildRootContainerView()
        try #require(builder.container.resolve(RootContainerEntity.self) != nil)
        try #require(builder.container.resolve(RootContainerInteractor.self) != nil)
        try #require(builder.container.resolve(RootContainerRouter.self) != nil)
        try #require(builder.container.resolve(RootContainerPresenter.self) != nil)
        try #require(builder.container.resolve(RootContainerView.self) != nil)
        // TODO: When the opaque / boxing of the views look at this
//        try #require(testView as? RootContainerView != nil)
    }
}
