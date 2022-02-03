//
//  ContentView.swift
//  SwiftUi_MyLEDBoard
//
//  Created by Chuljin Hwang on 2022/01/30.
//

import SwiftUI

struct ContentView: View {
    @State private var content = ""
    @State private var TextColorIndex : Int = 2
    @State private var BackColorIndex : Int = 1
    var TextColor : [Color] = [.red, .blue, .yellow]
    var BackColor : [Color] = [.white, .black]
    var content_ini : String = "LED Board"
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                    switch BackColorIndex {
                    case 0 :
                        Color.green
                    case 1 :
                         Color.black
                    default:
                        Color.black
                    }
    
                    if content == "" {
                        Text(content_ini)
                            .foregroundColor(TextColor[TextColorIndex])
                            .font(.system(size: 50, weight: .black, design: .rounded))
                    } else {
                        Text(content)
                            .foregroundColor(TextColor[TextColorIndex])
                            .font(.system(size: 50, weight: .black, design: .rounded))
                    }
                        
                }
            }
            .navigationBarItems(trailing: Controllink(control_content: $content, TextColorIndex: $TextColorIndex, BackColorIndex: $BackColorIndex))
            .edgesIgnoringSafeArea(.all)
            
        }
       
    }
}

struct Controllink: View{
    @Binding var control_content : String
    @Binding var TextColorIndex : Int
    @Binding var BackColorIndex : Int
    //네비게이션 링크에 옵션을 줘야 백 버튼이 사라지게 할수 있다.
    var body: some View{
        NavigationLink(destination: {
            detailView(detail_content: $control_content, TextColorIndex: $TextColorIndex, BackColorIndex: $BackColorIndex).navigationBarBackButtonHidden(true)
        }, label: {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
        })
            
    }
}

struct detailView: View{
    let TextColorName = ["빨강", "파랑", "노랑"]
    var TextColor : [Color] = [.red, .blue, .yellow]
    let BackColorName = ["녹색", "검은색"]
    var BackColor : [Color] = [.green, .black]
    
    @Environment(\.presentationMode) var presentation
    @Binding var detail_content : String
    @State private var inputContent : String = ""
    @State private var TextColorSelect : String = ""
    @Binding var TextColorIndex : Int
    @Binding var BackColorIndex : Int
    var body: some View{
        VStack{
            Form{
                Text("화면 내용을 입력해주세요")
                TextField("화면에 출력됩니다", text: $detail_content)
                
                Section{
                    Text("글자 색상을 골라주세요 ")
                    Picker("Selected Text", selection: $TextColorIndex){
                        ForEach(0..<TextColorName.count){
                            Text(self.TextColorName[$0])
                                .foregroundColor(TextColor[$0])
                        }
                    }
                    
                }
                
                
                Section{
                    Text("배경 색상을 골라주세요 ")
                    Picker("Selected background", selection: $BackColorIndex){
                        ForEach(0..<BackColorName.count){
                            Text(self.BackColorName[$0])
                                .foregroundColor(BackColor[$0])
                        }
                    }
                }
        
            }
            Button(action: {
                self.presentation.wrappedValue.dismiss()
                
            }, label: {
                Text("저장")
                    
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
