package com.example.eaprototype

data class SensorResponse(
    val success: Boolean,
    val data: List<SensorData>?
)