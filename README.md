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
import SwiftUI
import CustomVideoPlayer

class ViewController: UIViewController, VideoPlayerSDKDelegate {

    @IBOutlet weak var videoPl: VideoPlayerUIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // For DRM / Live content
        // videoPl.credentials = VideoPlayerCredentials(
        //     contentId: "<Content-ID>",
        //     packageName: "<Package-Name>"
        // )

        // For normal HLS playback (use either credentials OR streamURL)
        videoPl.streamURL = URL(string: "<Your-HLS-URL>")
        videoPl.autoplay = true
        videoPl.playerDelegate = self
    }

    // MARK: - VideoPlayerSDKDelegate Methods

    func videoDidPlay() { }
    func videoDidPause() { }
    func videoDidFinish() { }

    func videoDidFail(with error: Error) { }

    func fullscreenChanged(isFullscreen: Bool) { }

    // Optional Methods (if implemented in extension)
    // func videoPlayer(didUpdateState state: VideoPlayerState) {}
    // func videoPlayer(didUpdateTime current: Double, duration: Double) {}
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




