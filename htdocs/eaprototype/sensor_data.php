<?php
// Include database connection and authentication
require_once 'db.php';
require_once 'auth.php';  // A custom script to authenticate API requests (e.g., token-based)

header('Content-Type: application/json');

// Authenticate the user via API token
$auth = new Auth();
$token = $_GET['api_token'];
$user_id = $auth->authenticate($token);

if ($user_id) {
    // Query for sensor data (e.g., GPS coordinates)
    $query = "SELECT * FROM sensor_data WHERE user_id = ?";
    $stmt = $db->prepare($query);
    $stmt->bind_param('i', $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $data = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode(['success' => true, 'data' => $data]);
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid API token']);
}
?>
