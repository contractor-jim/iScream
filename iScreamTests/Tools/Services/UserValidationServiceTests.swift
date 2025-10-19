//
//  UserValidationServiceTests.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

@testable import iScream
import Testing

struct UserValidationServiceTests {
    @Test("POSITIVE - UserValidation - testEmailValidation",
          arguments: [
            (email: "",
             result: "Missing Email"),

            (email: "flobbyDobby",
             result: "Invalid Email"),

            (email: "test@test.com",
             result: "")
    ])
    func testEmailValidation_ReturnsCountOf3(
        email: String,
        result: String
    ) async throws {
        #expect(DefaultUserValidationService().isValidEmail(email: email) == result)
    }
    // TODO: The password does not actually work correctly with the special chars wait till we integrate the Auth component
    @Test("POSITIVE - UserValidation - testPasswordValidation",
          arguments: [
            (password: "",
             result: "Missing Password"),

            (password: "flobbyDobby",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"),

            (password: "12343",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"),

            (password: "*£$£@$£$@£",
             result: "Invalid Password password must be 8 characters long, contain one uppercase and one lowercase character. And one special character ( #?!@$%^&*-_ )"),

            (password: "*ValidPassword1_",
             result: "")
    ])
    func testEmailValidation_ReturnsCountOf3(
        password: String,
        result: String
    ) async throws {
        #expect(DefaultUserValidationService().isValidPassword(password: password) == result)
    }

    @Test("POSITIVE - UserValidation - testSignUpNicknameValidation",
          arguments: [
            (nickname: "",
             result: "Missing Nickname"),

            (nickname: "a",
             result: "Invalid Nickname: A-Z, 2 to 15 charachters long"),

            (nickname: "*£$£VBD$£$@£",
             result: "Invalid Nickname: A-Z, 2 to 15 charachters long"),

            (nickname: "Alan",
             result: ""),

            (nickname: "alan",
             result: "")
    ])
    func testEmailValidation(
        nickname: String,
        result: String
    ) async throws {
        #expect(DefaultUserValidationService().isValidNickName(userName: nickname) == result)
    }
}
