<?php



require_once 'connect.php';


$fecha = $_GET["fecha"];
  $sql = "SELECT valor FROM mensaje WHERE sensor = 20 and fecha='$fecha';";


 $datos = Array();

  $response = mysqli_query($conn, $sql);

  while ($row = mysqli_fetch_object($response)){
    $datos[] = $row;
  }
  echo json_encode ($datos);
mysqli_close($conn);
?>
