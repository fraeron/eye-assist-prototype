<?php
require_once 'db.php';

ob_clean(); // clear any previous output buffer
header('Content-Type: application/json');
$rawData = file_get_contents('php://input');
$data = json_decode($rawData);

if ($data === null) {
    echo json_encode(["success" => false, "message" => "Invalid JSON format."]);
    exit();
}

if (isset($data->username) && isset($data->otp)) {
    $username = $data->username;
    $otp = $data->otp;

    $query = "SELECT * FROM admins WHERE username = ?";
    $stmt = $db->prepare($query);
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if ($user) {
        $stmt = $db->prepare("SELECT * FROM mfa_tokens WHERE admin_id = ? AND token = ? AND expires_at > NOW()");
        $stmt->bind_param('is', $user['id'], $otp);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Generate secure token
            $token = bin2hex(random_bytes(32)); // 64-character hex token
            $userId = $user['id'];
            $createdAt = date('Y-m-d H:i:s');
            $expiresAt = date('Y-m-d H:i:s', strtotime('+1 minute')); 

            // Insert into api_token table
            $stmt = $db->prepare("INSERT INTO api_tokens (user_id, token, created_at, expires_at) VALUES (?, ?, ?, ?)");
            $stmt->bind_param('isss', $userId, $token, $createdAt, $expiresAt);
            $stmt->execute();

            echo json_encode([
                'success' => true,
                'message' => 'OTP Verified',
                'token' => $token,
                'userId' => $userId
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Invalid or expired OTP']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'User not found']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Missing username or OTP']);
}
