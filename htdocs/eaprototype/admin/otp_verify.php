<?php

session_start();
echo "Psst. Your OTP is " . $_SESSION["otp"];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $otp = $_POST['otp'];

    if ($otp == $_SESSION["otp"]) {
        // Redirect to dashboard on success
        $_SESSION["status"] = TRUE;
        header('Location: dashboard.php');
        exit();
    } else {
        $message = "Invalid OTP or email address.";
    }
}

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification | Admin Panel</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
    <link href="style.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="favicon.ico">
  </head>
  <body>
    <?php include('login_header.php'); ?>
    <form action="otp_verify.php" method="POST">
      <div class="center">
        <img style="max-width: 100%" src="logo.png" alt="Logo">
        <h1 style="text-align:center">Eye Assist</h1>
        <p style="text-align:center">Administration Page</p>
      </div>
      <h2>Enter OTP</h2>
      <?php if (!empty($message)) { ?>
        <p><?php echo $message; ?></p>
      <?php } ?>
      <label for="otp">OTP sent to your email:</label>
      <input type="text" name="otp" id="otp" required>
      <button type="submit">Verify OTP</button>
    </form>
    <?php include('login_footer.php'); ?>
  </body>
  <?php if (!empty($message)) { ?>
		<script>
			Swal.fire({
				title: 'OTP Failed!',
				text: '<?php echo $message; ?>',
				icon: 'error',
				confirmButtonText: 'Try Again'
			});
		</script>
	<?php } ?>
</html>