//
//  CalculationCompetitionView.swift
//  WWDC-24
//
//  Created by SeanLi on 12/16/23.
//

import SwiftUI
import Combine

struct CalculationCompetitionView: View {
    @State var question: String = "Loading..."
    @State var timeR: Int = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var humanTime = 0
    @State var mlTime = 0
    @State var humanStopped: Bool = false
    @State var loaded: [Question]? = nil
    @State var set: Ques = .easy
    
    var body: some View {

        VStack {
            Text(question)
                .font(.system(
                    size: 75,
                    weight: .medium,
                    design: .rounded
                ))
            Button("Restart Timer") {
                timeR = 30
            }
            HStack {
                VStack(alignment: .center) {
                    HStack{
                        Text(DidigitTimeConversion(humanStopped ? humanTime : timeR))
                            .font(.system(
                                size: 75,
                                weight: .thin,
                                design: .rounded
                            ))
                            .foregroundStyle(timeR == 0 ? Color.red : Color.black)
                        Spacer()
                    }
                    DrawBoard()
                    HStack {
                        Spacer()
                        TextField("Your Answer...", text: .constant(""))
                            .frame(width: 350.0)
                            .font(.system(
                                size: 40,
                                weight: .thin,
                                design: .rounded
                            ))
                        Spacer()
                        Button("Submit") {
                            humanStopped = true
                        }
                    }
                }.padding()
                Divider()
                VStack(alignment: .center) {
                    HStack{
                        Spacer()
                        Text(DidigitTimeConversion(timeR))
                            .font(.system(
                                size: 75,
                                weight: .thin,
                                design: .rounded
                            ))
                            .foregroundStyle(timeR == 0 ? Color.red : Color.black)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        TextField("Machine's Answer...", text: .constant(""))
                            .frame(width: 350.0)
                            .font(.system(
                                size: 40,
                                weight: .thin,
                                design: .rounded
                            ))
                        Spacer()
                    }
                    .padding()
                }
            }
            Spacer()
            Picker("Pick", selection: $set) {
                ForEach(Ques.allCases) { option in
                    Text(String(describing: option))
                }
            }
            .onChange(of: set) { set in
                timeR = 30
                print("update")
                let loaded = [[Question]].init(file: "Questions")
                print("loaded: \(loaded)")
                if let element = loaded?[indexOfSet(set: set)].randomElement() {
                    question = element.q
                } else {
                    print("error")
                }
            }
        }.padding(.all, 100)
            .onReceive(timer) { time in
                if timeR > 0 {
                    timeR -= 1
                    if !humanStopped {
                        humanTime += 1
                    }
                    mlTime += 1
                    print(timeR)
                }
            }
            .onAppear {
                let loaded = [[Question]].init(file: "Questions")
                print("loaded: \(loaded)")
                if let element = loaded?[indexOfSet(set: set)].randomElement() {
                    question = element.q
                } else {
                    print("error")
                }
            }
    }
}

#Preview {
    CalculationCompetitionView()
}

enum Ques: CaseIterable, Identifiable, CustomStringConvertible {
    case easy
    case medium
    case hard
    var id: Self {
        self
    }
    var description: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
}

func indexOfSet(set: Ques) -> Int {
    switch set {
    case .easy:
        return 0
    case .medium:
        return 1
    case .hard:
        return 2
    }
}
