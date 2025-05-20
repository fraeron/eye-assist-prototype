<?php
class Auth {
    private $db;
    
    // Constructor to initialize the DB connection
    public function __construct() {
        // Include the database connection
        require_once 'db.php';
        $this->db = $db;
    }

    // Function to authenticate the user based on an API token
    public function authenticate($token) {
        // Look for the token in the database (for simplicity, we're assuming the token is stored in the 'api_tokens' table)
        $query = "SELECT * FROM api_tokens WHERE token = ?";
        $stmt = $this->db->prepare($query);
        $stmt->bind_param('s', $token);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            // If token exists and is valid, return the user ID
            $user = $result->fetch_assoc();
            return $user['user_id']; // Return the authenticated user's ID
        }
        
        // If no token is found, authentication fails
        return false;
    }
}
?>
