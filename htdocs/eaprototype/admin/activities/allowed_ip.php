<?php 
include '../header.php'; 
require_once "../../db.php";

$sql = "SELECT allowed FROM allowed_ip";
$result = $db->query($sql);

$allowed_ips = [];

if ($result->num_rows > 0) {
    // Fetch data into an array
    while ($row = $result->fetch_assoc()) {
        $allowed_ips[] = $row['allowed'];
    }
} else {
    echo "No allowed IPs found.";
}

?>

<style>
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        .ip-list {
            margin-top: 20px;
            width: 80%;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .ip-list ul {
            list-style-type: none;
            padding: 0;
        }
        .ip-list li {
            padding: 10px;
            margin: 8px 0;
            background-color: #e0f7fa;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        .ip-list li:nth-child(odd) {
            background-color: #f1f8e9;
        }
    </style>

<h1>Allowed IPs</h1>
<div class="ip-list">
    <ul>
        <?php foreach ($allowed_ips as $ip): ?>
            <li><?php echo htmlspecialchars($ip); ?></li>
        <?php endforeach; ?>
    </ul>
</div>

<?php include '../footer.php'; ?>