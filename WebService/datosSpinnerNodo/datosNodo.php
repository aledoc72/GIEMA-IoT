<?php



require_once 'connect.php';

  $sql = "SELECT nombreNodo from nodo";
 $datos = Array();

  $response = mysqli_query($conn, $sql);

  while ($row = mysqli_fetch_object($response)){
    $datos[] = $row;
  }
  echo json_encode ($datos);
mysqli_close($conn);
?>
