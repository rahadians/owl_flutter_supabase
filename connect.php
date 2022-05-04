<?php
//$connect = mysqli_connect("namalocalhost", "dbuser","dbpassword","dbname); 
$connect = mysqli_connect("localhost", "ramaruma_flutter","Tcare&8899","ramaruma_flutter");
if($connect){
    //  echo "Connection Succesfull";
} else {
    die("Connection Failed: " . mysqli_connect_error());
    mysqli_close($connect);
}

?>
