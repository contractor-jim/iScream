//
//  RootContainerBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct RootContainerBuilderTests {

    var mockService: MockUserService
    let router: MockRootContainerRouter
    let interactor: MockRootContainerInteractor
    let presenter: RootContainerPresenter

    init() throws {
        mockService = MockUserService()
        router = MockRootContainerRouter()
        interactor = MockRootContainerInteractor(entity: MockRootContainerEntity(), services: [mockService])!
        presenter = RootContainerPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - Can create a new Root COntainer module") func testFetch() throws {
        let builder = ViperContainerBuilder()
        let view = builder.buildContainerView(
            view: RootContainerView.self,
            interactor: RootContainerInteractor.self,
            presenter: RootContainerPresenter.self,
            entity: RootContainerEntity.self,
            router: RootContainerRouter.self,
            services: [DefaultUserService.self])
        try #require(builder.container.resolve(RootContainerEntity.self) != nil)
        try #require(builder.container.resolve(RootContainerInteractor.self) != nil)
        try #require(builder.container.resolve(RootContainerRouter.self) != nil)
        try #require(builder.container.resolve(RootContainerPresenter.self) != nil)
        try #require(builder.container.resolve(RootContainerView.self) != nil)
    }
}
