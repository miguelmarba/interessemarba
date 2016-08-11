<?php

class ContactosController extends Saffron_AbstractController
{
    public function init()
    {
        /* Initialize action controller here */
        $this->view->baseUrl = $this->getRequest()->getBaseUrl();
    }

    public function indexAction()
    {
        
        $this->view->headTitle('Catalogo de contactos');
        /*
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
         * *
         */
    }
    
    public function listAction()
    {
        //Desabilitamos el LAYOUT
        $this->_helper->layout->disableLayout();
        //Desabilitamos la VISTA
        //$this->_helper->viewRenderer->setNoRender();
        
        $Contacto = new Interesse_Model_Contacto();
        $contactos = $Contacto->getList();
        $this->view->contactos = $contactos;
    }
    
    public function addAction()
    {
        $data = $this->getRequest()->getPost();
        
        $nombre     = $data['nombre'];
        $apellidos  = $data['apellidos']; 
        $direccion  = $data['direccion'];
        $email      = $data['email'];
        
        $Contacto = new Interesse_Model_Contacto();
        $id = $Contacto->save($nombre, $apellidos, $direccion, $email);
        //var_dump($id);exit;
        try{
            $responce['result'] = 'success';
            $responce['id'] = $id;
            $responce['msg'] = 'El contacto se guardó correctamente. Id: ' . $id;
            echo json_encode($responce);exit;
        }catch(Exception $e){
            echo $e->getMessage();
        }
    }

}