<?php

//conexion del modelo usuarios a la DbInnPos

require_once("../config/conexion.php");

class Usuario extends Conectar {

    //metodo para listar los usuarios 
    public function get_usuario(){

        //llamamos a las funciones conexion y set_names
        $conectar = parent::conexion();
        parent::set_names();

        //consulta en la tabla usuario de la dbInnPos
        $sql="select * from usuario";
        $sql=$conectar->prepare($sql);
        $sql->execute()

        return $resultado=$sql->fetchAll();
    }//cierre de la funcion get_usuario

    //metodo para registrar los usuarios
    public function registrar_usuario($nombre, $apellido, $identificacion, $telefono, $correo, $direccion, $cargo, $user, 
    $password, $password2, $fecha_ingreso, $estado){

        $conectar = parent::conexion();
        parent::set_names();

        $sql = "insert into usuario
        values(null,?,?,?,?,?,?,?,?,?,?,now(),? )";

        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $_POST["nombre"]);
        $sql->bindValue(2, $_POST["apellido"]);
        $sql->bindValue(3, $_POST["identificacion"]);
        $sql->bindValue(4, $_POST["telefono"]);
        $sql->bindValue(5, $_POST["correo"]);
        $sql->bindValue(6, $_POST["direccion"]);
        $sql->bindValue(7, $_POST["cargo"]);
        $sql->bindValue(8, $_POST["user"]);
        $sql->bindValue(9, $_POST["password"]);
        $sql->binValue(10, $_POST["password2"]);
        $sql->bindValue(11, $_POST["estado"]);
        $sql->excute();        

    }

    //metodo para editar los usuarios
    public function editar_usuario($id_usuario, $nombre, $apellido, $identificacion, $telefono, $correo, $direccion, $cargo, $user, 
    $password, $password2, $fecha_ingreso, $estado){

        $conectar = parent::conexion();
        parent::set_names();

        $sql="update usuarios set
        
        nombre=?,
        apellido=?,
        identificacion=?,
        telefono=?,
        correo=?,
        direccion=?,
        cargo=?,
        user=?,
        password=?,
        password2=?,
        estado

        where 

        id_usuario=?
        
        ";

        $sql->conectar->prepare($sql);

        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $_POST["nombre"]);
        $sql->bindValue(2, $_POST["apellido"]);
        $sql->bindValue(3, $_POST["identificacion"]);
        $sql->bindValue(4, $_POST["telefono"]);
        $sql->bindValue(5, $_POST["correo"]);
        $sql->bindValue(6, $_POST["direccion"]);
        $sql->bindValue(7, $_POST["cargo"]);
        $sql->bindValue(8, $_POST["user"]);
        $sql->bindValue(9, $_POST["password"]);
        $sql->binValue(10, $_POST["password2"]);
        $sql->bindValue(11, $_POST["estado"]);
        $sql->bindValue(12, $_POST["id_usuario"]);
        $sql->excute();        

    }

    //funcion para seleccionar el usuario segun su ID 
    public function get_usuario_id($id_usuario){

        $conectar=parent::conexion();
        parent::set_names();

        $sql = "select * from usuarios where id_usuario=?";
        $sql = $conectar->prepare($sql);

        $sql->bindValue(1, $id_usuario);
        $sql->execute();

        return $resultado=$sql->fetchAll();
    }

    //funcion para editar el estado del usuario activo o inactivo "0" activo "1" inactivo
    public function editar_estado($id_usuario, $estado){

        $conectar=parent::conexion();
        parent::set_names();
        
        //el parametro "est" se envia via ajax 
        if($_POST["est"]=="0"){

            $estado=1;

        } else{

            $estado=0;
        }

        $sql =  "update usuario set
        
        estado=?
        
        ";

        $sql=$conectar->prepare($sql);

        $sql->bindValue(1, $id_usuario);
        $sql->bindValue(2, $estado);
        $sql->execute();


    }

    //validacion de correo e identificacion del usuario para no tener usuarios repetidos
    public function get_correo_identificacion_usuario($identificacion, $correo){

        $conectar=parent::conexio();
        parent::set_names();

        $sql="select * from usuario where identificacion=? or correo=?";
        $sql=conectar->prepare($sql);
        
        $sql->bindValue(1, $identificacion);
        $sql->bindValue(2, $correo);
        $sql->excute();

        return $resultado=$sql->fetchAll();


    }
}


?>