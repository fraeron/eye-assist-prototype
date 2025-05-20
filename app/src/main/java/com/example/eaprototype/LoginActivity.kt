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

class LoginActivity : AppCompatActivity() {
    private lateinit var usernameInput: EditText
    private lateinit var passwordInput: EditText
    private lateinit var loginBtn: Button

    // Start activity.
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Set current activity to utilize.
        setContentView(R.layout.activity_login)

        // Init. variables.
        usernameInput = findViewById(R.id.et_username)
        passwordInput = findViewById(R.id.et_password)
        loginBtn = findViewById(R.id.btn_login)

        // Add event listener to login button.
        loginBtn.setOnClickListener {
            loginUser()
        }
    }

    // Do login when triggered.
    private fun loginUser() {
        val username = usernameInput.text.toString().trim()
        val password = passwordInput.text.toString().trim()

        if (username.isEmpty() || password.isEmpty()) {
            Toast.makeText(this, "Enter all fields", Toast.LENGTH_SHORT).show()
            return
        }

        val request = LoginRequest(username=username, password=password)

        // Use custom Retrofit2 to do API calls. You have no idea how long I was stuck in here.
        RetrofitClient.instance.login(request).enqueue(object : Callback<LoginResponse> {
            override fun onResponse(call: Call<LoginResponse>, response: Response<LoginResponse>) {
                if (response.isSuccessful) {
                    val res = response.body()
                    if (res != null) {
                        if (res.success) {
                            Toast.makeText(this@LoginActivity, "Success: ${res.message}", Toast.LENGTH_LONG).show()

                            // Check if OTP is required.
                            if (res.requiresOtp) {
                                // OTP is required, proceed to OTP screen.
                                Toast.makeText(this@LoginActivity, "OTP required", Toast.LENGTH_LONG).show()

                                // Save username in intent to refer later in OTP activity.
                                val intent = Intent(this@LoginActivity, OtpActivity::class.java)
                                intent.putExtra("Username", username);

                                // Change layout to OTP screen.
                                startActivity(intent)
                            } else {
                                Toast.makeText(this@LoginActivity, "OTP check is down. Try again later.", Toast.LENGTH_LONG).show()
                            }

                        } else {
                            Toast.makeText(this@LoginActivity, "Failed: ${res.message}", Toast.LENGTH_LONG).show()
                        }
                    }
                } else {
                    Toast.makeText(this@LoginActivity, "Server error: ${response.code()}", Toast.LENGTH_LONG).show()
                }
            }

            override fun onFailure(call: Call<LoginResponse>, t: Throwable) {
                Toast.makeText(this@LoginActivity, "Network error: ${t.message}", Toast.LENGTH_LONG).show()
            }
        })
    }
}
