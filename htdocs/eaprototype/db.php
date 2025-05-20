<?php
// Database connection settings
$host = 'localhost';         // Your database host
$username = 'root';          // Your database username
$password = '';              // Your database password
$dbname = 'prototype';   // Your database name

// Create a new MySQLi connection
$db = new mysqli($host, $username, $password, $dbname);

// Check if the connection was successful
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

// Set the charset for the connection (optional, but recommended)
$db->set_charset("utf8");
?>
