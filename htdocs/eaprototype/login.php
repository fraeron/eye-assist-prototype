<?php
require_once 'db.php';
session_start(); // Required for setting session variables

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Expect JSON as POST data then decode.
    $rawData = file_get_contents('php://input');
    $data = json_decode($rawData);

    if ($data === null) {
        echo json_encode(["success" => false, "message" => "Invalid JSON format."]);
        exit();
    }

    if (isset($data->username) && isset($data->password)) {
        $username = $data->username;
        $password = $data->password;

        $query = "SELECT * FROM admins WHERE username = ?";
        $stmt = $db->prepare($query);
        $stmt->bind_param('s', $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user) {
            $user_ip = $_SERVER['REMOTE_ADDR'] === '::1' ? '127.0.0.1' : $_SERVER['REMOTE_ADDR'];


            if (password_verify($password, $user['password'])) {
                // Check if IP is allowed
                $stmt_ip = $db->prepare("SELECT * FROM allowed_ip WHERE allowed = ?");
                $stmt_ip->bind_param('s', $user_ip);
                $stmt_ip->execute();
                $ip_result = $stmt_ip->get_result();

                if ($ip_result->num_rows === 0) {
                    echo json_encode([
                        'success' => false,
                        'message' => 'Access denied from this IP address.',
                        'ip' => $user_ip
                    ]);
                    exit();
                }

                // Reset failed attempts
                $stmt = $db->prepare("UPDATE admins SET failed_attempts = 0 WHERE id = ?");
                $stmt->bind_param('i', $user['id']);
                $stmt->execute();

                // Proceed with OTP
                $otp = rand(100000, 999999);

                date_default_timezone_set('Asia/Manila');
                $startTime = date("Y-m-d H:i:s");
                $expires_at = date('Y-m-d H:i:s', strtotime('+2 minutes', strtotime($startTime)));

                $stmt = $db->prepare("INSERT INTO mfa_tokens (admin_id, token, expires_at) VALUES (?, ?, ?)");
                $stmt->bind_param('iss', $user['id'], $otp, $expires_at);
                $stmt->execute();

                // Simulate email sending (replace with actual PHPMailer)
                $subject = "Your OTP Code";
                $message = "Your OTP code is: $otp";

                $_SESSION['username'] = $username;
                $_SESSION['otp'] = $otp;

                echo json_encode(['success' => true,
                'message' => 'OTP sent',
                'requiresOtp' => true,
                'ahahahah' => $message . $startTime . $user_ip]);
            } else {
                // Invalid password — increment attempts
                $stmt = $db->prepare("UPDATE admins SET failed_attempts = failed_attempts + 1 WHERE id = ?");
                $stmt->bind_param('i', $user['id']);
                $stmt->execute();

                if ($user['failed_attempts'] >= 5) {
                    $lock_until = date('Y-m-d H:i:s', strtotime('+30 minutes'));
                    $stmt = $db->prepare("UPDATE admins SET lock_until = ? WHERE id = ?");
                    $stmt->bind_param('si', $lock_until, $user['id']);
                    $stmt->execute();

                    echo json_encode([
                        'success' => false,
                        'message' => 'Too many failed attempts. Account locked for 30 minutes.'
                    ]);
                } else {
                    echo json_encode([
                        'success' => false,
                        'message' => 'Invalid credentials'
                    ]);
                }
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'User not found']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Username and password required.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Incorrect request.']);
}
?>
