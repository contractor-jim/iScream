//
//  LoginInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 06/10/2025.
//

import SwiftUI

protocol LoginInteractorProtocol: GenericInteractor { }

class LoginInteractor: GenericInteractorImp<LoginEntity>, LoginInteractorProtocol { }
