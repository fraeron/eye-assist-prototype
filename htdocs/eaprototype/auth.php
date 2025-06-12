<?php
class Auth {
    private $db;

    public function __construct() {
        require_once 'db.php';
        $this->db = $db;
    }

    public function authenticate($token) {
        $query = "SELECT * FROM api_tokens WHERE token = ?";
        $stmt = $this->db->prepare($query);
        $stmt->bind_param('s', $token);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            $now = date('Y-m-d H:i:s');
            if ($user['expires_at'] > $now) {
                return $user['user_id'];
            }
        }
        return false;
    }
}
?>
