<?php

class Interesse_Model_Contacto
{
    public function getList()
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_CONTACTOS_GETLIST()");
        return $data = $stmt->fetchAll();
    }
    
    public function save($nombre, $apellidos, $direccion, $email)
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_CONTACTO_ADD('$nombre', '$apellidos', '$direccion', '$email', @id)");
        $stmt = $db->query("SELECT @id AS ID");
        $data = $stmt->fetchAll();
        return $data[0]["ID"];
    }
}