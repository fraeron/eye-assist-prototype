<?php

/*
    ERROR AND STATUS TYPES:
    "OK"                    -> OK.
    "DENIED_IP"             -> IP is not allowed error.
    "MULTIPLE_ATTEMPTS"     -> Too many login attempts.
    "LOCKED_ACC"            -> Locked account.

*/



require_once 'db.php';
session_start(); // Required for session variables

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    date_default_timezone_set('Asia/Manila');

    $rawData = file_get_contents('php://input');
    $data = json_decode($rawData);

    if ($data === null) {
        echo json_encode(["success" => false, "message" => "Invalid JSON format."]);
        exit();
    }

    if (isset($data->username) && isset($data->password)) {
        $username = $data->username;
        $password = $data->password;

        // Initialize session login attempts
        if (!isset($_SESSION['login_attempts'])) {
            $_SESSION['login_attempts'] = 0;
        }

        // Too many attempts in session
        if ($_SESSION['login_attempts'] >= 5) {
            echo json_encode([
                "success" => false,
                "message" => "Too many login attempts from this session. Please wait before retrying.",
                "type" => "MULTIPLE_ATTEMPTS"
            ]);
            exit();
        }

        $query = "SELECT * FROM admins WHERE username = ?";
        $stmt = $db->prepare($query);
        $stmt->bind_param('s', $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user) {
            $current_time = date('Y-m-d H:i:s');

            // Check if the account is locked
            if (!is_null($user['lock_until']) && $user['lock_until'] > $current_time) {
                echo json_encode([
                    'success' => false,
                    'type' => 'LOCKED_ACC',
                    'message' => 'Account is locked until ' . $user['lock_until']
                ]);
                exit();
            }

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
                        'type' => 'DENIED_IP',
                        'ip' => $user_ip
                    ]);
                    exit();
                }

                // Reset all failed attempts
                $stmt = $db->prepare("UPDATE admins SET failed_attempts = 0, lock_until = NULL WHERE id = ?");
                $stmt->bind_param('i', $user['id']);
                $stmt->execute();

                $_SESSION['login_attempts'] = 0; // Reset session attempts

                // Proceed with OTP
                $otp = rand(100000, 999999);
                $startTime = date("Y-m-d H:i:s");
                $expires_at = date('Y-m-d H:i:s', strtotime('+2 minutes', strtotime($startTime)));

                $stmt = $db->prepare("INSERT INTO mfa_tokens (admin_id, token, expires_at) VALUES (?, ?, ?)");
                $stmt->bind_param('iss', $user['id'], $otp, $expires_at);
                $stmt->execute();

                $_SESSION['username'] = $username;
                $_SESSION['otp'] = $otp;

                echo json_encode([
                    'success' => true,
                    'message' => 'OTP is sent to your email.',
                    'otp' => $otp,
                    'requiresOtp' => true,
                    'allowedIP' => true,
                    'ip' => $user_ip
                ]);
            } else {
                // Wrong password — increment failed attempts in DB
                $new_attempts = $user['failed_attempts'] + 1;

                $stmt = $db->prepare("UPDATE admins SET failed_attempts = ? WHERE id = ?");
                $stmt->bind_param('ii', $new_attempts, $user['id']);
                $stmt->execute();

                $_SESSION['login_attempts']++;

                if ($new_attempts >= 5) {
                    $lock_until = date('Y-m-d H:i:s', strtotime('+30 minutes'));
                    $stmt = $db->prepare("UPDATE admins SET lock_until = ? WHERE id = ?");
                    $stmt->bind_param('si', $lock_until, $user['id']);
                    $stmt->execute();

                    echo json_encode([
                        'success' => false,
                        'type' => 'LOCKED_ACC',
                        'message' => 'Too many failed attempts. Account locked until ' . $lock_until
                    ]);
                } else {
                    echo json_encode([
                        'success' => false,
                        'message' => 'Invalid credentials. Attempt ' . $new_attempts . ' of 5.'
                    ]);
                }
            }
        } else {
            $_SESSION['login_attempts']++;
            echo json_encode(['success' => false, 'message' => 'User not found.']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Username and password required.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Incorrect request method.']);
}
