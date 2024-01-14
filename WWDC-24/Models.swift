//
//  Models.swift
//  WWDC-24
//
//  Created by SeanLi on 12/23/23.
//

import Foundation
func loadJSON() -> [Question] {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
        fatalError("Failed to locate file in bundle.")
    }

    guard let data = try? Data(contentsOf: url) else {
        fatalError("Failed to load file from bundle.")
    }

    let decoder = JSONDecoder()

    guard let loadedUsers = try? decoder.decode([Question].self, from: data) else {
        fatalError("Failed to decode file from bundle.")
    }

    return loadedUsers
}

struct Question: Codable, Hashable, Identifiable {
    var id: Int
    var q: String
    var a: Int
    
    init?(file name: String = "Questions.json") {
        if let filePath = Bundle.main.url(forResource: name, withExtension: "json"),
           let json = try? Data(contentsOf: filePath) {
            let decoder = JSONDecoder()
            print("test")
            var decoded = try? decoder.decode(Self.self, from: json)
            if let id = decoded?.id, let q = decoded?.q, let a = decoded?.a {
                self.id = id
                self.q = q
                self.a = a
            }
        }
        return nil
    }
}

//extension Array where Element == Question {
//    init?(file name: String = "Questions.json") {
//        if let filePath = Bundle.main.url(forResource: name, withExtension: "json"),
//           let json = try? Data(contentsOf: filePath) {
//            let decoder = JSONDecoder()
//            print("test")
//            var decoded = try? decoder.decode(Self.self, from: json)
//            print(decoded)
//            
//            if let decoded {
//                print("decoded\(decoded)")
//                self = decoded
//            }
//        }
//        return nil
//    }
////}
//extension Array where Element: Codable {
//    init?(file name: String = "Questions.json") {
//        guard let filePath = Bundle.main.url(forResource: name, withExtension: nil),
//              let json = try? Data(contentsOf: filePath) else {
//            return nil
//        }
//
//        let decoder = JSONDecoder()
//        if let decoded = try? decoder.decode([Element].self, from: json) {
//            self = decoded
//        } else {
//            return nil
//        }
//    }
//}
extension Array where Element: Codable {
    init?(file name: String = "Question") {
        guard let filePath = Bundle.main.url(forResource: name, withExtension: "json"),
              let json = try? Data(contentsOf: filePath) else {
            print("Error: Unable to find \(name).json")
            return nil
        }

        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([Element].self, from: json)
            self = decoded
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
//extension Array where Element == (Array<any Codable>){
//    init?(file name: String = "Question") {
//        guard let filePath = Bundle.main.url(forResource: name, withExtension: "json"),
//              let json = try? Data(contentsOf: filePath) else {
//            print("Error: Unable to find \(name).json")
//            return nil
//        }
//
//        let decoder = JSONDecoder()
//        do {
//            let decoded = try decoder.decode([[Element]].self, from: json)
//            self = decoded
//        } catch {
//            print("Error: \(error)")
//            return nil
//        }
//    }
//}
extension Array where Element == [Question] {
    init?(file name: String = "Question") {
        guard let filePath = Bundle.main.url(forResource: name, withExtension: "json"),
              let json = try? Data(contentsOf: filePath) else {
            print("Error: Unable to find \(name).json")
            return nil
        }

        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([Element].self, from: json)
            self = decoded
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
