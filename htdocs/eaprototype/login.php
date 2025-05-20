<?php
require_once 'db.php';

header('Content-Type: application/json');


if ($_SERVER['REQUEST_METHOD'] === 'POST')  {

    // Expect JSON as POST data then decode.
    $rawData = file_get_contents('php://input');    
    $data = json_decode($rawData);

    if ($data === null) {
        // Handle the error if the JSON is invalid
        echo json_encode(["success" => false, "message" => "Invalid JSON format."]);
        exit(); // Stop execution if JSON is invalid
    }

    // Access the data
    if (isset($data->username) && isset($data->password)) {
        $username = $data->username;
        $password = $data->password;

        // Query the database for the admin user
        $query = "SELECT * FROM admins WHERE username = ?";
        $stmt = $db->prepare($query);
        $stmt->bind_param('s', $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        // Check if the account is locked
        // if ($user['lock_until'] && strtotime($user['lock_until']) > time()) {
        //     echo json_encode(['success' => false, 'message' => 'Account locked. Please try again later.']);
        //     exit;
        // }

        // Get the user's IP address
        $user_ip = $_SERVER['REMOTE_ADDR'];

        // You can use a service like ipinfo.io to get the user's location
        // $location = file_get_contents("http://ipinfo.io/{$user_ip}/json");
        // $location_data = json_decode($location, true);

        // Check if the user's IP is from an allowed region (e.g., USA only)
        // $allowed_regions = ['US'];
        // if (!in_array($location_data['country'], $allowed_regions)) {
        //     echo json_encode(['success' => false, 'message' => 'Access from this region is not allowed']);
        //     exit;
        // }

        // Check the password and update failed attempts


    if (password_verify($password, $user['password'])) {
        // Reset failed attempts if login is successful
        $stmt = $db->prepare("UPDATE admins SET failed_attempts = 0 WHERE id = ?");
        $stmt->bind_param('i', $user['id']);
        $stmt->execute();

        // Continue with MFA...
        // Check if user exists and the password matches
        if ($user && password_verify($password, $user['password'])) {
            // Generate OTP and send it via email
            $otp = rand(100000, 999999); // 6-digit OTP

            date_default_timezone_set('Asia/Manila');
            $startTime = date("Y-m-d H:i:s");
            $expires_at = date('Y-m-d H:i:s', strtotime('+2 minutes', strtotime($startTime)));

            // Save OTP to database
            $stmt = $db->prepare("INSERT INTO mfa_tokens (admin_id, token, expires_at) VALUES (?, ?, ?)");
            $stmt->bind_param('iss', $user['id'], $otp, $expires_at);
            $stmt->execute();

            // Send OTP via email (use PHPMailer for this)
            $subject = "Your OTP Code";
            $message = "Your OTP code is: $otp";

            // Set session.
            $_SESSION['username'] = $username;
            $_SESSION['otp'] = $otp;
            // mail($user['email'], $subject, $message);

            // Return response
            echo json_encode(['success' => true, 'message' => 'OTP sent', 'requiresOtp' => true, 'ahahahah' => $message . $startTime]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Invalid credentials']);
            }

        } else {
            // Increment failed attempts
            $stmt = $db->prepare("UPDATE admins SET failed_attempts = failed_attempts + 1 WHERE id = ?");
            $stmt->bind_param('i', $user['id']);
            $stmt->execute();

            // Lock account after 5 failed attempts
            if ($user['failed_attempts'] >= 5) {
                $lock_until = date('Y-m-d H:i:s', strtotime('+30 minutes')); // Lock for 30 minutes
                $stmt = $db->prepare("UPDATE admins SET lock_until = ? WHERE id = ?");
                $stmt->bind_param('si', $lock_until, $user['id']);
                $stmt->execute();
                
                echo json_encode(['success' => false, 'message' => 'Too many failed attempts. Account locked for 30 minutes.']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Invalid credentials']);
            }
        }
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Incorrect request.']);
}

?>
