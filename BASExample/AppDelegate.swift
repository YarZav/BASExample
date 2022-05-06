//
//  AppDelegate.swift
//  GitHubExample
//
//  Created by 19205313 on 08.03.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  private let appConfiguration: IZAppConfigurationProtocol = IZAppConfiguration()

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = appConfiguration.coordinatorFlow.getNavigationController()
    window?.makeKeyAndVisible()
    return true
  }
}
