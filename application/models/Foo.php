<?php

class Interesse_Model_Foo
{   
    public function getId($db)
    {
        //$db = Zend_Registry::get('db');
        $stmt = $db->query("CALL SP_ETIQUETAS_GETID(1)");
        $data = $stmt->fetchAll();
        return $data;
    }
}