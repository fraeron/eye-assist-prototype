plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

android {
    namespace = "com.example.eaprototype"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.eaprototype"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.activity)
    implementation(libs.androidx.constraintlayout)
    implementation(libs.play.services.location)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)

    // Retrofit for making network calls
    implementation("com.squareup.retrofit2:retrofit:2.9.0")

    // Gson Converter for converting JSON responses to Kotlin objects, much easier
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")

    // OkHttp logging interceptor (for logging HTTP requests)
    implementation("com.squareup.okhttp3:logging-interceptor:4.9.0")

    // For splash screen.
    implementation("androidx.core:core-splashscreen:1.0.0")
}