<?php

class AutenticacaoController extends Zend_Controller_Action {

    public function init() {
        /* Initialize action controller here */
    }

    public function indexAction() {
        return $this->_helper->redirector('entrar');
    }

    public function entrarAction() {
        $this->configurarMensagem();
        $this->view->form = new Application_Form_Autenticacao();
        if ($this->getRequest()->isPost()) {
            $dadosInformados = $this->getRequest()->getPost();
            if ($this->view->form->isValid($dadosInformados)) {
                $adaptadorDeAutenticacao = $this->obterAdaptadorDeAutenticacao();
                $autenticacao = $this->obterAutenticidade($adaptadorDeAutenticacao);
                if ($autenticacao->isValid()) {
                    $this->guardarAutenticidade($adaptadorDeAutenticacao);
                    return $this->_helper->redirector->goToRoute(array(
                        'controller' => 'index'
                    ), NULL, TRUE);
                } else {
                    $this->_helper->FlashMessenger('Credenciais inválidas');
                    $this->redirect('/autenticacao/entrar');
                }
            } else {
                $this->view->form->populate($dadosInformados);
            }
        }
    }

    public function sairAction() {
        $autenticidade = Zend_Auth::getInstance();
        $autenticidade->clearIdentity();
        return $this->_helper->redirector('index');
    }

    private function configurarMensagem() {
        $this->_flashMessenger = $this->_helper->getHelper('FlashMessenger');
        $this->view->messages = $this->_flashMessenger->getMessages();
    }

    private function guardarAutenticidade(Zend_Auth_Adapter_DbTable $adaptadorDeAutenticacao) {
        $credencialSemSenha = $adaptadorDeAutenticacao->getResultRowObject(NULL, 'senha');
        Zend_Auth::getInstance()->getStorage()
                ->write($credencialSemSenha);
    }

    private function obterAdaptadorDeAutenticacao() {
        $adaptadorDeAutenticacao = new Zend_Auth_Adapter_DbTable(Zend_Db_Table::getDefaultAdapter());
        return $adaptadorDeAutenticacao->setTableName('Credencial')
                        ->setIdentityColumn('usuario')
                        ->setCredentialColumn('senha');
    }

    private function obterAutenticidade(Zend_Auth_Adapter_DbTable $adaptadorDeAutenticacao) {
        $formulario = $this->view->form;
        $adaptadorDeAutenticacao->setIdentity($formulario->getValue('usuario'))
                ->setCredential(hash('SHA512', $formulario->getValue('senha')));
        return Zend_Auth::getInstance()->authenticate($adaptadorDeAutenticacao);
    }

}
