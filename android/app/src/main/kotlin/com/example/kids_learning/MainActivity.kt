package com.example.kids_learning

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.TransparencyMode
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    companion object {
        private var isSplashShown = false
    }

    override fun getTransparencyMode(): TransparencyMode {
        return TransparencyMode.transparent
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        // Launch SplashActivity if it hasn't been shown yet - do this before super.onCreate()
        if (!isSplashShown) {
            isSplashShown = true
            startActivity(Intent(this, SplashActivity::class.java))
        }
        
        super.onCreate(savedInstanceState)
        
        // Set window flags for fullscreen
        window.setFlags(
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS
        )
    }

    override fun onFlutterUiDisplayed() {
        super.onFlutterUiDisplayed()
        
        // Set fullscreen flags
        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
                View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
                View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
    }
}
