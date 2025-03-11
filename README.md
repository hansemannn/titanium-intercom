# Titanium Intercom SDK

Use the native iOS / Android Intercom SDK's in Appcelerator Titanium.

## Requirements

- [x] Titanium SDK 9+
- [x] iOS 10+ and Android 5+
- [x] A valid iOS/Android API key and app ID

## Notes

**iOS**: Add `NSPhotoLibraryUsageDescription` to your `tiapp.xml` file.

### Changes in v6.1.0 (Android only):

- According to the Intercom guidelines, the Android module now initialises the Intercom in the main application class itself.
- To do this, add the following properties inside the `<ti:app>` tag in the `tiapp.xml` file and replace their values with your Intercom App ID and API key respectively:
   - `<property name="intercom-app-id" type="string">app-id-here</property>`.
   - `<property name="intercom-android-api-key" type="string">api-key-here</property>`.
- You can still use the `configure` method as is, but it may not always work as intended.

## Example

See the example in `example/app.js`


## Copyright

(c) 2021 by Hans Knöchel

## License

MIT 
