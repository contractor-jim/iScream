//
//  ParentListChildrenBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 01/09/2025.
//

@testable import iScream
import Testing

struct ParentListChildrenBuilderTests {

    var mockUserService: MockUserService
    let router: ParentListChildrenRouter
    let interactor: ParentListChildrenInteractor
    let presenter: ParentListChildrenPresenter

    init() throws {
        mockUserService = MockUserService()
        router = ParentListChildrenRouter()
        interactor = ParentListChildrenInteractor(entity: ParentListChildrenEntity(), services: [mockUserService])!
        presenter = ParentListChildrenPresenter(interactor: interactor, router: router)!
    }

    @Test("POSITIVE - Can create a new parent list children module") func testFetch() throws {
        let builder = ViperContainerBuilder()
        _ = builder.buildContainerView(
            view: ParentListChildrenView.self,
            interactor: ParentListChildrenInteractor.self,
            presenter: ParentListChildrenPresenter.self,
            entity: ParentListChildrenEntity.self,
            router: ParentListChildrenRouter.self,
            services: [DefaultUserService.self])
        try #require(builder.container.resolve(ParentListChildrenEntity.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenInteractor.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenRouter.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenPresenter.self) != nil)
        try #require(builder.container.resolve(ParentListChildrenView.self) != nil)
    }
}
