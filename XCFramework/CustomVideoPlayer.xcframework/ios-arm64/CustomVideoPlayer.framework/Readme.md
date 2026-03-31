
xcodebuild archive \
  -scheme CustomVideoPlayer \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "./build/CustomVideoPlayer-iOS.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
  -framework ./build/CustomVideoPlayer-iOS.xcarchive/Products/Library/Frameworks/CustomVideoPlayer.framework \
  -output ./build/CustomVideoPlayer.xcframework
  
  
  # Step 1: Archive
xcodebuild archive \
  -scheme CustomVideoPlayer \
  -destination "generic/platform=iOS" \
  -archivePath build/CustomVideoPlayer-iOS.xcarchive \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Step 2: Strip the nested Frameworks folder from the archive
ARCHIVE_FW="build/CustomVideoPlayer-iOS.xcarchive/Products/Library/Frameworks/CustomVideoPlayer.framework"
rm -rf "$ARCHIVE_FW/Frameworks"

# Step 3: Create xcframework
xcodebuild -create-xcframework \
  -framework "$ARCHIVE_FW" \
  -output build/CustomVideoPlayer.xcframework
