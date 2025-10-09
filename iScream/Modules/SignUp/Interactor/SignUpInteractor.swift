//
//  SignUpInteractor.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import SwiftUI

protocol SignUpInteractorProtocol: GenericInteractor { }

class SignUpInteractor: GenericInteractorImp<SignUpEntity>, SignUpInteractorProtocol { }
