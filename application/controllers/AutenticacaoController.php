<?php

class AutenticacaoController extends Zend_Controller_Action {

    public function init() {
        /* Initialize action controller here */
    }

    public function indexAction() {
        return $this->_helper->redirector('entrar');
    }

    public function entrarAction() {
        $this->_flashMessenger = $this->_helper->getHelper('FlashMessenger');
        $this->view->messages = $this->_flashMessenger->getMessages();
        $formulario = new Application_Form_Autenticacao();
        $this->view->form = $formulario;
        if ($this->getRequest()->isPost()) {
            $dados = $this->getRequest()->getPost();
            if ($formulario->isValid($dados)) {
                $usuario = $formulario->getValue('usuario');
                $senha = $formulario->getValue('senha');

                $dbAdapter = Zend_Db_Table::getDefaultAdapter();

                $authAdapter = new Zend_Auth_Adapter_DbTable($dbAdapter);
                $authAdapter->setTableName('Credencial')
                        ->setIdentityColumn('usuario')
                        ->setCredentialColumn('senha');
                $authAdapter->setIdentity($usuario)
                        ->setCredential(hash('SHA512', $senha));

                $auth = Zend_Auth::getInstance();

                $result = $auth->authenticate($authAdapter);
                if ($result->isValid()) {
                    $info = $authAdapter->getResultRowObject(NULL, 'senha');
                    $storage = $auth->getStorage();
                    $storage->write($info);
                    return $this->_helper->redirector->goToRoute(array(
                        'controller' => 'index'
                    ), NULL, TRUE);
                } else {
                    $this->_helper->FlashMessenger('Credenciais inválidas');
                    $this->redirect('/autenticacao/entrar');
                }
            } else {
                $formulario->populate($dados);
            }
        }
    }

    public function sairAction() {
        $auth = Zend_Auth::getInstance();
        $auth->clearIdentity();
        return $this->_helper->redirector('index');
    }

}
