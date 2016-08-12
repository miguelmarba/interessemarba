<?php

class Interesse_Model_Contacto
{
    public function getList()
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_CONTACTOS_GETLIST()");
        return $data = $stmt->fetchAll();
    }
    
    public function save($nombre, $apellidos, $direccion, $email, $idContacto)
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("SELECT $idContacto INTO @id ");
        $stmt = $db->query("CALL SP_CONTACTO_ADD('$nombre', '$apellidos', '$direccion', '$email', @id)");
        $stmt = $db->query("SELECT @id AS ID");
        $data = $stmt->fetchAll();
        return $data[0]["ID"];
    }
    
    public function getId($id)
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_CONTACTOS_GETSINGLE($id)");
        $data = $stmt->fetchAll();
        return $data;
    }
}