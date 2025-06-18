package com.example.eaprototype

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


object RetrofitClient {
    private const val BASE_URL = "http://192.168.1.19/eaprototype/" //change in accordance to your device ip

    private var gson: Gson = GsonBuilder()
        .setLenient()
        .create()

    private val loggingInterceptor = HttpLoggingInterceptor().apply {
        level = HttpLoggingInterceptor.Level.BODY
    }

    private val client = OkHttpClient.Builder()
        .addInterceptor(loggingInterceptor) // For logging.
//        .addInterceptor(RemoveHeadersInterceptor()) // Custom interceptor to parse response.
        .build()

    val instance: ApiService
        get() {
            return Retrofit.Builder()
                .baseUrl(BASE_URL)
                .client(client) // Optional and remove upon release: Use the custom OkHttpClient with interceptors.

                // Use Gson for JSON parsing.
                // NOTE: If there would be any problems regarding to JSON this is most likely
                //      the one that's going to scream errors.
                .addConverterFactory(GsonConverterFactory.create(gson))

                .build()
                .create(ApiService::class.java)
        }
}