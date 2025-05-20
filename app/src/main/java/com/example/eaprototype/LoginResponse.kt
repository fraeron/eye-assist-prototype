package com.example.eaprototype

data class LoginResponse(
    val success: Boolean,
    val message: String,
    val requiresOtp: Boolean
)