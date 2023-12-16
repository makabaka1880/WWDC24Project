//
//  CalculationCompetitionView.swift
//  WWDC-24
//
//  Created by SeanLi on 12/16/23.
//

import SwiftUI

struct CalculationCompetitionView: View {
    var question: String = "1 + 1 = ?"
    var time: Int = 900
    var body: some View {
        VStack {
            Text(question)
                .font(.system(
                    size: 75,
                    weight: .medium,
                    design: .rounded
                ))
            HStack {
                VStack(alignment: .center) {
                    HStack{
                        Text(DidigitTimeConversion(time))
                            .font(.system(
                                size: 75,
                                weight: .thin,
                                design: .rounded
                            ))
                        Spacer()
                    }
                    DrawBoard()
                        .cornerRadius(50)
                        .border(.black)
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
                    }
                }
                Divider()
                VStack(alignment: .center) {
                    HStack{
                        Spacer()
                        Text(DidigitTimeConversion(time))
                            .font(.system(
                                size: 75,
                                weight: .thin,
                                design: .rounded
                            ))
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
                }
            }
            Spacer()
        }.padding(.all, 100)
    }
}

#Preview {
    CalculationCompetitionView()
}
