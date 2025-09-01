//
//  BountyDefaultBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

import Testing
@testable import iScream

struct BountyDefaultBuilderTests {

    var mockUserService: MockUserService
    let router: BountyRouter
    let interactor: BountyInteractor
    let presenter: BountyPresenterImp

    init() throws {
        mockUserService = MockUserService()
        router = BountyRouterImp()
        interactor = BountyInteractorImp(entity: BountyEntityImp(), userService: mockUserService)
        presenter = BountyPresenterImp(interactor: interactor, router: router)
    }

    @Test("POSITIVE - Can create a child dashboard module") func testFetch() throws {
        let builder = BountyDefaultBuilder()
        let _ = builder.buildBountyView()
        try #require(builder.container.resolve(BountyEntity.self) != nil)
        try #require(builder.container.resolve(BountyInteractor.self) != nil)
        try #require(builder.container.resolve(BountyRouter.self) != nil)
        try #require(builder.container.resolve(BountyPresenter.self) != nil)
        try #require(builder.container.resolve(BountyView.self) != nil)
        // TODO: When the opaque / boxing of the views look at this
//        try #require(testView as? RootContainerView != nil)
    }
}
