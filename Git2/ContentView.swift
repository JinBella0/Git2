//
//  ContentView.swift
//  Git2
//
//  Created by 이진경 on 4/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        
        NavigationSplitView {
            List {
                Text("Hello")
                Text("Hello")
                Text("Hello")
                Text("Hello")
                Text("벨라 휴가중인데 이만큼 해쏘 ㅠㅠㅠ 왜 안나왕 ㅏ앙 ㅇㄴㅇㄹ나오란알")
                Text("혜정님 ㅠㅠ 코드 통과 해주세요...")
                ForEach(items) { item in
                    NavigationLink {
                        Text("dsfdafdsf at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
