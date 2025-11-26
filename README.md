# CustomVideoPlayerSDK

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
                email: "accounts@dangal.com",
                password: "12345678",
                contentId: "dangal",
                packageName: "com.dangalplay.tv"
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
                email: "accounts@dangal.com",
                password: "12345678",
                contentId: "dangal",
                packageName: "com.dangalplay.tv",
                deviceId: "custom-device-id" // Optional, auto-generated if nil
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
                    email: "user@example.com",
                    password: "password",
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

- `email: String` - User email for authentication
- `password: String` - User password for authentication
- `contentId: String` - Content ID to play
- `packageName: String` - App package name
- `deviceId: String?` - Optional device ID (auto-generated if nil)

### VideoPlayerSDKDelegate

Protocol for receiving video player events.

#### Methods

- `videoDidPlay()` - Called when video starts playing
- `videoDidPause()` - Called when video is paused
- `videoDidFinish()` - Called when video finishes
- `videoDidFail(with:)` - Called when an error occurs
- `fullscreenChanged(isFullscreen:)` - Called when fullscreen state changes

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
