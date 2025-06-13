package com.example.eaprototype

data class OtpResponse(
    val success: Boolean,
    val message: String,
    val token: String,
    val userId: Int
)