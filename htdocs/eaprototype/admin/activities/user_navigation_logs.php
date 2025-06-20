<?php 

include '../header.php'; 

require_once "../../db.php";

$sql = "SELECT user_id, last_latitude, last_longitude, time, encrypted_page_name, iv FROM user_navigational_activity ORDER BY time DESC";
$result = $db->query($sql);

$logs = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $logs[] = $row;
    }
} else {
    echo "No user navigation activity found.";
}

?>
<style>
        h1 {
        text-align: center;
        color: #2e7d32;
    }
    .table-container {
        margin: 20px auto;
        width: 100%; /* Take up full width of the parent */
        max-width: 100%; /* No max-width limitation */
        overflow-x: auto; /* Enable horizontal scrolling on small screens */
    }
    .log-table {
        width: 100%; /* Full width of its parent */
        border-collapse: collapse;
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    }
    .log-table th, .log-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #ddd;
        text-align: left;
        font-size: 14px;
    }
    .log-table th {
        background-color: #4caf50;
        color: white;
    }
    .log-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .log-table tr:hover {
        background-color: #eef7ee;
    }
</style>

<h1>User Navigation Activity</h1>

<?php if (!empty($logs)): ?>
    <table class="log-table">
        <thead>
            <tr>
                <th>User ID</th>
                <th>Latitude</th>
                <th>Longitude</th>
                <th>Time</th>
                <th>Encrypted Sensors</th>
                <th>IV</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($logs as $log): ?>
                <tr>
                    <td><?php echo htmlspecialchars($log['user_id']); ?></td>
                    <td><?php echo htmlspecialchars($log['last_latitude']); ?></td>
                    <td><?php echo htmlspecialchars($log['last_longitude']); ?></td>
                    <td><?php echo htmlspecialchars($log['time']); ?></td>
                    <td><?php echo htmlspecialchars($log['encrypted_page_name']); ?></td>
                    <td><?php echo htmlspecialchars($log['iv']); ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
<?php endif; ?>

<?php include '../footer.php'; ?>