import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Faites une requête HTTP pour récupérer la clé API
        if let url = URL(string: "https://quiet-sea-37674-533e813b216d.herokuapp.com/get_api_key") {
            do {
                let data = try Data(contentsOf: url)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let apiKey = json["api_key"] as? String {
                    GMSServices.provideAPIKey(apiKey)
                } else {
                    print("Réponse du serveur mal formatée.")
                }
            } catch {
                print("Erreur lors de la récupération de la clé API.")
            }
        } else {
            print("URL de la route invalide.")
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
