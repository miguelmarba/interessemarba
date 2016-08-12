<?php

class Interesse_Model_Telefono
{
    public function getList()
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_TELEFONOS_GETLIST()");
        return $data = $stmt->fetchAll();
    }
    
    public function save($numero, $contactoId, $etiquetaId)
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_TELEFONOS_ADD('$numero', $contactoId, $etiquetaId, @id)");
        $stmt = $db->query("SELECT @id AS ID");
        $data = $stmt->fetchAll();
        return $data[0]["ID"];
    }
    
    public function getByContactoId($id)
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_TELEFONOS_GETCONTACTO($id)");
        $data = $stmt->fetchAll();
        return $data;
    }
}