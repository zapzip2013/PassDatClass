// Retrieved from https://github.com/danielriege/DRDatabase
// Improved and corrected by Jose Carlos

<?php

error_reporting(E_ERROR);

$DBservername = urlencode($_POST["h"]);

$DBusername = $_POST["u"];

$DBpassword = $_POST["p"];

$DBase = $_POST["d"];

$DBExecution = $_POST["e"];

function sendErrorMessage($code, $message) {

  $errorArray = array(array("error" => array("code" => $code, "description" => $message)));

  echo json_encode($errorArray);

  exit();

}

$conn = mysqli_connect($DBservername, $DBusername, $DBpassword, $DBase) or sendErrorMessage(mysqli_connect_errno(), mysqli_connect_error());

$resultArray = array();

$select = mysqli_query($conn, $DBExecution);


if($select === FALSE) {

    sendErrorMessage(mysqli_errno($conn), mysqli_error($conn));

}
while($row = mysqli_fetch_assoc($select))

{
    $rowencoded = $row;
    //$rowencoded["Photo"] = base64_encode($row["Photo"]);
    //$row["Photo"] = base64_encode($row["Photo"];
    $resultArray[] = $rowencoded;

}

$myJSON = json_encode($resultArray);

echo $myJSON;

mysql_close($conn);

?>

