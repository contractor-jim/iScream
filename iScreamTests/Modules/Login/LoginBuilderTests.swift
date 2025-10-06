//
//  LoginBuilderTests.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

@testable import iScream
import Testing

struct LoginBuilderTests {

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

    @Test("POSITIVE - Can create a new Login Container module") func testFetch() throws {
        let builder = ViperContainerBuilder()
        _ = builder.buildContainerView(
            view: LoginView.self,
            interactor: LoginInteractor.self,
            presenter: LoginPresenter.self,
            entity: LoginEntity.self,
            router: LoginRouter.self,
            services: [DefaultUserService.self])
        try #require(builder.container.resolve(LoginEntity.self) != nil)
        try #require(builder.container.resolve(LoginInteractor.self) != nil)
        try #require(builder.container.resolve(LoginRouter.self) != nil)
        try #require(builder.container.resolve(LoginPresenter.self) != nil)
        try #require(builder.container.resolve(LoginView.self) != nil)
    }
}
