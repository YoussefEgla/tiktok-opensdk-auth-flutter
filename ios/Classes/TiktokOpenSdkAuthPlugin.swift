import Flutter
import UIKit
import TikTokOpenSDK // Ensure this is the correct import for the TikTok SDK

public class TiktokOpenSdkAuthPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    private var channel: FlutterMethodChannel?
    private var authApi: TikTokOpenSDKApplicationDelegate? // Replace with actual TikTok Auth SDK type
    private var activity: UIViewController?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tiktok_open_sdk_auth", binaryMessenger: registrar.messenger())
        let instance = TiktokOpenSdkAuthPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // Register for lifecycle events to manage activity state
        if let appDelegate = UIApplication.shared.delegate as? FlutterAppDelegate {
            appDelegate.add(instance)
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                self.activity = rootViewController
                self.authApi = TikTokOpenSDKApplicationDelegate() // Initialize your TikTok SDK instance here
                result(true)
            } else {
                result(FlutterError(code: "NO_ACTIVITY", message: "TikTok Auth requires a foreground activity.", details: nil))
            }
        case "authorize":
            guard let authApi = self.authApi else {
                result(FlutterError(code: "NOT_INITIALIZED", message: "TikTok Auth API is not initialized.", details: nil))
                return
            }
            let args = call.arguments as! [String: Any]
            let authMethod = args["authMethod"] as! Int
            let clientKey = args["clientKey"] as! String
            let scope = args["scope"] as! String
            let redirectUri = args["redirectUri"] as! String
            let codeVerifier = PKCEUtils.generateCodeVerifier()
            
            let authRequest = AuthRequest(
                clientKey: clientKey,
                scope: scope,
                redirectUri: redirectUri,
                codeVerifier: codeVerifier
            )
            
            authApi.authorize(authRequest, authMethod: AuthApi.AuthMethod(rawValue: authMethod)!) { response in
                if response.isSuccess {
                    result(true)
                } else {
                    result(FlutterError(code: "AUTH_FAILED", message: "Authorization failed.", details: response.errorDescription))
                }
            }
        case "getAuthResponseFromIntent":
            guard let authApi = self.authApi, let activity = self.activity else {
                result(FlutterError(code: "NOT_INITIALIZED", message: "TikTok Auth API is not initialized.", details: nil))
                return
            }
            let args = call.arguments as! [String: Any]
            let redirectUri = args["redirectUri"] as! String
            let response = authApi.getAuthResponseFromIntent(activity, redirectUri: redirectUri)
            
            if response != nil {
                result(response)
            } else {
                result(FlutterError(code: "NO_RESPONSE", message: "No auth response found.", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Handling lifecycle methods to manage the activity state
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        // Handle activity becoming active if needed
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        // Handle activity resigning active if needed
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle entering background if needed
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        // Handle entering foreground if needed
    }
}