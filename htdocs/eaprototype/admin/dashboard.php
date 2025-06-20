<?php 

include './header.php'; 

require_once "../db.php";

?>


<div class="row">
    <div class="col-lg-3 col-6">
        <div class="small-box bg-success">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM mfa_tokens");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>User OTP Keys</p>
            </div>
            <div class="icon">
                <i class="ion ion-bag"></i>
            </div>
            <a href="./activities/mfa_tokens.php" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-6">
        <div class="small-box bg-info">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM admins");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>Admin Registrations</p>
            </div>
            <div class="icon">
                <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-6">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM users");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>User Registrations</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i></a>
        </div>
    </div>

    <div class="col-lg-3 col-6">
        <div class="small-box bg-danger">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM allowed_ip");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>Allowed IPs</p>
            </div>
            <div class="icon">
                <i class="ion ion-pie-graph"></i>
            </div>
            <a href="./activities/allowed_ip.php" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
    <div class="col-lg-3 col-6">
        <div class="small-box bg-info">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM api_tokens");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>API Token Logs</p>
            </div>
            <div class="icon">
                <i class="ion ion-pie-graph"></i>
            </div>
            <a href="./activities/api_tokens.php" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
    <div class="col-lg-3 col-6">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM user_navigational_activity");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>User Navigation Logs</p>
            </div>
            <div class="icon">
                <i class="ion ion-pie-graph"></i>
            </div>
            <a href="./activities/user_navigation_logs.php" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
    <!-- <div class="col-lg-3 col-6">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3>
                <?php 
                    $query = $db->prepare("SELECT count(*) FROM sensor_data");
                    $query->execute();
                    echo $query->get_result()->fetch_row()[0];
                ?>
                </h3>
                <p>User Sensor Logs</p>
            </div>
            <div class="icon">
                <i class="ion ion-pie-graph"></i>
            </div>
            <a href="#" class="small-box-footer">More info
                <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div> -->

</div>

<?php include './footer.php'; ?>