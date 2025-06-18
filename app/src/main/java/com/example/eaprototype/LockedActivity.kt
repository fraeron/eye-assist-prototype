package com.example.eaprototype

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import android.content.Intent

class LockedActivity : AppCompatActivity()  {
    private lateinit var returnBtn: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Set current activity to utilize.
        setContentView(R.layout.activity_locked)

        // Init. variables.
        returnBtn = findViewById(R.id.returnBtn)

        // Add event listener to return button.
        returnBtn.setOnClickListener {
            startActivity(Intent( this, LoginActivity::class.java))
        }
    }
}