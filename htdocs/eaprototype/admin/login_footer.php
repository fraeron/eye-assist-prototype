<footer>
  <p>Copyright &copy; <?php echo date('Y'); ?> Eye Assist Team. All Rights Reserved.
    <?php if (isset($_SESSION['username'])) { ?>
      | Logged in as <?php echo $_SESSION['username']; ?>
    <?php } ?>
  </p>
</footer>
