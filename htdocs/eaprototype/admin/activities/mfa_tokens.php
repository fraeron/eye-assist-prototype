<?php 
include '../header.php'; 
require_once "../../db.php";

$sql = "SELECT id, user_id, token, created_at, expires_at FROM mfa_tokens ORDER BY created_at DESC";
$result = $db->query($sql);

$mfa_tokens = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $mfa_tokens[] = $row;
    }
} 

?>

<style>
        h1 {
            text-align: center;
            color: #2e7d32;
        }
        .table-container {
            margin: 20px auto;
            width: 100%; /* Full width of the parent container */
            max-width: 100%; /* No max-width limitation */
            overflow-x: auto; /* Enable horizontal scrolling on small screens */
        }
        .mfa-table {
            width: 100%; /* Take up full width of its parent */
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }
        .mfa-table th, .mfa-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
            font-size: 14px;
        }
        .mfa-table th {
            background-color: #4caf50;
            color: white;
        }
        .mfa-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .mfa-table tr:hover {
            background-color: #eef7ee;
        }
    </style>
</head>

<h1>User OTP Tokens</h1>
<?php if (!empty($mfa_tokens)): ?>
    <div class="table-container">
        <table class="mfa-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Token</th>
                    <th>Created At</th>
                    <th>Expires At</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($mfa_tokens as $token): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($token['id']); ?></td>
                        <td><?php echo htmlspecialchars($token['user_id']); ?></td>
                        <td><?php echo htmlspecialchars($token['token']); ?></td>
                        <td><?php echo htmlspecialchars($token['created_at']); ?></td>
                        <td><?php echo htmlspecialchars($token['expires_at']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
<?php else: ?>
    <p>No OTP tokens found.</p>
<?php endif; ?>

<?php include '../footer.php'; ?>