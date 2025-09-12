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
    let presenter: BountyPresenter

    init() throws {
        mockUserService = MockUserService()
        router = BountyRouter()
        interactor = BountyInteractor(entity: BountyEntity(), services: [mockUserService])!
        presenter = BountyPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - Can create a child dashboard module") func testFetch() throws {
        let builder = ViperContainerBuilder()
        _ = builder.buildContainerView(
            view: BountyView.self,
            interactor: BountyInteractor.self,
            presenter: BountyPresenter.self,
            entity: BountyEntity.self,
            router: BountyRouter.self,
            services: [DefaultUserService.self])
        try #require(builder.container.resolve(BountyView.self) != nil)
        try #require(builder.container.resolve(BountyInteractor.self) != nil)
        try #require(builder.container.resolve(BountyPresenter.self) != nil)
        try #require(builder.container.resolve(BountyEntity.self) != nil)
        try #require(builder.container.resolve(BountyRouter.self) != nil)
    }
}
