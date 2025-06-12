package com.example.eaprototype

import com.google.gson.annotations.SerializedName

data class SensorData(
    @SerializedName("user_id")
    val userId: Int
)