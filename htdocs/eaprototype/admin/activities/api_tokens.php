<?php 

include '../header.php'; 

require_once "../../db.php";

$sql = "SELECT id, user_id, token, created_at, expires_at FROM api_tokens ORDER BY created_at DESC";
$result = $db->query($sql);

$tokens = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $tokens[] = $row;
    }
} else {
    echo "No API tokens found.";
}

?>
<style>
    h1 {
        text-align: center;
        color: #2c7be5;
        margin-bottom: 30px;
    }

    .table-container {
        width: 100%;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 800px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        overflow: hidden;
    }

    th, td {
        padding: 14px 18px;
        text-align: left;
        border-bottom: 1px solid #e0e0e0;
        font-size: 14px;
    }

    th {
        background-color: #2c7be5;
        color: white;
        font-weight: 600;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f7ff;
    }

    .token-cell {
        font-family: monospace;
        font-size: 13px;
        word-break: break-all;
    }
</style>

<h1>API Tokens</h1>
<p style="font-weight:bold">WARNING: Currently limited to local sensors.</p>
<?php if (!empty($tokens)): ?>
    <div class="table-container">
        <table>
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
                <?php foreach ($tokens as $token): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($token['id']); ?></td>
                        <td><?php echo htmlspecialchars($token['user_id']); ?></td>
                        <td class="token-cell"><?php echo htmlspecialchars($token['token']); ?></td>
                        <td><?php echo htmlspecialchars($token['created_at']); ?></td>
                        <td><?php echo htmlspecialchars($token['expires_at']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
<?php endif; ?>

<?php include '../footer.php'; ?>