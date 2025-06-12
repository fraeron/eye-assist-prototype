package com.example.eaprototype

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class OtpActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_otp)

        val etOtp = findViewById<EditText>(R.id.et_otp)
        val btnSubmitOtp = findViewById<Button>(R.id.btn_submit_otp)

        // Get username from intent, works like sessions in PHP.
        val username = intent.getStringExtra("Username")

        btnSubmitOtp.setOnClickListener {
            val otp = etOtp.text.toString()

            // Create OTP request object.
            val otpRequest = OtpRequest(username ?: "", otp)

            // Call API to verify OTP.
            RetrofitClient.instance.verifyOtp(otpRequest).enqueue(object : Callback<OtpResponse> {
                override fun onResponse(call: Call<OtpResponse>, response: Response<OtpResponse>) {
                    if (response.isSuccessful) {
                        val otpResponse = response.body()
                        if (otpResponse != null && otpResponse.success) {
                            Toast.makeText(this@OtpActivity, "OTP verified!", Toast.LENGTH_SHORT).show()

                            // Use real values from server
                            val apiToken = otpResponse.token
                            val userId = otpResponse.userId
                            navigateToDashboard(apiToken, userId)
                        } else {
                            // OTP verification failed, show error.
                            Toast.makeText(this@OtpActivity, "Invalid OTP", Toast.LENGTH_SHORT).show()
                        }
                    } else {
                        Toast.makeText(this@OtpActivity, "OTP verification failed", Toast.LENGTH_SHORT).show()
                    }
                }

                override fun onFailure(call: Call<OtpResponse>, t: Throwable) {
                    Toast.makeText(this@OtpActivity, "Failed: ${t.message}", Toast.LENGTH_SHORT).show()
                }
            })
        }
    }

    private fun navigateToDashboard(token: String, userId: Int) {
        val intent = Intent(this, DashboardActivity::class.java)
        intent.putExtra("API_TOKEN", token)
        intent.putExtra("USER_ID", userId)
        startActivity(intent)
        finish()
    }
}