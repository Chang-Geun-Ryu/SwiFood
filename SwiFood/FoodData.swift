//
//  DataStore.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

final class FoodData {
  // Main
  var imageNames: [String] = []
  var recipeDetail: [String] = []
  var like: Bool = false
  var gamsungLabel = "갬성"
  
  // detail Mode
  var iconImage = ""
  var comments: [String]? = ["Good!!!", "lol", "맛있어용"]
  
  // cell
  var info = "인포"
  
  var list =  [Food]()
  var images: [String: UIImage?] = [:]
  
  init() {
    
    //복숭아 타르트
    list.append(Food(iconImage: "CakeMain", title: "복숭아 타르트", level: "Level : ★ ★ ★ ☆ ☆ ",
                     comment: ["something", "mmm"],
                     foodMeterial: [("복숭아통조림","1캔"), ("머핀믹스", "250g"), ("우유","40ml"), ("달걀","2개"), ("우유","40ml"), ("식용유", ("65ml"))],
                     meterialImages: ["CakeMeterial1", "CakeMeterial2"],
                     recipe: [

                        " 복숭아는 버리고 과육만 따로 준비합니다.",
                        " 달걀과 우유, 식용유를 볼에 넣고 ",
                        " 거품기로 섞어준 후 머핀믹스를 넣고",
                        " 반죽을 버터를 바른 타르트 틀에 부어주세요",
                        " 타르트틀은 반죽보다 높은것을 준비해서 ",
                        " 복숭아를 얇게 슬라이스하여 보기 좋게 올려줍니다",
                        " 70℃로 오븐에서 25분 구워 완성합니다.",
        ], sensitivity: "PeachTarte", info: "Information"))
    images.updateValue(UIImage(named: "CakeMain"), forKey: "CakeMain")
    images.updateValue(UIImage(named: "CakeMeterial1"), forKey: "CakeMeterial1")
    images.updateValue(UIImage(named: "CakeMeterial2"), forKey: "CakeMeterial2")
    
    // 티라미수 타르트
    list.append(Food(iconImage: "TarteMain", title: "티라미수 타르트", level: "Level : ★ ★ ★ ★ ☆ ", comment: ["something", "mmm"],
                foodMeterial: [("진저브래드 쿠키믹스", "1개"),("달걀노른자", "1개"),("버터", "80g"),("우유", "15ml"),("초코시트", "1장"),("설탕", "30g"),("생크림", "200ml"),("크림치즈", "250g"),],
                meterialImages: ["TarteMeterial"],
                recipe: [
                  " 볼에 쿠키믹스,달걀노른자,버터,우유를 넣고",
                  " 핸드믹서 거품기로 섞어주세요.",
                  " STEP1의 반죽 재료를 비닐에 넣어 뭉쳐준 후",
                  " 밀대로 밀어 타르트팬에 넣어주세요. ",
                  " 포크로 모양을 낸 후 180℃오븐에서 12분간 구운 후",
                  " 식힘망에 올려 식혀주세요.",
                  " 볼에 크림치즈, 샤워크림을 넣고 핸드믹서 거품기로",
                  " 가장 약한 단계에서 섞어주세요.",
                  " 다른 볼에 생크림을 넣고가장 센 단계에서 휘핑한 후 ",
                  " STEP6에 넣고 실리콘주걱으로 섞어주세요.",
                  " STEP3의 타르트팬에 필링을 1/2 넣고",
                  " 초코시트를 그 위에 올려주세요.",
                  " 슈거파우더와 코코아가루로 마무리해주세요.",
      ], sensitivity: "Tiramisu", info: "Information"))
    images.updateValue(UIImage(named: "TarteMain"), forKey: "TarteMain")
    images.updateValue(UIImage(named: "TarteMeterial"), forKey: "TarteMeterial")
    
    // 애플 파이
    list.append(Food(iconImage: "ApplePieMain", title: "애플 파이", level: "Level : ★ ★ ★ ★ ☆ ", comment: ["something", "mmm"],
                     foodMeterial: [("밀가루","250g"),("버터","200g"),("소금","4/1작은술"),("찬물","2큰술"),("설탕","1큰술"),("달걀노른자","1개"),("사과","3개"),("시나몬파우더","1/2큰술"),("메이플시럽","30g"),("레몬","1/2큰술"),],
                     meterialImages: ["ApplePieMeterial1", "ApplePieMeterial2"],
                     recipe: [
                        " 넓은 볼에 체를 받쳐 밀가루를 내린 후",
                        " 설탕, 소금 넣어 섞고 차가운버터를 넣고 ",
                        " 버터가 0.2cm크기가 될 때까지 반죽해주세요.",
                        " 반죽이 부슬부슬한 상태가 되면 ",
                        " 찬물과 달걀노른자를 넣고 섞어주세요.",
                        " 가루가 보이지 않을때 한 덩어리로 뭉치고",
                        " 납작하게 눌러 1시간 휴지시켜주세요. ",
                        " 사과는 1cm두께로 납작하게 썰어주세요.",
                        " 버터를 녹인 냄비에 사과와 필링재료를 넣고",
                        " 15분간 졸여준 후 체에 밭쳐서 완전히 식혀주세요.",
                        " 반죽을 반으로 나눈 후 밀어주세요.",
                        " 파이틀에 반죽을 올려서 안쪽에 붙여주세요.",
                        " 바닥에 사과필링을 채워주세요.",
                        " 파이 윗면과 테두리에 달걀물을 발라주세요",
                        " 180도로 예열한 오븐에서 약 45분 구워준 후",
                        " 꺼내서 완전히 식힌 후 틀에서 꺼내주세요."
                        
        ],
                     sensitivity: "ApplePie",
                     info: "Information    "))
    images.updateValue(UIImage(named: "ApplePieMain"), forKey: "ApplePieMain")
    images.updateValue(UIImage(named: "ApplePieMeterial1"), forKey: "ApplePieMeterial1")
    images.updateValue(UIImage(named: "ApplePieMeterial2"), forKey: "ApplePieMeterial2")
    
    
    
    //초코칩쿠키
    list.append(Food(iconImage: "ChocolateMain", title: "초코칩 쿠키", level: "Level : ★ ★ ★ ★ ☆ ", comment: ["something", "mmm"],
                foodMeterial: [("박력분","100g"),("아몬드가루","50g"), ("베이킹파우더","1st"), ("베이킹소다","1/3ts"), ("설탕","30g"),("소금","1/4ts"), ("아몬드슬라이스","50g")],
                meterialImages: ["ChocolateMeterial1","ChocolateMeterial2"],
                recipe: [
                  " 볼에 달걀,우유, 설탕,소금을 넣고 섞어주세요",
                  " 박력분과 아몬드 가루, 베이킹파우더, 베이킹 소다를",
                  " 함께 체 쳐서 섞은 후 섞어 주세요",
                  " 아몬드 슬라이스를 반죽에 넣고 섞어주세요",
                  " 볼에 랩을 씌워 실온에서 30분정도 둔 다음",
                  " 달군 와플 팬에 반죽을 적당히 나눠 구워주세요",
                  " 와플은 식힘망에서 식혀줘야 바삭해요",
      ], sensitivity: "Chocolatechip", info: "Information"))
    images.updateValue(UIImage(named: "ChocolateMain"), forKey: "ChocolateMain")
    images.updateValue(UIImage(named: "ChocolateMeterial1"), forKey: "ChocolateMeterial1")
    images.updateValue(UIImage(named: "ChocolateMeterial2"), forKey: "ChocolateMeterial2")
    
    //포도피자
    list.append(Food(iconImage: "GrapePizzaMain", title: "포도 피자", level: "Level : ★ ☆ ☆ ☆ ☆ ", comment: ["something", "mmm"],
                foodMeterial: [("포도","1컵"),("토르티야","1장"),("피자치즈","1컵"),("꿀","2큰술"),("루꼴라","한줌"),("파마산치즈블럭","약간"),],
                meterialImages: ["GrapePizzaMeterial"],
                recipe: [
                  " 포도는먹기 좋은 크기로 잘라 씨를 빼주세요.",
                  " 루꼴라는 깨끗이 씻어 물기를 제거해주세요. ",
                  " 토르티야에 꿀 1큰술을 넓게 바르고",
                  " 피자치즈와 포도를 골고루 올려주세요.",
                  " 200도로 오븐에서 9~10분 정도 구워주세요.",
                  " 토르티야에 루꼴라를 올리고",
                  " 파마산치즈를 뿌린 후 완성해주세요."
                  
      ], sensitivity: "GrapePizza", info: "Information"))
    
    images.updateValue(UIImage(named: "GrapePizzaMain"), forKey: "GrapePizzaMain")
    images.updateValue(UIImage(named: "GrapePizzaMeterial"), forKey: "GrapePizzaMeterial")
    
  }
}
// 레시피 추가할때 이미지도 같이 추가됨 -> recipe 타입이 Recipe로 들어갈것

class Recipes {
    static let shared = Recipes()
    
    var recipes = [Recipe]()
}

struct Recipe {
    var recipeImage: UIImage?
    var recipeDiscription: String
}

struct Meterial {
    var meterialName: String
    var amount: String
}

// class로 바꾸기
struct Food {
  // section 1
  var iconImage = ""
  // section 2
  var title = ""
  var level = ""
  var comment = ["Good!!!", "lol", "맛있어용"]
  
  // section 3
  var foodMeterial: [(String,String)] = []
  // section 4
  var meterialImages = [String]()
  
  // section 5
  var recipe = [String]()
//    var recipe = [Recipe]()
  
  // main 에서 사용할 data
  var sensitivity = ""
  var info = ""
    
    mutating func appendComment(comment: String) {
       self.comment.append(comment)
    }
  
  mutating func update(icon: String, title: String, level: String, comment: [String], foodMeterial: [(String, String)], meterialImage: [String], recipe: [String], sensi: String, info: String) {
    
    self.iconImage = icon
    self.title = title
    self.level = level
    self.comment = comment
    self.foodMeterial = foodMeterial
    self.recipe = recipe
    self.sensitivity = sensi
    self.info = info
  }
  
  func getFoodMeterial() -> [String] {
    var foodArray: [String] = []
    
    for (meterial, quantity) in foodMeterial {
      foodArray.append(meterial)
      foodArray.append(quantity)
    }
    
    return foodArray
  }
  
  func checkFoodData() -> Bool {
    guard iconImage.isEmpty == false else { print("iconImage is Empty"); return false }
    guard title.isEmpty == false else { print("title is Empty"); return false }
    guard level.isEmpty == false else { print("level is Empty"); return false }
   // guard comment. == false else { print("comme")} // comment는 비워져 있어도 됨~
    guard foodMeterial.count > 0 else { print("food Meterial is Empty"); return false }
    guard recipe.count > 0 else { print("recipe is Empty"); return false }
    guard sensitivity.isEmpty == false else { print("sensitivity is Empty"); return false }
    guard info.isEmpty == false else { print("info is Empty"); return false }
    
    return true
  }
}
