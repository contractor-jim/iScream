//
//  ChildDashboardAchievementCell.swift
//  iScream
//
//  Created by James Woodbridge on 03/09/2025.
//

import SwiftUI

struct ChildDashboardAchievementCell: View {
    var presenter: ChildDashboardPresenter
    @State var points: [Int] = [0, 0, 0, 0]
    // TODO: This needs to come from the model
    let actualPoints: [Int] = [0, 2, 4, 12]

    var body: some View {
        VStack(alignment: .leading) {
            Text("general.title.achievements")
                .padding(Style.halfPadding)

            HStack(alignment: .center) {
                ChildDashboardAchievementLabel(points: points[0])
                    .foregroundStyle( PlatinumShapeStyle() )
                    .accessibilityIdentifier("child-dashboard-achievement-cell-midnight")

                Spacer()

                ChildDashboardAchievementLabel(points: points[1])
                    .foregroundStyle( GoldShapeStyle() )
                    .accessibilityIdentifier("child-dashboard-achievement-cell-gold")

                Spacer()

                ChildDashboardAchievementLabel(points: points[2])
                    .foregroundStyle( SilverShapeStyle() )
                    .accessibilityIdentifier("child-dashboard-achievement-cell-silver")

                Spacer()

                ChildDashboardAchievementLabel(points: points[3])
                    .foregroundStyle( BronzeShapeStyle() )
                    .accessibilityIdentifier("child-dashboard-achievement-cell-bronze")
            }
            .padding(0)
            .padding(.bottom, Style.halfPadding)
        }
        .onAppear {
            for i in 0..<actualPoints.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Style.animationDelay) {
                    withAnimation(.easeIn.delay(Double(i) * Style.animationDuration)) {
                        points = actualPoints.map { $0 }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .padding(Style.fullPadding)
        .background(Color.cellBackground)
        .foregroundColor(Color.white)
        .cornerRadius(Style.cornerRadius)
    }
}

struct PlatinumShapeStyle: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.357, green: 0.349, blue: 0.870, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.356, green: 0.348, blue: 0.870, alpha: 1)), location: 0.3),
                .init(color: Color(#colorLiteral(red: 0.776, green: 0.266, blue: 0.988, alpha: 1)), location: 1)
            ]),
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
    }
}

struct GoldShapeStyle: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.5215686275, green: 0.4156862745, blue: 0, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.7607843137, green: 0.6901960784, blue: 0.4039215686, alpha: 1)), location: 0.62),
                .init(color: Color(#colorLiteral(red: 0.937254902, green: 0.7490196078, blue: 0.01568627451, alpha: 1)), location: 1)
            ]),
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
    }
}

struct SilverShapeStyle: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)), location: 0.3),
                .init(color: Color(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)), location: 1)
            ]),
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
    }
}

struct BronzeShapeStyle: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.5098039216, green: 0.3411764706, blue: 0.1725490196, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.8078431373, green: 0.537254902, blue: 0.2745098039, alpha: 1)), location: 0.62),
                .init(color: Color(#colorLiteral(red: 0.9882352941, green: 0.662745098, blue: 0.337254902, alpha: 1)), location: 1)
            ]),
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
    }
}

struct ChildDashboardAchievementLabel: View {
    var points: Int

    var body: some View {
        Image(systemName: "trophy.fill")

        AnimatedNumberTextView(points) { value in
            Text("\(value)")
                .foregroundColor(Color.white)
        }
    }
}
