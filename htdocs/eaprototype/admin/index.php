<?php

session_start();
if($_SESSION["status"]) {
    header("location:dashboard.php");
} else {
    header("location:login.php");
}
?>