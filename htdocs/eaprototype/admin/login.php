<?php

require_once "../db.php";
session_start();
date_default_timezone_set('Asia/Manila');

// Handle OTP verification logic
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	$username = $_POST['username'];
	$password = $_POST['password'];

	$query = "SELECT * FROM admins WHERE username = ?";
	$stmt = $db->prepare($query);
	$stmt->bind_param('s', $username);
	$stmt->execute();
	$result = $stmt->get_result();
	$user = $result->fetch_assoc();

	// Initialize session login attempts
	if (!isset($_SESSION['login_attempts'])) {
		$_SESSION['login_attempts'] = 0;
	}

	// Too many attempts in session
	// if ($_SESSION['login_attempts'] >= 5) {
	// 	$message = "Too many login attempts from this session. Please wait before retrying.";
	// }

	if ($user) {
		$user_ip = $_SERVER['REMOTE_ADDR'] === '::1' ? '127.0.0.1' : $_SERVER['REMOTE_ADDR'];
		if (password_verify($password, $user['password'])) {

			$current_time = date('Y-m-d H:i:s');

			if (!is_null($user['lock_until']) && $user['lock_until'] > $current_time) {
                $message = 'Account is locked until ' . $user['lock_until'];
            } else {
				// Check if IP is allowed
				$stmt_ip = $db->prepare("SELECT * FROM allowed_ip WHERE allowed = ?");
				$stmt_ip->bind_param('s', $user_ip);
				$stmt_ip->execute();
				$ip_result = $stmt_ip->get_result();

				if ($ip_result->num_rows === 0) {
					$message = 'Access denied from this IP address.';
				} else {
					// Reset all failed attempts
					$stmt = $db->prepare("UPDATE admins SET failed_attempts = 0, lock_until = NULL WHERE id = ?");
					$stmt->bind_param('i', $user['id']);
					$stmt->execute();

					$_SESSION['login_attempts'] = 0; // Reset session attempts

					// Proceed with OTP
					$otp = rand(100000, 999999);
					$startTime = date("Y-m-d H:i:s");
					$expires_at = date('Y-m-d H:i:s', strtotime('+2 minutes', strtotime($startTime)));

					$stmt = $db->prepare("INSERT INTO admin_mfa_tokens (admin_id, token, expires_at) VALUES (?, ?, ?)");
					$stmt->bind_param('iss', $user['id'], $otp, $expires_at);
					$stmt->execute();

					$_SESSION['username'] = $username;
					$_SESSION['otp'] = $otp;

					// Redirect with a success message
					$_SESSION['login_success'] = true;
					// header("Location: https://localhost/eaprototype/admin/otp_verify.php");
					// exit();
				}
			}
		} else {
			$new_attempts = $user['failed_attempts'] + 1;
			$stmt = $db->prepare("UPDATE admins SET failed_attempts = ? WHERE id = ?");
			$stmt->bind_param('ii', $new_attempts, $user['id']);
			$stmt->execute();

			$_SESSION['login_attempts']++;

			if ($new_attempts >= 5) {
				$lock_until = date('Y-m-d H:i:s', strtotime('+30 minutes'));
				$stmt = $db->prepare("UPDATE admins SET lock_until = ? WHERE id = ?");
				$stmt->bind_param('si', $lock_until, $user['id']);
				$stmt->execute();

				$message = 'Too many failed attempts. Account locked until ' . $lock_until;
			} else {
				$message = 'Invalid credentials. Attempt ' . $new_attempts . ' of 5.';
			}
		}
	} else {
		$_SESSION['login_attempts']++;
		$message = 'Administrator does not exist.';
	}
}
?>

<!DOCTYPE html>
<html>
<head>
	<title>Log in | Eye Assist Admin Panel</title>
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
	<link href="style.css" rel="stylesheet">
	<link rel="icon" type="image/x-icon" href="favicon.ico">
</head>
<body>
	<?php include('login_header.php'); ?>
	<form action="login.php" method="POST">
		<div class="center">
			<img style="max-width: 100%" src="logo.png">
			<h1 style="text-align:center">Eye Assist</h1>
			<p style="text-align:center">Administration Page</p>
		</div>
		<h2>Log in</h2>
		<?php if (!empty($message)) { ?>
			<p style="color:red"><?php echo $message; ?></p>
		<?php } ?>
		<label for="username">Username:</label>
		<input type="text" name="username" id="username" required>
		<label for="password">Password:</label>
		<input type="password" name="password" id="password" required>
		<button type="submit">Log in</button>
	</form>
	<?php include('login_footer.php'); ?>

	<!-- Show SweetAlert success message if login is successful -->
	<?php if (isset($_SESSION['login_success']) && $_SESSION['login_success'] === true) { ?>
		<script>
			Swal.fire({
				title: 'Login Successful!',
				text: 'You are being redirected to the OTP verification page.',
				icon: 'success',
				confirmButtonText: 'OK'
			}).then(() => {
				// Clear session variable and redirect to OTP page
				<?php unset($_SESSION['login_success']); ?>
				window.location.href = 'https://localhost/eaprototype/admin/otp_verify.php';
			});
		</script>
	<?php } ?>

	<?php if (!empty($message)) { ?>
		<script>
			Swal.fire({
				title: 'Login Failed!',
				text: '<?php echo $message; ?>',
				icon: 'error',
				confirmButtonText: 'Try Again'
			});
		</script>
	<?php } ?>
</body>
</html>
