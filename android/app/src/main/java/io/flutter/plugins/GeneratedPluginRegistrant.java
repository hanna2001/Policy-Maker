package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    try {
      flutter.io.androidmultipleidentifier.AndroidMultipleIdentifierPlugin.registerWith(shimPluginRegistry.registrarFor("flutter.io.androidmultipleidentifier.AndroidMultipleIdentifierPlugin"));
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin android_multiple_identifier, flutter.io.androidmultipleidentifier.AndroidMultipleIdentifierPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.cashfree.cashfree_pg.CashfreePgPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin cashfree_pg, com.cashfree.cashfree_pg.CashfreePgPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new co.creativemind.device_information.DeviceInformationPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin device_information, co.creativemind.device_information.DeviceInformationPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_auth, io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.sidlatau.flutteremailsender.FlutterEmailSenderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_email_sender, com.sidlatau.flutteremailsender.FlutterEmailSenderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin fluttertoast, io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_cropper, vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.imagegallerysaver.ImageGallerySaverPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_gallery_saver, com.example.imagegallerysaver.ImageGallerySaverPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_picker, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
    }
    try {
      com.rioapp.demo.imeiplugin.ImeiPlugin.registerWith(shimPluginRegistry.registrarFor("com.rioapp.demo.imeiplugin.ImeiPlugin"));
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin imei_plugin, com.rioapp.demo.imeiplugin.ImeiPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin permission_handler, com.baseflow.permissionhandler.PermissionHandlerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.share.SharePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin share, io.flutter.plugins.share.SharePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.twwm.share_files_and_screenshot_widgets.ShareFilesAndScreenshotWidgetsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin share_files_and_screenshot_widgets, com.twwm.share_files_and_screenshot_widgets.ShareFilesAndScreenshotWidgetsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
  }
}
