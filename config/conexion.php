<?php
    
    class Conectar {

        protected $dbh;

        protected function conexion(){
            //empleamos Try Catch para el manejo de errores
            try{
                $conectar = $this-> dbh = new PDO ("mysql:local=localhost;dbname=dbinnpos","Admin","J0hnRestrepoH*/");

                return $conectar;
                } catch (Exeption $e) {

                    print "¡Error!: " . $e->getMessage(). "<br/>";
                    
                    die();
                }  
        }//cierre de la funcion conexion

        //en la siguiente funcion vamos hacer que nuestro codigo sea retro compatible con 
        //ASCII y pueda representar cualquier carácter Unicode estandar.
        public function set_names(){

            return $this->dbh->query("SET NAMES 'utf8");  
        }//cierre de la funcion set_names

        //vamos a definir la ruta local de la app
        public function ruta(){

            return "http://localhost/InnPos/";
        }
    } //cierre de la clase conectar