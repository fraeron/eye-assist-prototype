package com.example.eaprototype

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query

interface ApiService {
    // Endpoint for user login.
    @POST("login.php")
    fun login(@Body loginRequest: LoginRequest): Call<LoginResponse>

    // Endpoint for OTP verification.
    @POST("verify_otp.php")
    fun verifyOtp(@Body otpRequest: OtpRequest): Call<OtpResponse>

    @GET("sensor_data.php")
    fun getSensorData(@Query("api_token") apiToken: String): Call<SensorResponse>

    @FormUrlEncoded
    @POST("navigation_logs.php")
    fun sendNavigationLog(
        @Field("user_id") userId: Int,
        @Field("page_name") pageName: String
    ): Call<SensorDashResponse>

}