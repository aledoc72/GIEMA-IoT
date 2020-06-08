<?php

//require_once 'pruebita.php';
 require_once 'connect.php';




   $fecha = $argv[0];


  $sql = "SELECT valor FROM mensaje WHERE fecha='$fecha' AND sensor= 10";
 $datos = Array();

  $response = mysqli_query($conn, $sql);

  while ($row = mysqli_fetch_object($response)){
    $datos[] = $row;
  }
  echo json_encode ($datos);
mysqli_close($conn);
?>


<?php

if ($_SERVER['REQUEST_METHOD'] =='POST'){

    $username = $_POST['username'];
    $correo = $_POST['correo'];
    $clave = $_POST['clave'];
    $nombres = $_POST['nombres'];
    $apellidos = $_POST['apellidos'];
    //$tipo_usuario = $_POST['tipo_usuario'];

    $clave = password_hash($clave, PASSWORD_DEFAULT);

    require_once 'connect.php';

    $sql = "INSERT INTO usuario (username, clave, nombres, apellidos, correo, tipo_usuario) VALUES ('$username','$clave','$nombres','$apellidos','$correo','regular')";

    if ( mysqli_query($conn, $sql) ) {
        $result["success"] = "1";
        $result["message"] = "success";

        echo json_encode($result);
        mysqli_close($conn);

    } else {

        $result["success"] = "0";
        $result["message"] = "error";

        echo json_encode($result);
        mysqli_close($conn);
    }
}

?>
