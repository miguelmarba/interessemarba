<?php

class Interesse_Model_EtiquetaDed extends Zend_Db_Table_Abstract
{
    protected $_name = "etiquetas"; 
    protected $_primary = "id"; 
    
    public function getList()
    {
        return $etiquetas = $this->fetchAll();
    }
    
    public function getId($db)
    {
        //$db = Zend_Registry::get('db');
        var_dump($db);exit;
        $stmt = $db->query("CALL SP_ETIQUETAS_GETID(1)");
        $data = $stmt->fetchAll();
        Zend_Debug::dump($data,$label=null, $echo=false);exit;
        return $data;
    }
}