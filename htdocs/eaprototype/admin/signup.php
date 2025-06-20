<!DOCTYPE html>
<html>
  <head>
    <title>Create Account | Admin Panel</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="favicon.ico">
    <link href="style.css" rel="stylesheet">
  </head>
  <body>
    <?php include('login_header.php'); ?>
    <?php
      // Define the filename to use for the user data file
      $filename = 'users.txt';

      // Check if the form was submitted
      if (isset($_POST['username']) && isset($_POST['password']) && isset($_POST['confirm_password'])) {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $confirm_password = $_POST['confirm_password'];

        // Check if the username and password meet the required criteria
        if (strlen($username) >= 6 && strlen($password) >= 8 && preg_match('/[A-Za-z]/', $password) && preg_match('/[0-9]/', $password)) {
          // Check if the password and confirm password fields match
          if ($password === $confirm_password) {
            // Hash the password for storage
            $hashed_password = password_hash($password, PASSWORD_BCRYPT);

            // Create an array of user data
            $user_data = array(
              'username' => $username,
              'hashed_password' => $hashed_password
            );

            // Encode the user data as JSON
            $user_json = json_encode($user_data);

            // Open the user data file for appending
            $file_handle = fopen($filename, 'a');

            // Write the user data to the file
            fwrite($file_handle, $user_json . "\n");

            // Close the file handle
            fclose($file_handle);

            // Redirect the user to the login page
            header('Location: login.php');
            exit;
          } else {
            $message = 'Passwords do not match';
          }
        } else {
          $message = 'Username or password does not meet requirements';
        }
      }
    ?>
    <form action="signup.php" method="post">
      <div class="center">
        <img style="max-width: 100%" src="logo.png">
        <h1 style="text-align:center">Eye Assist</h1>
        <p style="text-align:center">Administration Page</p>
      </div>
      <h2>Create account</h2>
      <?php if (!empty($message)) { ?>
        <p><?php echo $message; ?></p>
      <?php } ?>
      <label for="username">Username:</label>
      <input type="text" name="username" id="username" required>
      <label for="password">Password:</label>
      <input type="password" name="password" id="password" required>
      <label for="confirm_password">Confirm password:</label>
      <input type="password" name="confirm_password" id="confirm_password" required>
      <button type="submit">Create account</button>
    </form>
    <?php include('login_footer.php'); ?>
  </body>
</html>

