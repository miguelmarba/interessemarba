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
        
        $idContacto = $data['idContacto'];
        $nombre     = $data['nombre'];
        $apellidos  = $data['apellidos']; 
        $direccion  = $data['direccion'];
        $email      = $data['email'];
        $telefonos  = $this->getRequest()->getPost('telefonos',0);
        
        $Contacto = new Interesse_Model_Contacto();
        $id = $Contacto->save($nombre, $apellidos, $direccion, $email, $idContacto);
        
        if( $telefonos !=0 ){
            $Telefono = new Interesse_Model_Telefono();
            foreach ($telefonos as $numero):
                $idTel = $Telefono->save($numero, $id, 1);
            endforeach;
        }
        
        try{
            $responce['result'] = 'success';
            $responce['id'] = $id;
            $responce['msg'] = 'El contacto se guardó correctamente. Id: ' . $id;
            echo json_encode($responce);exit;
        }catch(Exception $e){
            echo $e->getMessage();
        }
    }

    public function getAction()
    {
        //Desabilitamos el LAYOUT
        $this->_helper->layout->disableLayout();
        //Desabilitamos la VISTA
        //$this->_helper->viewRenderer->setNoRender();
        
        $data = $this->getRequest()->getPost();
        $id     = $data['id'];
        
        $Contacto = new Interesse_Model_Contacto();
        $detalle = $Contacto->getId($id);
        
        try{
            if($detalle){
                $idContacto = $detalle[0]['id'];
                $responce['result'] = 'success';
                $responce['id'] = $detalle[0]['id'];
                $responce['nombres'] = $detalle[0]['nombres'];
                $responce['apellidos'] = $detalle[0]['apellidos'];
                $responce['direccion'] = $detalle[0]['direccion'];
                $responce['email'] = $detalle[0]['email'];
                
                //Listamos los numeros de telefonos
                $telefonos = array();
                $Telefono = new Interesse_Model_Telefono();
                $listaTels = $Telefono->getByContactoId($idContacto);
                foreach ($listaTels as $item):
                    $telefonos[] = array('id' => $item['id'], 'numero' => $item['numero']);
                endforeach;
                $responce['telefonos'] = $telefonos;
            } else {
                $responce['result'] = 'false';
                $responce['id'] = $id;
                $responce['msg'] = 'El contacto no existe.';
            }
            
            echo json_encode($responce);exit;
        }catch(Exception $e){
            echo $e->getMessage();exit;
        }
    }
    
    public function removeAction()
    {
        $data = $this->getRequest()->getPost();
        
        $id = $data['id'];
        
        $Contacto = new Interesse_Model_Contacto();
        $res = $Contacto->remove($id);
        
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