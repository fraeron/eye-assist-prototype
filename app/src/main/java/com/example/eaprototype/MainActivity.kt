package com.example.eaprototype

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Launch LoginActivity as soon as MainActivity is loaded
        val intent = Intent(this, LoginActivity::class.java)
        startActivity(intent)

        // Optionally, you can call finish() to close MainActivity after the transition
        finish()
    }
}