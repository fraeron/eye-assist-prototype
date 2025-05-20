<?php

// Include database connection
require_once 'db.php';

// Expect JSON as POST data then decode.
$rawData = file_get_contents('php://input');    
$data = json_decode($rawData);

if ($data === null) {
    // Handle the error if the JSON is invalid
    echo json_encode(["success" => false, "message" => "Invalid JSON format."]);
    exit(); // Stop execution if JSON is invalid
}

if (isset($data->username) && isset($data->otp)) {
    $username = $data->username;
    $otp = $data->otp;

    // Query the database to get the user ID
    $query = "SELECT * FROM admins WHERE username = ?";
    $stmt = $db->prepare($query);
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if ($user) {
        // Check the OTP in the mfa_tokens table
        $stmt = $db->prepare("SELECT * FROM mfa_tokens WHERE admin_id = ? AND token = ? AND expires_at > NOW()");
        // $stmt = $db->prepare("SELECT * FROM mfa_tokens WHERE admin_id = ? AND token = ?");
        $stmt->bind_param('is', $user['id'], $otp);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            // OTP is valid
            echo json_encode(['success' => true, 'message' => 'OTP Verified']);
        } else {
            // Invalid OTP or expired
            echo json_encode(['success' => false, 'message' => 'Invalid or expired OTP']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'User not found']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Wtf is this sh*t']);
}
?>
