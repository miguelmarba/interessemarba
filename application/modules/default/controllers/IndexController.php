<?php

class IndexController extends Saffron_AbstractController
{

    public function indexAction()
    {
        $this->view->headTitle('Hello Interesse');
        $Etiqueta = new Interesse_Model_Etiqueta();
        $etiqueta = $Etiqueta->getId(3);
        var_dump($etiqueta);exit;
        
        
        
        
        $Etiqueta = new Interesse_Model_Etiqueta();
        
        $etiqueta = $Etiqueta->getId($db);
        var_dump($etiqueta);exit;
        
        $etiquetas = $Etiqueta->fetchAll();
        //var_dump($etiquetas);exit;
        
        foreach ($etiquetas as $item):
            echo '----' . $item['nombre'] . ''; 
        endforeach;
        exit;
        $this->view->etiquetas = $Etiqueta->fetchAll();
    }

}