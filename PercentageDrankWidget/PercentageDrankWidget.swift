//
//  PercentageDrankWidget.swift
//  PercentageDrankWidget
//
//  Created by Iiro Alhonen on 15.6.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PercentageDrankWidgetContent {
        snapshotEntry
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (PercentageDrankWidgetContent) -> Void
    ) {
        print("ENTRY")
        let entry = snapshotEntry
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        print("TIMELINE")
        var entries: [PercentageDrankWidgetContent] = readContents()
        print("ENTRIES: \(entries)")
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct PercentageDrankWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        let roundedPercentage = Int(entry.percentageDrank * 100)
        ZStack {
            Text("\(roundedPercentage) %")
            ZStack {
                // Background
                Circle()
                    .stroke(Color.cyan.opacity(0.5), lineWidth: 20)
                // Progress
                Circle()
                    .trim(from: 0, to: entry.percentageDrank)
                    .stroke(Color.cyan, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
            }.padding(20)
        }
    }
}

@main
struct PercentageDrankWidget: Widget {
    let kind: String = "PercentageDrankWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PercentageDrankWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct PercentageDrankWidget_Previews: PreviewProvider {
    static var previews: some View {
        PercentageDrankWidgetEntryView(
            entry: PercentageDrankWidgetContent(
                date: Date(),
                percentageDrank: 25,
                goal: 1000,
                waterDrank: 0
            ))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

func readContents() -> [PercentageDrankWidgetContent] {
    var contents: [PercentageDrankWidgetContent] = []
    let archiveURL =
    FileManager.sharedContainerURL
        .appendingPathComponent("contents.json")
    print(">>> \(archiveURL)")

    let decoder = JSONDecoder()
    if let codeData = try? Data(contentsOf: archiveURL) {
        do {
            contents = try decoder.decode([PercentageDrankWidgetContent].self, from: codeData)
        } catch {
            print("Error: Can't decode contents")
            if let data = try? Data(contentsOf: archiveURL) {
                print("Contents: \(data.debugDescription)")
                do {
                    let item = try decoder.decode(PercentageDrankWidgetContent.self, from: codeData)
                    contents.append(item)
                } catch {
                    print("Failed")
                }
            }
        }
    }
    return contents
}
