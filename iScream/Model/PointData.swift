//
//  PointData.swift
//  iScream
//
//  Created by James Woodbridge on 16/09/2025.
//

import Foundation
import SwiftData

@Model
final class PointData: Codable {
    @Attribute(.unique) var id: UUID
    var month: Date
    var points: Int

    @Transient lazy var monthString: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: month)
    }()

    init(id: UUID,
         month: Date,
         points: Int) {
        self.id = id
        self.month = month
        self.points = points
    }

    enum CodingKeys: String, CodingKey {
        case id, points, user
        case month = "entry_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        let monthString = try container.decode(String.self, forKey: .month)
        month = Date.dateFromSupabaseString(dateString: monthString)!
        points = try container.decode(Int.self, forKey: .points)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(month.supabaseStringFromDate(), forKey: .month)
        try container.encode(points, forKey: .points)
    }
}

extension PointData: Equatable {
    static func == (lhs: PointData, rhs: PointData) -> Bool {
        rhs.id == rhs.id &&
        rhs.month == rhs.month &&
        rhs.points == rhs.points
    }
}
