package com.example.eaprototype

import android.Manifest
import android.content.pm.PackageManager
import android.location.Location
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.RequiresPermission
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class DashboardActivity : AppCompatActivity() {

    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private var userId: Int = -1

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1001
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_dashboard)

        // Initialize location client
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

        // Get userId from Intent extras
        userId = intent.getIntExtra("USER_ID", -1)

        // Check for missing user ID
        if (userId == -1) {
            Toast.makeText(this, "User ID missing. Please login again.", Toast.LENGTH_LONG).show()
            finish()
            return
        }

        // Request location permission if not granted
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                LOCATION_PERMISSION_REQUEST_CODE
            )
        } else {
            sendNavigationWithLocation()
        }

        val logoutBtn = findViewById<Button>(R.id.btn_logout)
        logoutBtn.setOnClickListener {
            finish() // or navigate to login activity
        }
    }

    @RequiresPermission(allOf = [Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION])
    private fun sendNavigationWithLocation() {
        fusedLocationClient.lastLocation.addOnSuccessListener { location: Location? ->
            val latitude = location?.latitude?.toString() ?: ""
            val longitude = location?.longitude?.toString() ?: ""
            val currentTime = getCurrentTimestamp()

            // Call Retrofit API to send navigation log with location
            RetrofitClient.instance.sendNavigationLog(
                userId,
                "DashboardActivity",
                latitude,
                longitude,
                currentTime
            ).enqueue(object : Callback<SensorDashResponse> {
                override fun onResponse(
                    call: Call<SensorDashResponse>,
                    response: Response<SensorDashResponse>
                ) {
                    if (response.isSuccessful && response.body()?.success == true) {
                        // Successfully logged navigation
                    } else {
                        // Handle API error if needed
                    }
                }

                override fun onFailure(call: Call<SensorDashResponse>, t: Throwable) {
                    // Handle network failure if needed
                }
            })
        }
    }

    private fun getCurrentTimestamp(): String {
        val sdf = java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.getDefault())
        return sdf.format(java.util.Date())
    }

    // Handle the location permission request result
    @RequiresPermission(allOf = [Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION])
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == LOCATION_PERMISSION_REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                sendNavigationWithLocation()
            } else {
                Toast.makeText(
                    this,
                    "Location permission denied. Navigation logs will not include location.",
                    Toast.LENGTH_LONG
                ).show()
                // Optionally send navigation log without location here if you want
            }
        }
    }
}
