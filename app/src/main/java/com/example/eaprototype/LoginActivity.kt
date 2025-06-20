package com.example.eaprototype

import android.content.Intent
import android.os.Bundle
import android.text.InputType
import android.view.MotionEvent
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

        // Set up a touch listener to detect clicks on the drawableEnd (eye icon)
//        passwordInput.setOnTouchListener { v, event ->
//            if (event.action == MotionEvent.ACTION_UP) {
//                val drawableEnd = passwordInput.compoundDrawablesRelative[2] // Get drawableEnd (eye icon)
//                if (drawableEnd != null && event.rawX >= (passwordInput.right - drawableEnd.bounds.width())) {
//                    // Toggle password visibility on click of eye icon
//                    togglePasswordVisibility()
//                }
//            }
//            false
//        }
    }

    // Function to toggle password visibility
//    private fun togglePasswordVisibility() {
//        val currentInputType = passwordInput.inputType
//        if (currentInputType == (InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD)) {
//            passwordInput.inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD
//            passwordInput.setCompoundDrawablesRelativeWithIntrinsicBounds(0, 0, R.drawable.visibility_24px, 0) // Show icon
//        } else {
//            passwordInput.inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
//            passwordInput.setCompoundDrawablesRelativeWithIntrinsicBounds(0, 0, R.drawable.visibility_off_24px, 0) // Hide icon
//        }
//
//
//
//        // Move the cursor to the end of the text after changing the input type
//        passwordInput.setSelection(passwordInput.text.length)
//    }

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
                            // Check if IP is allowed

                            // REQUIREMENT 4
                            if (!res.allowedIP) {
                                Toast.makeText(this@LoginActivity, "Access denied: IP not allowed", Toast.LENGTH_LONG).show()
                                return
                            }

                            Toast.makeText(this@LoginActivity, "Success: ${res.message}", Toast.LENGTH_LONG).show()

                            // Check if OTP is required.
                            if (res.requiresOtp) {
                                Toast.makeText(this@LoginActivity, "OTP required", Toast.LENGTH_LONG).show()

                                // Save username in intent to refer later in OTP activity.
                                val intent = Intent(this@LoginActivity, OtpActivity::class.java)
                                intent.putExtra("Username", username)

                                // Change layout to OTP screen.
                                startActivity(intent)
                            } else {
                                Toast.makeText(this@LoginActivity, "OTP check is down. Try again later.", Toast.LENGTH_LONG).show()
                            }
                        } else {
                            if (res.type == "LOCKED_ACC") {
                                startActivity(Intent(this@LoginActivity, LockedActivity::class.java))
                            }
                            else Toast.makeText(this@LoginActivity, "Failed: ${res.message}", Toast.LENGTH_LONG).show()
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
