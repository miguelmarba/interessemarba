<?php

class Interesse_Model_Etiqueta
{
    public function getList()
    {
        //return $etiquetas = $this->fetchAll();
    }
    
    public function getId($id)
    {
        $db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_ETIQUETAS_GETID($id)");
        $data = $stmt->fetchAll();
        return $data;
    }
}