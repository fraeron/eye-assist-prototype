package com.example.eaprototype

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface ApiService {
    // Endpoint for user login.
    @POST("login.php")
    fun login(@Body loginRequest: LoginRequest): Call<LoginResponse>

    // Endpoint for OTP verification.
    @POST("verify_otp.php")
    fun verifyOtp(@Body otpRequest: OtpRequest): Call<OtpResponse>
}