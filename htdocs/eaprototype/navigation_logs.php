<?php
require_once 'db.php';

// Receive POST data
$user_id = $_POST['user_id'] ?? null;
$last_latitude = $_POST['last_latitude'] ?? '';
$last_longitude = $_POST['last_longitude'] ?? '';
$time = $_POST['time'] ?? date("Y-m-d H:i:s"); // Use current time if not provided
$page_name = $_POST['page_name'] ?? '';

// Validate required field
if (!$user_id) {
    echo json_encode(['success' => false, 'message' => 'Missing user_id']);
    exit;
}

// Encryption setup
$cipher_method = 'aes-256-cbc'; // Note to team: Use VARCHAR(44) because we used aes-256 
$encryption_key = 'your-very-secure-32-byte-key-here!'; // Must be 32 bytes
$iv_length = openssl_cipher_iv_length($cipher_method); // "iv" means Initalization Vector.
$iv = openssl_random_pseudo_bytes($iv_length);

// Combine data to encrypt
$data_to_encrypt = json_encode([
    'latitude' => $last_latitude,
    'longitude' => $last_longitude,
    'time' => $time,
    'page_name' => $page_name
]);

// Encrypt and encode
$encrypted_data = openssl_encrypt($data_to_encrypt, $cipher_method, $encryption_key, 0, $iv);
$encrypted_data_base64 = base64_encode($encrypted_data);
$iv_base64 = base64_encode($iv);

// Insert into database including raw values
$stmt = $db->prepare("INSERT INTO user_navigational_activity
    (user_id, encrypted_page_name, iv, last_latitude, last_longitude, time) 
    VALUES (?, ?, ?, ?, ?, ?)");

$stmt->bind_param('isssss', $user_id, $encrypted_data_base64, $iv_base64, $last_latitude, $last_longitude, $time);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    echo json_encode(['success' => true, 'message' => 'Encrypted navigation data saved']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to save data']);
}
?>
