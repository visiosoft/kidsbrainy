# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Lottie
-keep class com.airbnb.lottie.** { *; }

# Okio
-keep class okio.** { *; }
-keep class javax.annotation.** { *; }
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement

# Audio Players
-keep class xyz.luan.audioplayers.** { *; }

# Google Play Core
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.**

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep Parcelable classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep R classes
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep custom application class
-keep public class * extends android.app.Application

# Keep custom views
-keep public class * extends android.view.View
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Keep Flutter deferred components
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; } 