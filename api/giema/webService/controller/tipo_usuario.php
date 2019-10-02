<?php
include "../config/config.php";
include "../utils/utils.php";


$dbConn =  connect($db);

/*
  listar todos los posts o solo uno
 */
if ($_SERVER['REQUEST_METHOD'] == 'GET')
{
    if (isset($_GET['nombre']))
    {
      //Mostrar un post
      $sql = $dbConn->prepare("SELECT * FROM tipo_usuario where nombre=:nombre");
      $sql->bindValue(':nombre', $_GET['nombre']);
      $sql->execute();
      header("HTTP/1.1 200 OK");

      echo json_encode(  $sql->fetch(PDO::FETCH_ASSOC)  );
      exit();
	  }
    else {
      //Mostrar lista de post
      $sql = $dbConn->prepare("SELECT * FROM tipo_usuario ");
      $sql->execute();
      $sql->setFetchMode(PDO::FETCH_ASSOC);
      header("HTTP/1.1 200 OK");
      echo json_encode( $sql->fetchAll()  );
      exit();
	}
}

// Crear un nuevo post
if ($_SERVER['REQUEST_METHOD'] == 'POST')
{




    $input = $_POST;
    $sql = "INSERT INTO tipo_usuario
          (nombre, descripcion)
          VALUES
          (:nombre, descripcion)";
    $statement = $dbConn->prepare($sql);
    bindAllValues($statement, $input);
    $statement->execute(array(":nombre"=> "premium",
                                    ":descripcion" =>"Usuaio premium"
                                   ));
    $postId = $dbConn->lastInsertId();
    if($postId)
    {
      $input['nombre'] = $postId;

      header("HTTP/1.1 200 OK");
      echo json_encode($input);
      exit();
      	 }


}

//Borrar
if ($_SERVER['REQUEST_METHOD'] == 'DELETE')
{
	$nombre = $_GET['nombre'];
  $statement = $dbConn->prepare("DELETE FROM tipo_usuario where nombre=:nombre");
  $statement->bindValue(':nombre', $nombre );
  $statement->execute();
	header("HTTP/1.1 200 OK");
	exit();
}

//Actualizar
if ($_SERVER['REQUEST_METHOD'] == 'PUT')
{
    $input = $_GET;
    $postId = $input['nombre'];
    $fields = getParams($input);

    $sql = "
          UPDATE tipo_usuario
          SET $fields
          WHERE nombre='$postId'
           ";

    $statement = $dbConn->prepare($sql);
    bindAllValues($statement, $input);

    $statement->execute();
    header("HTTP/1.1 200 OK");
    exit();
}


//En caso de que ninguna de las opciones anteriores se haya ejecutado
header("HTTP/1.1 400 Bad Request");

?>
