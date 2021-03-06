////
////  HomeNavigationBar.swift
////  ArticleDemo
////
////  Created by whh on 2021/4/27.
////
//// whh
///*
// 说明书
// HomeNavigationBar和HScrollViewController直接给栋哥，这两部分应该只有我的部分
// HomeView给栋哥做参考，homeview的接口是内容那部分，我暂时用的微博的
// 
// */
//
//import SwiftUI
//private let kLabelWidth: CGFloat = 60
//private let kButtonHeight: CGFloat = 24
//struct HomeNavigationBar: View {
//    @Binding var leftPercent: CGFloat //0 for left, 1，2 3 for right
//    
//  
//    var body: some View {
//        HStack(alignment: .top, spacing: 0){
//            
//            Button(action: {
//                print("Plus")
//            }){
//                Image(systemName: "camera")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: kButtonHeight, height: kButtonHeight)
//                    .padding(.horizontal, 15)
//                    .foregroundColor(.black)
//                    .padding(.top, 5)
//                    
//                
//            }
//            //Spacer()
//            
//            VStack(spacing: 3){
//                HStack(spacing: 0){
//                    Text("推荐")
//                        .bold()
//                        .frame(width: kLabelWidth, height: kButtonHeight)
//                        .padding(.top, 5)
//                        .opacity(Double(whhistouming(left: leftPercent, labelloc: 0)))
//                        .onTapGesture {
//                            withAnimation{
//                                self.leftPercent = 0
//                            }
//                            
//                        }
//                    
//                    Spacer()
//                    
//                    Text("科技")
//                        .bold()
//                        .frame(width: kLabelWidth, height: kButtonHeight)
//                        .padding(.top, 5)
//                        .opacity(Double(whhistouming(left: leftPercent, labelloc: 1)))
//                        .onTapGesture {
//                            withAnimation{
//                                self.leftPercent = 1
//                            }
//                        }
//                    Spacer()
//                    
//                    Text("军事")
//                        .bold()
//                        .frame(width: kLabelWidth, height: kButtonHeight)
//                        .padding(.top, 5)
//                        .opacity(Double(whhistouming(left: leftPercent, labelloc: 2)))
//                        .onTapGesture {
//                            withAnimation{
//                                self.leftPercent = 2
//                            }
//                        }
//                    Spacer()
//                    
//                    Text("娱乐")
//                        .bold()
//                        .frame(width: kLabelWidth, height: kButtonHeight)
//                        .padding(.top, 5)
//                        .opacity(Double(whhistouming(left: leftPercent, labelloc: 3)))
//                        .onTapGesture {
//                            withAnimation{
//                                self.leftPercent = 3
//                            }
//                        }
//                }
//                .font(.system(size: 20))
//                
//                
//                RoundedRectangle(cornerRadius: 2)
//                    .foregroundColor(.purple)
//                    .frame(width: 30, height: 4)
//                    .offset(x: whhgetoffset(left: self.leftPercent))
//            }
//            .frame(width: UIScreen.main.bounds.width * 0.75)
//            
//            //Spacer()
//            Button(action: {
//                print("Add")
//            }){
//                Image(systemName: "plus.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: kButtonHeight, height: kButtonHeight)
//                    .padding(.horizontal, 15)
//                    .foregroundColor(.purple)
//                    .padding(.top, 5)
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width)
//    }
//}
//
//func whhgetoffset (left: CGFloat) -> CGFloat {
//    let width_space = (UIScreen.main.bounds.width * 0.75 - 4 * kLabelWidth)/3
//    var off: CGFloat
//    if left == 0 {
//        off = UIScreen.main.bounds.width * 0.75 * (-0.5) + kLabelWidth * 0.5
//    } else if left == 1 {
//        off = UIScreen.main.bounds.width * 0.75 * (-0.5) + kLabelWidth * 1.5 + width_space
//    } else if left == 2 {
//        off = UIScreen.main.bounds.width * 0.75 * (-0.5) + kLabelWidth * 2.5 + width_space * 2
//    } else {
//        off = UIScreen.main.bounds.width * 0.75 * (-0.5) + kLabelWidth * 3.5 + width_space * 3
//    }
//    return off
//    
//}
//
//func whhistouming (left: CGFloat, labelloc: CGFloat) -> CGFloat {
//    //返回透明度
//    if left == labelloc {
//        return 1
//    } else {
//        return 0.5
//    }
//    
//}
//
//
//
//struct HomeNavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeNavigationBar(leftPercent: .constant(2))
//    }
//}
