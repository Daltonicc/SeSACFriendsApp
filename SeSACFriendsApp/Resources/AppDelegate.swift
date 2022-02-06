//
//  AppDelegate.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/18.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        if #available(iOS 10.0 , *) {
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }

        } else {

        }
//        UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert], completionHandler: { (granted,error) in })
        application.registerForRemoteNotifications()

        // 메시지 대리자 설정
        Messaging.messaging().delegate = self

        //현재 등록된 토큰 가져오기
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                UserDefaultsRepository.saveFCMToken(fcmToken: token)
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {

    // 토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}

/*
 개선사항
 1. 온보딩뷰 레이아웃(비율로 적절하게. 작은화면에서도 어색함 없게 배치)


 이슈
 1. 텍스트 필드의 보더 중에서 바텀에만 보더를 주고 싶었는데 코드를 구현해도 제대로 보더 표시가 안됐던 이슈 존재.
  -> 해결: viewDidLoad가 아닌 viewDidLayoutSubviews에서 관련 코드를 구현해줘야 함. addSubview가 끝난다음에 호출해야 하기 때문.
 2. 모든 뷰, 뷰모델 각종 클래스 들이 소멸자가 호출되지 않는 현상 존재.
  -> 해결: 클로저가 뷰컨트롤러들을 강한참조로 잡고 있었기 때문에 발생한 문제. -> 모든 클로저에 weak self 추가해줌.


 궁금한거
 1. 네비에서 팝해줄때도 코디네이터 이용하는지?
 2. UseCase가 하는 일이 너무 없음. 특히 Profile에서. 그냥 중개하는 역할만 하고 있음.

 새로 시도해본 거
 1. SwiftGen
  - 이미지나 폰트 등 에셋 관련 문자열 에러를 최소화하기 위해 시도해본 툴이다.
 2. Moya
 3. 클래스 상속
  - BaseViewController에 고정적으로 실행해야하는 메서드를 넣어놨고 해당 클래스를 상속함으로써 코드 절약 가능.
 4. Clean Architecture 사용 + Coordinator 패턴
  - Data(Repository, DTO, Network), Domain(UseCase, Entity), Presentatin(View, ViewModel) + Coordinator
 5. SwiftLint
  - 기본적인 룰을 적용시킴으로써 필요없는 코드 제거(프린트문 등), 통일성 있는 코드 작성 목적
 6. RxSwift, RxCocoa
  - 기초적인 부분들에만 우선활용, 아직 Input, Output구조는 시도 못함.


 시도해봐야할 거
 1. 클린아키텍처에서 레포지토리 파트? 어떻게? -> 해결
 2. Moya -> 해결
 */
