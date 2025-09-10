//
//  GenericView.swift
//  iScream
//
//  Created by James Woodbridge on 09/09/2025.
//

import SwiftUI

protocol GenericView: View {
    init<P>(presenter: P) where P: GenericPresenter
}
