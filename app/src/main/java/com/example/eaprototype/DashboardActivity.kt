package com.example.eaprototype

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import android.content.Intent
import android.util.Log
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class DashboardActivity : AppCompatActivity() {
    private lateinit var apiToken: String
    private var userId: Int = -1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_dashboard)

        // Retrieve token and user ID from intent
        apiToken = intent.getStringExtra("API_TOKEN") ?: ""
        userId = intent.getIntExtra("USER_ID", -1)

        // Log for debugging
        Log.d("DashboardActivity", "API Token: $apiToken")
        Log.d("DashboardActivity", "User ID: $userId")

        // Check for missing credentials
        if (apiToken.isEmpty() || userId == -1) {
            Toast.makeText(this, "Authentication data missing. Redirecting to login...", Toast.LENGTH_LONG).show()
            startActivity(Intent(this, LoginActivity::class.java))
            finish()
            return
        }

        // UI elements
        val logoutBtn = findViewById<Button>(R.id.btn_logout)
        val sensorText = findViewById<TextView>(R.id.sensor_data_text)

        // Fetch sensor data
        RetrofitClient.instance.getSensorData(apiToken).enqueue(object : Callback<SensorResponse> {
            override fun onResponse(call: Call<SensorResponse>, response: Response<SensorResponse>) {
                Log.d("RawResponse", response.body().toString())
                Log.d("RawJSON", response.errorBody()?.string() ?: "No error body")

                if (response.isSuccessful && response.body()?.success == true) {
                    val sensorData = response.body()?.data
                    sensorText.text = sensorData?.joinToString("\n") {
                        "Sensor record found for user ID: ${it.userId}"
                    } ?: "No sensor data available."
                } else {
                    sensorText.text = "Failed to load sensor data."
                    Log.e("SensorResponse", "Response not successful or body is null")
                }
            }

            override fun onFailure(call: Call<SensorResponse>, t: Throwable) {
                sensorText.text = "Error: ${t.message}"
            }
        })

        // Log user navigation to this page
        RetrofitClient.instance.sendNavigationLog(userId, "DashboardActivity")
            .enqueue(object : Callback<SensorDashResponse> {
                override fun onResponse(call: Call<SensorDashResponse>, response: Response<SensorDashResponse>) {
                    Log.d("NavigationLog", "Logged successfully.")
                }

                override fun onFailure(call: Call<SensorDashResponse>, t: Throwable) {
                    Log.e("NavigationLog", "Failed to log navigation.")
                }
            })

        // Logout action
        logoutBtn.setOnClickListener {
            val loginIntent = Intent(this, LoginActivity::class.java)
            startActivity(loginIntent)
            finish()
        }
    }
}
