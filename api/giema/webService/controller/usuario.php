<?php
include "../config/config.php";
include "../utils/utils.php";


$dbConn =  connect($db);

/*
  listar todos los posts o solo uno
 */
if ($_SERVER['REQUEST_METHOD'] == 'GET')
{
    if (isset($_GET['username']))
    {
      //Mostrar un post
      $sql = $dbConn->prepare("SELECT * FROM usuario where username=:username");
      $sql->bindValue(':username', $_GET['username']);
      $sql->execute();
      header("HTTP/1.1 200 OK");

      echo json_encode(  $sql->fetch(PDO::FETCH_ASSOC)  );
      exit();
	  }
    else {
      //Mostrar lista de post
      $sql = $dbConn->prepare("SELECT * FROM usuario ");
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
    $sql = "INSERT INTO usuario
          (username, clave, nombres, apellidos, correo, tipo_usuario)
          VALUES
          (:username, :clave, :nombres, :apellidos, :correo, :tipo_usuario)";
    $statement = $dbConn->prepare($sql);
    bindAllValues($statement, $input);
    $statement->execute(/*array(":username"=> "username",
                                    ":clave"=>"clave",
                                    ":nombres" => "nombre",
                                    ":apellidos" => "apellidos",
                                    ":correo" => "correo",
                                    ":tipo_usuario" => "regular"
                                  )*/);
    $postId = $dbConn->lastInsertId();
    if($postId)
    {
      $input['username'] = $postId;

      header("HTTP/1.1 201 OK");
      echo json_encode($input);
      exit();
      	 }


}

//Borrar
if ($_SERVER['REQUEST_METHOD'] == 'DELETE')
{
	$username = $_GET['username'];
  $statement = $dbConn->prepare("DELETE FROM usuario where username=:username");
  $statement->bindValue(':username', $username );
  $statement->execute();
	header("HTTP/1.1 200 OK");
	exit();
}

//Actualizar
if ($_SERVER['REQUEST_METHOD'] == 'PUT')
{
    $input = $_GET;
    $postId = $input['username'];
    $fields = getParams($input);

    $sql = "
          UPDATE usuario
          SET $fields
          WHERE username='$postId'
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
