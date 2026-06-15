# CustomVideoPlayerSDK

📦 Installation (Swift Package Manager)
Swift Package Manager

Add the package to your project using Xcode:

Open Xcode → File → Add Packages…

Enter the package URL in the search field:

https://github.com/support941/CustomVideoPlayerSDK.git


Select the version rule (e.g., Up to Next Major)

Click Add Package

A Swift SDK for playing DRM-protected video content with DoveRunnerFairPlay support.

Add DoveRunnerFairPlay.xcframwork to your project framework to play the DRM protected content.

## Features

- ✅ DRM-protected video playback (FairPlay)
- ✅ Non-DRM playback via direct stream URLs
- ✅ Automatic authentication and license token management
- ✅ Live stream support with blinking LIVE indicator
- ✅ Quality selection, playback speed, language, and subtitle controls
- ✅ Fullscreen support
- ✅ Auto-hide controls after 8 seconds
- ✅ Replay functionality


1. Add DoveRunnerFairPlay.xcframwork to your project framework to play the DRM protected content.

2. Import the SDK in your SwiftUI view

## Usage

### Basic Usage (DRM)

```swift
import SwiftUI
import VideoPlayerSDK

struct MyVideoView: View {
    var body: some View {
        VideoPlayerSDK.createPlayerView(
            credentials: VideoPlayerCredentials(
                contentId: "Your content id"  //  "contnt",
                packageName: "Your package Id" //"com.explale.app",
                
            ),
            autoplay: false
        )
    }
}
```

### Non-DRM Playback (URL only)

```swift
import SwiftUI
import VideoPlayerSDK

struct PlainVideoView: View {
    private let streamURL = URL(string: "https://stream.example.com/playlist.m3u8")!
    
    var body: some View {
        VideoPlayerSDK.createPlayerView(
            streamURL: streamURL,
            autoplay: true
        )
    }
}
```

### With Delegate

```swift
import SwiftUI
import VideoPlayerSDK

struct MyVideoView: View, VideoPlayerSDKDelegate {
    var body: some View {
        VideoPlayerSDK.createPlayerView(
            credentials: VideoPlayerCredentials(
                contentId: "Your content id"  //  "contnt",
                packageName: "Your package Id" //"com.explale.app",
              
            ),
            autoplay: true,
            delegate: self
        )
    }
    
    // MARK: - VideoPlayerSDKDelegate
    
    func videoDidPlay() {
        print("Video started playing")
    }
    
    func videoDidPause() {
        print("Video paused")
    }
    
    func videoDidFinish() {
        print("Video finished")
    }
    
    func videoDidFail(with error: Error) {
        print("Video failed: \(error.localizedDescription)")
    }
    
    func fullscreenChanged(isFullscreen: Bool) {
        print("Fullscreen: \(isFullscreen)")
    }
}
```

### Add to Any View

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("My App")
            
            // Add video player
            VideoPlayerSDK.createPlayerView(
                credentials: VideoPlayerCredentials(
                    contentId: "content-id",
                    packageName: "com.yourapp.package"
                )
            )
            .frame(height: 300)
        }
    }
}
```

## Customization (Latest)

You can now customize title, player controls, and settings overlay from outside the SDK.

### What You Can Customize

- `title` and `titleColor`
- `controlsAppearance`
  - icon image and tint for:
    - `rewind`, `play`, `pause`, `replay`, `forward`
    - `fullscreen`, `settings`, `fill`, `unfill`
    - `season`, `brightness`, `volume`, `mute`, `close`
  - global fallback via `defaultTintColor`
- `settingsOverlayAppearance`
  - colors, fonts, radius, shadow, selected/unselected chip style
- `settingsOptionsConfig`
  - speed list
  - row order (`.quality`, `.speed`, `.language`, `.subtitle`)
  - show/hide flags per row
- `settingsTextConfig`
  - title and row labels (localization friendly)

### SwiftUI Customization Example

```swift
import SwiftUI
import UIKit
import CustomVideoPlayer

struct CustomizedPlayerView: View {
    @State private var viewModel: VideoPlayerVMType?

    private let controlsAppearance: PlayerControlsAppearance = {
        var appearance = PlayerControlsAppearance()
        appearance.defaultTintColor = .white
        appearance.play = .init(
            image: UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate),
            tintColor: .systemYellow
        )
        appearance.pause = .init(tintColor: .systemGreen)
        appearance.settings = .init(tintColor: .systemOrange)
        appearance.fullscreen = .init(tintColor: .systemCyan)
        return appearance
    }()

    private let settingsOverlayAppearance: SettingsOverlayAppearance = {
        var appearance = SettingsOverlayAppearance()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        appearance.titleColor = .systemYellow
        appearance.rowTitleColor = .lightGray
        appearance.chipSelectedBackgroundColor = .systemBlue
        appearance.chipSelectedTextColor = .white
        appearance.chipUnselectedBackgroundColor = UIColor.darkGray.withAlphaComponent(0.45)
        appearance.chipUnselectedTextColor = .white
        return appearance
    }()

    private let settingsOptionsConfig = SettingsOptionsConfig(
        speedOptions: ["0.75x", "1x", "1.25x", "1.5x", "2x"],
        rowOrder: [.speed, .quality, .language, .subtitle],
        showQuality: true,
        showSpeed: true,
        showLanguage: true,
        showSubtitle: true
    )

    private let settingsTextConfig = SettingsTextConfig(
        title: "Playback Settings",
        qualityLabel: "Video Quality",
        speedLabel: "Speed",
        languageLabel: "Audio",
        subtitleLabel: "Captions"
    )

    var body: some View {
        VideoPlayerSDK.createPlayerView(
            credentials: VideoPlayerCredentials(
                contentId: "dangal",
                packageName: "com.dangalplay.tv"
            ),
            autoplay: false,
            title: "Demo Title",
            titleColor: .white,
            controlsAppearance: controlsAppearance,
            settingsOverlayAppearance: settingsOverlayAppearance,
            settingsOptionsConfig: settingsOptionsConfig,
            settingsTextConfig: settingsTextConfig
        ) { vm in
            viewModel = vm
        }
    }
}
```

### UIKit Customization Example

```swift
import UIKit
import CustomVideoPlayer

final class ViewController: UIViewController {
    @IBOutlet private weak var videoPlayerView: VideoPlayerUIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        videoPlayerView.credentials = VideoPlayerCredentials(
            contentId: "dangal",
            packageName: "com.dangalplay.tv"
        )
        videoPlayerView.autoplay = true

        videoPlayerView.title = "Demo Title"
        videoPlayerView.titleColor = .white

        var controlsAppearance = PlayerControlsAppearance()
        controlsAppearance.defaultTintColor = .white
        controlsAppearance.play = .init(tintColor: .systemYellow)
        controlsAppearance.pause = .init(tintColor: .systemGreen)
        controlsAppearance.settings = .init(tintColor: .systemOrange)
        videoPlayerView.controlsAppearance = controlsAppearance

        var settingsAppearance = SettingsOverlayAppearance()
        settingsAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        settingsAppearance.titleColor = .systemYellow
        videoPlayerView.settingsOverlayAppearance = settingsAppearance

        videoPlayerView.settingsOptionsConfig = SettingsOptionsConfig(
            speedOptions: ["1x", "1.25x", "1.5x", "2x"],
            rowOrder: [.quality, .speed, .language, .subtitle],
            showSubtitle: true
        )

        videoPlayerView.settingsTextConfig = SettingsTextConfig(
            title: "Settings",
            qualityLabel: "Quality",
            speedLabel: "Speed",
            languageLabel: "Language",
            subtitleLabel: "Subtitle"
        )
    }
}
```

### Fallback Behavior

- All customization parameters are optional.
- If you do not pass customization values, SDK default look is used.
- If a custom icon image is not provided, default SDK icon is used.
- Tint fallback order for control icons:
  - control-specific tint
  - `defaultTintColor`
  - SDK internal fallback color


### VideoPlayerCredentials

Configuration structure for video playback.

#### Properties

- `contentId: String` - Content ID to play
- `packageName: String` - App package name

### VideoPlayerSDKDelegate

Protocol for receiving video player events.

#### Methods

- `videoDidPlay()` - Called when video starts playing
- `videoDidPause()` - Called when video is paused
- `videoDidFinish()` - Called when video finishes
- `videoDidFail(with:)` - Called when an error occurs
- `fullscreenChanged(isFullscreen:)` - Called when fullscreen state changes


📱 UIKit Implementation Guide

This section explains how to integrate the CustomVideoPlayer inside your UIKit project using UIViewController and VideoPlayerUIView.

▶️ Example Usage (UIKit)

import UIKit
import CustomVideoPlayer
class ViewController: UIViewController ,VideoPlayerSDKDelegate{
    
    
    @IBOutlet weak var videplayer: VideoPlayerUIView!
    
    @IBOutlet weak var playpausebtnOutlet: UIButton!
    
    @IBOutlet weak var Listtableview: UITableView!
    let videoList: [String] = [
        "hls,
        "hls"
    ]
    let liveDRM: [String] = [
        "<content_id>",
               "<content_id>",
                "<content_id>",
    ]
    let packagename = "packagename"
    var vm : VideoPlayerVMType?
    var isfullsreem:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Listtableview.dataSource = self
        Listtableview.delegate = self
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if isfullsreem && UIDevice.current.userInterfaceIdiom == .pad {
            videopl.frame = view.bounds
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        if UIDevice.current.userInterfaceIdiom == .pad {
            coordinator.animate(alongsideTransition: { _ in
                if self.isfullsreem {
                    self.videopl.frame = CGRect(origin: .zero, size: size)
                }
            })
        }
       
    }
    

    
   
    override func viewWillAppear(_ animated: Bool) {
//        loadVideo(urlString: videoList.first!)  // for hls url
        loadVideo(contentid: liveDRM.first!, packageName: packagename)  //for live drm contnet
    }
    func loadVideo(urlString: String) {

        guard let url = URL(string: urlString) else { return }
        
        videplayer.streamURL = url
        videplayer.autoplay = true
        videplayer.playerDelegate = self
        
        
        videplayer.onViewModel = { model in
            self.vm = model
        }
    }
    func loadVideo(contentid: String, packageName:String) {
        videplayer.credentials = VideoPlayerCredentials(contentId: contentid, packageName: packageName)
                
        videplayer.autoplay = true
        videplayer.playerDelegate = self

        videplayer.onViewModel = { model in
            self.vm = model
        }
    }
    
    @IBAction func playpausbtn(_ sender: UIButton) {
        vm?.togglePlayPause()
    }
    
    @IBAction func backaction(_ sender: UIButton) {
        if isfullsreem{
            vm?.toggleFullscreen()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func videoDidPlay() {
        
    }
    
    func videoDidPause() {
        
    }
    
    func videoDidFinish() {
        
    }
    
    func videoDidFail(with error: any Error) {
        
    }
    
    func fullscreenChanged(isFullscreen: Bool) {
        print(isFullscreen, "osfukervf")
        
        if isFullscreen {
            isfullsreem = true
            playpausebtnOutlet.isHidden = true
            Listtableview.isHidden = true
            
                      //make sure this should be added  then ipad work well
                                
            if UIDevice.current.userInterfaceIdiom == .pad {
               videplayer.translatesAutoresizingMaskIntoConstraints = true
                videplayer.frame = view.bounds
                view.bringSubviewToFront(videplayer)
            }
        }else{
        
        
            isfullsreem = false
            playpausebtnOutlet.isHidden = false
            Listtableview.isHidden = false
            
             //make sure this should be added  then ipad work well
                
            if UIDevice.current.userInterfaceIdiom == .pad {
              videplayer.translatesAutoresizingMaskIntoConstraints = false
                view.setNeedsLayout()
                view.layoutIfNeeded()
            }
        }
    }
    
    
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return videoList.count // hls player
        return liveDRM.count // drm conent
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableviewCell",
                                                       for: indexPath) as? ListTableviewCell else {
            return UITableViewCell()
        }
        
        
//        let url = videoList[indexPath.row] // for hls
        let url = liveDRM[indexPath.row] // for drm
        cell.textLabel?.text = "Video \(indexPath.row + 1)"
        cell.detailTextLabel?.text = url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let selectedURL = videoList[indexPath.row] // for hls
        let selectedURL = liveDRM[indexPath.row]  // for drm
        print("Selected URL:", selectedURL)
        
        //MARK:  HLS PLAYER
                if let url = URL(string: selectedURL){
                    DispatchQueue.main.async(execute: {
                        self.vm?.updatePlayer(url: url)
        
                    })
        
                }
        //MARK:  LIVE PLAYER
        
        DispatchQueue.main.async(execute: {
            self.vm?.updateDRMChannel(contentId: selectedURL, packageName: self.packagename)
            
        })
        
    }
    
    
}
    
    




class ListTableviewCell : UITableViewCell{
    
    override class func awakeFromNib() {
        
    }
}

📌 Firebase Analytics Integration Guide

Follow the steps below to integrate Firebase Analytics into your iOS project.

🔧 1. Add Dependency

Add the Firebase iOS SDK via Swift Package Manager:

https://github.com/firebase/firebase-ios-sdk.git

Select:

FirebaseAnalytics
📂 2. Add GoogleService-Info.plist
Download GoogleService-Info.plist from the Firebase Console
Drag & drop it into your Xcode project
Ensure it is added to the correct target
🛠 3. Configure AppDelegate

Update your AppDelegate.swift:

import UIKit
import FirebaseCore
import FirebaseAnalytics
import CustomVideoPlayer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Initialize Firebase
        FirebaseApp.configure()
        
        // Set Analytics Service
        PlayerAnalyticsManager.shared = FirebaseAnalyticsService()
        
        return true
    }
}
📊 4. Create Analytics Service
final class FirebaseAnalyticsService: AnalyticsTracking {
    
    func logEvent(_ name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}

📌 Important Notes for UIKit

You can add VideoPlayerUIView from Storyboard (via @IBOutlet) or create it programmatically.

Make sure to set a proper aspect ratio for the video container view.

Recommended: 16 : 9 aspect ratio

Only one of the following should be used at a time:

.credentials → for DRM / secure content

.streamURL → for standard HLS playback


## Requirements

- iOS 14.0+
- Xcode 14.0+
- Swift 5.9+
- DoveRunnerFairPlay.xcframework

## Notes

- DRM-protected content only works on physical devices, not iOS Simulator
- The SDK automatically handles authentication and license token fetching
- Live streams are automatically detected and show a blinking LIVE indicator
- Controls automatically hide after 8 seconds of inactivity

## License



