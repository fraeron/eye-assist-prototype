package com.example.eaprototype

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import android.content.Intent


class DashboardActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_dashboard)

        // Add functionality to logout button.
        val logoutBtn = findViewById<Button>(R.id.btn_logout)
        logoutBtn.setOnClickListener {
            logoutUser()
        }
    }

    private fun logoutUser() {
        // Prepare and start login activity.
        val loginIntent = Intent(this, LoginActivity::class.java)
        startActivity(loginIntent)

        // Finish the current activity to remove it from the back stack.
        finish()
    }
}