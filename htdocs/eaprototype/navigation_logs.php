<?php
// Include database connection
require_once 'db.php';

// Get the request data (e.g., page name, user ID, etc.)
$user_id = $_POST['user_id'];
$page_name = $_POST['page_name'];  // Name of the page the user visited

// Encrypt the navigation data
$encryption_key = 'your-secret-key';
$encrypted_data = openssl_encrypt($page_name, 'aes-256-cbc', $encryption_key, 0, '1234567890123456');

// Store the encrypted log
$stmt = $db->prepare("INSERT INTO navigation_logs (user_id, encrypted_page_name) VALUES (?, ?)");
$stmt->bind_param('is', $user_id, $encrypted_data);
$stmt->execute();

echo json_encode(['success' => true, 'message' => 'Navigation log saved']);
?>
