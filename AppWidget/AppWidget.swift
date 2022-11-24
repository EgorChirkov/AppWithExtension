//
//  AppWidget.swift
//  AppWidget
//
//  Created by Егор Чирков on 24.11.2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct AppWidgetEntryView : View {
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack{
            
            Text("Select tab")
            
            HStack{
                if let _ = homeLinkUrl{
                    Text("Home")
                        .padding(4)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(6)
//                        .widgetURL(homeLinkUrl)
                }
                
                if let settingsLinkUrl = settingsLinkUrl{
                    Text("Settings")
                        .padding(4)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(6)
                        .widgetURL(settingsLinkUrl)
                }
            }
            .foregroundColor(.white)
            
//            Text("Statistics")
            
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var homeLinkUrl: URL?{
        URL(string: "widget-deeplink://homeapp")
    }
        
    private var settingsLinkUrl: URL?{
        URL(string: "widget-deeplink://settings.app")
    }
}

struct AppWidget: Widget {
    let kind: String = "AppWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            AppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct AppWidget_Previews: PreviewProvider {
    static var previews: some View {
        AppWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
