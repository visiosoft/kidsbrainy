package com.example.kids_learning

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.Window
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import com.airbnb.lottie.LottieAnimationView
import com.airbnb.lottie.LottieDrawable

class SplashActivity : AppCompatActivity() {

    private var animationView: LottieAnimationView? = null
    
    override fun onCreate(savedInstanceState: Bundle?) {
        // Set window flags for faster rendering
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        )
        
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        // Setup animation - optimize for speed
        animationView = findViewById(R.id.animationView)
        animationView?.apply {
            setAnimation(R.raw.splash_animation)
            repeatCount = 0
            enableMergePathsForKitKatAndAbove(true)
            // Force animation to start immediately
            playAnimation()
            // Hardware acceleration is already enabled in the layout XML
        }

        // Return to MainActivity after animation or after timeout
        Handler(Looper.getMainLooper()).postDelayed({
            finish()
        }, 5000)
    }

    override fun onDestroy() {
        animationView?.cancelAnimation()
        animationView = null
        super.onDestroy()
    }
}