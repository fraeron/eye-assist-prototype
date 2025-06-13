package com.example.eaprototype

import com.google.gson.annotations.SerializedName

data class LoginResponse(
    val success: Boolean,
    val message: String,
    val requiresOtp: Boolean,
    val allowedIP: Boolean
)