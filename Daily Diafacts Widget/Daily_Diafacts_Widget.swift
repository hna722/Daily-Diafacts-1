//
//  Daily_Diafacts_Widget.swift
//  Daily Diafacts Widget
//
//  Created by Hannah Na on 12/15/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), fact: "Loading...")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let fact = FactManager.shared.getDailyFact()
        let entry = SimpleEntry(date: Date(), fact: fact)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let fact = FactManager.shared.getDailyFact()
        let currentDate = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate

        let entry = SimpleEntry(date: currentDate, fact: fact)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let fact: String
}

struct Daily_Diafacts_WidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack{
            Text("Diabetes Fact of the Day!")
                .font(.custom("Megan Beauty", size: 16))
                .multilineTextAlignment(.center)
            
            Spacer()

            Text(entry.fact)
                .font(.custom("AppleGaramond", size: 16))
                    .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
        //.background(.ultraThinMaterial)
        
    }
}

struct Daily_Diafacts_Widget: Widget {
    let kind: String = "Daily_Diafacts_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Daily_Diafacts_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Fact Widget")
        .description("Displays a new fact every day.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    Daily_Diafacts_Widget()
} timeline: {
    SimpleEntry(date: .now, fact: "Preview fact for testing purposes.")
}
